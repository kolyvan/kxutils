//
//  KxSerialization.m
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

#import "KxSerialization.h"

@implementation KxSerialization

+ (BOOL) saveObjectAsJson:(id)object
                   atPath:(NSString *)path
                    error:(NSError **)outError
{
    NSCParameterAssert(path.length);
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:object
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:outError];
    if (!data) {
        return NO;
    }
    
    return [data writeToFile:path options:0 error:outError];
}

+ (id) loadObjectFromJson:(NSString *)path
                    error:(NSError **)outError
{
    NSCParameterAssert(path.length);
    
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:outError];
    if (!data.length) {
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:outError];
}

+ (BOOL) saveObjectAsPlist:(id)object
                    atPath:(NSString *)path
                     error:(NSError **)outError
{
    NSCParameterAssert(path.length);
    
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:object
                                                              format:NSPropertyListBinaryFormat_v1_0
                                                             options:0
                                                               error:outError];
    if (!data) {
        return NO;
    }
    
    return [data writeToFile:path options:0 error:outError];
}

+ (id) loadObjectFromPlist:(NSString *)path
                     error:(NSError **)outError
{
    NSCParameterAssert(path.length);
    
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:outError];
    if (!data.length) {
        return nil;
    }
    
    return [NSPropertyListSerialization propertyListWithData:data
                                                     options:NSPropertyListImmutable
                                                      format:nil
                                                       error:outError];
}

@end
