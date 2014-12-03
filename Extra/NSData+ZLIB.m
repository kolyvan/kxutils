//
//  NSData+ZLIB.m
//  https://github.com/kolyvan/kxutils
//
//  Created by Kolyvan on 28.11.14.

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

#import "NSData+ZLIB.h"
#import <zlib.h>

@implementation NSData (ZLIB)

- (NSData *) gzip
{
    return [self gzipAsZlib:YES];
}

- (NSData *) gzipAsZlib:(BOOL)asZLib
{
    if (self.length == 0) {
        return self;
    }
    
    z_stream zs;
    
    zs.next_in = (Bytef *)self.bytes;
    zs.avail_in = (uInt)self.length;
    zs.total_out = 0;
    zs.avail_out = 0;
    zs.zalloc = Z_NULL;
    zs.zfree = Z_NULL;
    zs.opaque = Z_NULL;
    
    NSMutableData *deflated = [NSMutableData dataWithLength:16384];
    
    if (Z_OK != deflateInit2(&zs,
                             Z_DEFAULT_COMPRESSION,
                             Z_DEFLATED,
                             MAX_WBITS+(asZLib ? 0 : 16),
                             8,
                             Z_DEFAULT_STRATEGY))
    {
        return nil;
    }
    
    do {
        
        if (zs.total_out >= deflated.length) {
            [deflated increaseLengthBy:16384];
        }
        
        zs.next_out = deflated.mutableBytes + zs.total_out;
        zs.avail_out = (uInt)(deflated.length - zs.total_out);
        int status =  deflate(&zs, Z_FINISH);
        
        if (Z_OK != status &&
            Z_STREAM_END != status)
        {
            return nil; // some error
        }
        
    } while (0 == zs.avail_out);
    
    deflateEnd(&zs);
    deflated.length = zs.total_out;
    
    return deflated;
}

- (NSData *) gunzip
{
    const NSUInteger halfLen = self.length / 2;
    
    NSMutableData *inflated = [NSMutableData dataWithLength:self.length + halfLen];
    
    z_stream zs;
    
    zs.next_in = (Bytef *)self.bytes;
    zs.avail_in = (uInt)self.length;
    zs.total_out = 0;
    zs.avail_out = 0;
    zs.zalloc = Z_NULL;
    zs.zfree = Z_NULL;
    zs.opaque = Z_NULL;
    
    if (Z_OK != inflateInit2(&zs, MAX_WBITS+32)) {
        return nil;
    }
    
    int status = Z_OK;
    while (Z_OK == status) {
        
        if (zs.total_out >= inflated.length) {
            [inflated increaseLengthBy:halfLen];
        }
        
        zs.next_out = inflated.mutableBytes + zs.total_out;
        zs.avail_out = (uInt)(inflated.length - zs.total_out);
        
        status = inflate(&zs, Z_SYNC_FLUSH);
    }
    
    if ((Z_STREAM_END == status) &&
        (Z_OK == inflateEnd(&zs)))
    {
        inflated.length = zs.total_out;
        return inflated;
    }
    
    return nil;
}

@end
