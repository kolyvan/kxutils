//
//  NSFileManager+Kolyvan.m
//  https://github.com/kolyvan/kxutils
//
//  Created by Kolyvan on 27.11.14.

/*
 Copyright (c) 2014 Konstantin Bukreev All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "NSFileManager+KxUtils.h"
#import <sys/xattr.h>
#import <string.h>

static NSString *errorMessageWithPosixErr(int errnum);

@implementation NSFileManager (KxUtils)

- (BOOL) addExcludedFromBackupAttributeToItemAtPath:(NSString *)path
                                              error:(NSError **)error;
{
    NSURL *url = [NSURL fileURLWithPath:path];
    return [url setResourceValue:@YES
                          forKey:NSURLIsExcludedFromBackupKey
                           error:error];
}

- (BOOL) removeExcludedFromBackupAttributeToItemAtPath:(NSString *)path
                                                 error:(NSError **)error
{
    NSURL *url = [NSURL fileURLWithPath:path];
    return [url setResourceValue:@NO
                          forKey:NSURLIsExcludedFromBackupKey
                           error:error];
}

- (BOOL) hasExcludedFromBackupAttributeForItemAtPath:(NSString *)path
                                               value:(BOOL *)outValue
                                               error:(NSError **)error;
{
    NSURL *url = [NSURL fileURLWithPath:path];
    id value;
    if (![url getResourceValue:&value
                        forKey:NSURLIsExcludedFromBackupKey
                         error:error])
    {
        return NO;
    }
    
    if (outValue) {
        *outValue = [value boolValue];
    }
    
    return YES;
}

+ (BOOL) setCustomAttribute:(const char *)name
                      value:(NSString *)value
              forItemAtPath:(NSString *)path
                      error:(NSError **)outError

{
    const NSUInteger length = [value lengthOfBytesUsingEncoding:NSUTF8StringEncoding] + 1;
    
    char attrValue[length];
    [value getCString:attrValue maxLength:length encoding:NSUTF8StringEncoding];
    
    int result = setxattr(path.fileSystemRepresentation,
                          name,
                          attrValue,
                          length - 1, // skip term NULL
                          0,
                          0);
    
    if (result < 0) {
        
        if (outError) {
            
            const int errnum = errno;
            *outError = [NSError errorWithDomain:NSPOSIXErrorDomain
                                            code:errnum
                                        userInfo:@{ NSFilePathErrorKey : path,
                                                    NSLocalizedDescriptionKey : errorMessageWithPosixErr(errnum),
                                                    NSLocalizedFailureReasonErrorKey : path.lastPathComponent,
                                                    }];
        }
    }
    
    
    return result == 0;
}

+ (NSString *) customAttribute:(const char *)name
                 forItemAtPath:(NSString *)path
                         error:(NSError **)outError
{
    ssize_t result = getxattr(path.fileSystemRepresentation,
                              name,
                              0,
                              0,
                              0,
                              0);
    
    NSString *string;
    
    if (result > 0) {
        
        char attrValue[result + 1]; // add size for term NULL
        
        result = getxattr(path.fileSystemRepresentation,
                          name,
                          attrValue,
                          result,
                          0,
                          0);
        
        if (result > 0) {
            
            attrValue[result] = 0;
            string = [[NSString alloc] initWithUTF8String:attrValue];
        }
    }
    
    if (result < 0) {
        
        if (outError) {
            
            const int errnum = errno;
            *outError = [NSError errorWithDomain:NSPOSIXErrorDomain
                                            code:errnum
                                        userInfo:@{ NSFilePathErrorKey : path,
                                                    NSLocalizedDescriptionKey : errorMessageWithPosixErr(errnum),
                                                    NSLocalizedFailureReasonErrorKey : path.lastPathComponent,
                                                    }];
        }
        
        return nil;
    }
    
    return string;
}

- (BOOL) ensureFolderAtPath:(NSString *)path
                      error:(NSError **)error
{
    if (![self fileExistsAtPath:path]) {
        
        if (![self createDirectoryAtPath:path
             withIntermediateDirectories:YES
                              attributes:nil
                                   error:error])
        {
            return NO;
        }
    }
    
    return YES;
}

- (NSArray *) filesAtPath:(NSString *)path
{
    NSArray *contents = [self contentsOfDirectoryAtPath:path error:nil];
    if (!contents.count) {
        return nil;
    }
    
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:contents.count];
    
    for (NSString *item in contents) {
        
        if (![item hasPrefix:@"."]) {
            
            NSString *fullpath = [path stringByAppendingPathComponent:item];
            NSDictionary *attr = [self attributesOfItemAtPath:fullpath error:nil];
            if ([attr.fileType isEqual:NSFileTypeRegular]) {
                [ma addObject:item];
            }
        }
    }
    
    return ma.count ? [ma copy] : nil;
}

- (void) enumerateFilesAtPath:(NSString *)path
                        block:(void(^)(NSString *path, NSFileManager *fm, BOOL *stop))block
{
    NSDirectoryEnumerator *enumerator;
    
    enumerator = [self enumeratorAtURL:[NSURL fileURLWithPath:path]
            includingPropertiesForKeys:@[NSURLIsRegularFileKey,NSURLPathKey]
                               options:NSDirectoryEnumerationSkipsHiddenFiles
                          errorHandler:nil];
    
    for (NSURL *url in enumerator) {
        
        NSNumber *isRegular;
        if ([url getResourceValue:&isRegular
                           forKey:NSURLIsRegularFileKey
                            error:NULL] &&
            isRegular.boolValue)
        {
            NSString *filePath;
            if ([url getResourceValue:&filePath
                               forKey:NSURLPathKey
                                error:NULL])
            {
                BOOL stop = NO;
                block(filePath, self, &stop);
                if (stop) {
                    break;
                }
            }
        }
    }
}

- (void) enumerateFoldersAtPath:(NSString *)path
                          block:(void(^)(NSString *path, NSFileManager *fm, BOOL *stop))block
{
    NSDirectoryEnumerator *enumerator;
    
    enumerator = [self enumeratorAtURL:[NSURL fileURLWithPath:path]
            includingPropertiesForKeys:@[NSURLIsDirectoryKey,NSURLPathKey]
                               options:NSDirectoryEnumerationSkipsHiddenFiles
                          errorHandler:nil];
    
    for (NSURL *url in enumerator) {
        
        NSNumber *isDirectory;
        if ([url getResourceValue:&isDirectory
                           forKey:NSURLIsDirectoryKey
                            error:NULL] &&
            isDirectory.boolValue)
        {
            NSString *filePath;
            if ([url getResourceValue:&filePath
                               forKey:NSURLPathKey
                                error:NULL])
            {
                BOOL stop = NO;
                block(filePath, self, &stop);
                if (stop) {
                    break;
                }
            }
        }
    }
}

@end


static NSString *errorMessageWithPosixErr(int errnum)
{
    NSString *message;
    char buffer[1024] = {0};
    if (!strerror_r(errnum, buffer, sizeof(buffer))) {
        message = [NSString stringWithUTF8String:buffer];
    }
    if (!message.length) {
        message = [NSString stringWithFormat:@"ERR: %d", errnum];
    }
    return message;
}