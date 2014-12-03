//
//  KxFilePath.m
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

#import "KxFilePath.h"

@implementation KxFilePath

+ (NSString *) resourcePath
{
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *) publicDataPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask,
                                                YES) lastObject];
}

+ (NSString *) privateDataPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
                                                          NSUserDomainMask,
                                                          YES) lastObject];
    
    
#ifndef __IPHONE_OS_VERSION_MAX_ALLOWED
    //append application name on Mac OS
    NSString *appBunleId = [[NSBundle mainBundle] bundleIdentifier];
    path = [path stringByAppendingPathComponent:appBunleId];
#endif

    return path;
}

+ (NSString *) cacheDataPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                          NSUserDomainMask,
                                                          YES) lastObject];
    
#ifndef __IPHONE_OS_VERSION_MAX_ALLOWED
    //append application bundle ID on Mac OS
    NSString *appBunleId = [[NSBundle mainBundle] bundleIdentifier];
    path = [path stringByAppendingPathComponent:appBunleId];
#endif

    return path;
}

+ (NSString *) temporaryDataPath
{
    NSString *path = NSTemporaryDirectory();
    if (!path)  {
        path = [self.cacheDataPath stringByAppendingPathComponent:@"Temporary Files"];
    }
    return path;
}

+ (NSString *) containerPath
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        
        return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                     NSUserDomainMask,
                                                     YES) lastObject] stringByDeletingLastPathComponent];

        
    } else {
        return [[[NSBundle mainBundle] bundlePath] stringByDeletingLastPathComponent];
    }
}

+ (NSString *) pathForResource:(NSString *)fileName
{
    return [self.resourcePath stringByAppendingPathComponent:fileName];
}

+ (NSString *) pathForPublicFile:(NSString *)fileName
{
    return [self.publicDataPath stringByAppendingPathComponent:fileName];
}

+ (NSString *) pathForPrivateFile:(NSString *)fileName
{
    return [self.privateDataPath stringByAppendingPathComponent:fileName];
}

+ (NSString *) pathForCacheFile:(NSString *)fileName
{
    return [self.cacheDataPath stringByAppendingPathComponent:fileName];
}

+ (NSString *) pathForTemporaryFile:(NSString *)fileName
{
    return [self.temporaryDataPath stringByAppendingPathComponent:fileName];
}

+ (NSString *) relativePathToContainer:(NSString *)path
{
    NSString *folder = [self containerPath];
    if ([path hasPrefix:folder]) {
        return [path substringFromIndex:folder.length + 1];
    }
    return nil;
}

+ (NSString *) unescapePath:(NSString *)path
{
    if ([path rangeOfString:@"%"].location != NSNotFound) {
        
        CFStringRef cfs = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                  (__bridge CFStringRef)path,
                                                                                  CFSTR(""),
                                                                                  kCFStringEncodingUTF8);
        if (cfs) {
            return (__bridge_transfer NSString *)cfs;
        }
    }
    return path;
}

+ (NSString *) escapePath:(NSString *)path
{
    const CFStringRef kCharsToForceEscape = CFSTR("!*'();:@&=+$,/?%#[]");
    
    CFStringRef cfs =  CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                               (__bridge CFStringRef)path,
                                                               NULL,
                                                               kCharsToForceEscape,
                                                               kCFStringEncodingUTF8);
    if (cfs) {
        return (__bridge_transfer  NSString *)cfs;
    }
    
    return path;
}

+ (NSString *) duplicatePath:(NSString *)path
                       index:(NSUInteger)index
{
    const NSRange r = [path rangeOfString:@"."];
    if (r.location == NSNotFound) {
        
        return [path stringByAppendingFormat:@"_%u", (unsigned)index];
        
    } else {
        
        NSString *s0 = [path substringToIndex:r.location];
        NSString *s1 = [path substringFromIndex:r.location+1];
        return [NSString stringWithFormat:@"%@_%u.%@", s0, (unsigned)index, s1];
    }
}

@end
