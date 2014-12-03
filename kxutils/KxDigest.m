//
//  KxDigest.m
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

#import "KxDigest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation KxDigest

+ (BOOL) digestForItemAtPath:(NSString *)path
                         md5:(NSString **)outMD5
                        sha1:(NSString **)outSHA1
                      sha256:(NSString **)outSHA256;
{
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:path];
    if (!fh) {
        return NO;
    }
    
    CC_MD5_CTX md5ctx;
    CC_SHA1_CTX sha1ctx;
    CC_SHA256_CTX sha256ctx;
    
    if (outMD5) {
        CC_MD5_Init(&md5ctx);
    }
    
    if (outSHA1) {
        CC_SHA1_Init(&sha1ctx);
    }
    
    if (outSHA256) {
        CC_SHA256_Init(&sha256ctx);
    }
    
    NSData *chunk;
    
    do {
        
        @try { chunk = [fh readDataOfLength:1024*1024]; }
        @catch (NSException *exp) {
            [fh closeFile];
            return NO;
        }
        
        if (chunk.length) {
            if (outMD5) {
                CC_MD5_Update(&md5ctx, chunk.bytes, (CC_LONG)chunk.length);
            }
            if (outSHA1) {
                CC_SHA1_Update(&sha1ctx, chunk.bytes, (CC_LONG)chunk.length);
            }
            if (outSHA256) {
                CC_SHA256_Update(&sha256ctx, chunk.bytes, (CC_LONG)chunk.length);
            }
        }
        
    } while (chunk.length);
    
    [fh closeFile];
    
    if (outMD5) {
        
        Byte digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5_Final(digest, &md5ctx);
        
        NSMutableString *ms = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for (NSUInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
            [ms appendFormat:@"%02x", digest[i]];
        }
        *outMD5 = [ms copy];
    }
    
    if (outSHA1) {
        
        Byte digest[CC_SHA1_DIGEST_LENGTH];
        CC_SHA1_Final(digest, &sha1ctx);
        
        NSMutableString *ms = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
        for (NSUInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
            [ms appendFormat:@"%02x", digest[i]];
        }
        *outSHA1 = [ms copy];
    }
    
    if (outSHA256) {
        
        Byte digest[CC_SHA256_DIGEST_LENGTH];
        CC_SHA256_Final(digest, &sha256ctx);
        
        NSMutableString *ms = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
        for (NSUInteger i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
            [ms appendFormat:@"%02x", digest[i]];
        }
        *outSHA256 = [ms copy];
    }
    
    
    return YES;
}

+ (NSData *) sha1DigestData:(NSData *)data
{
    Byte digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    return [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
}

+ (NSData *) md5DigestData:(NSData *)data
{
    Byte digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, digest);
    return [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
}

+ (NSString *) sha1DigestString:(NSString *)string
{
    const char *str = string.UTF8String;
    Byte digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, (CC_LONG)strlen(str), digest);
    
    NSMutableString *ms = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", digest[i]];
    }
    return [ms copy];
}

+ (NSString *) md5DigestString:(NSString *)string
{
    const char *str = string.UTF8String;
    Byte digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), digest);
    
    NSMutableString *ms = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", digest[i]];
    }
    return [ms copy];
}

@end
