//
//  KxNetwork.m
//  https://github.com/kolyvan/kxutils
//
//  Created by Kolyvan on 02.12.14.

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

#import "KxNetwork.h"
#import <ifaddrs.h>
#import <netinet/in.h>
#import <arpa/inet.h>

static inline bool isRfc2396Alnum(UInt8 ch)
{
    return ('0' <= ch && ch <= '9')
    || ('A' <= ch && ch <= 'Z')
    || ('a' <= ch && ch <= 'z')
    || ch == '-'
    || ch == '_'
    || ch == '.'
    || ch == '!'
    || ch == '~'
    || ch == '*'
    || ch == '\''
    || ch == '('
    || ch == ')';
}


@implementation KxNetwork

+ (BOOL) needEscapeRFC2396:(NSString *)path
{
    for (NSUInteger i = 0; i < path.length; ++i) {
        
        const unichar ch = [path characterAtIndex:i];
        
        if (ch > 0xff) {
            return YES;
        }
        
        if (ch != '/' &&
            !isRfc2396Alnum((UInt8)(ch & 0xff))) {
            return YES;
        }
    }
    return NO;
}

+ (NSString *)escapeRFC2396String:(NSString *)string
{
    const NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    char inbuf[len+1];
    [string getCString:inbuf maxLength:len+1 encoding:NSUTF8StringEncoding];
    
    const UInt8 *p = (const UInt8 *)inbuf;
    const UInt8 *end = p + len;
    
    char outbuffer[len * 3 + 1];
    char *pout = outbuffer;
    
    while (p != end) {
        if (isRfc2396Alnum(*p)) {
            *pout++ = (char) *p++;
        } else {
            pout += snprintf(pout, 4, "%%%02x", (unsigned int)*p++ );
        }
    }
    
    *pout = '\0';
    
    return [NSString stringWithCString:outbuffer
                              encoding:NSASCIIStringEncoding];
}

+ (NSString *)escapeRFC2396Path:(NSString *)path
{
    NSMutableArray *components = [path.pathComponents mutableCopy];
    for (NSUInteger i = 0; i < components.count; ++i) {
        
        NSString *s = components[i];
        if (!(s.length == 1 && [s characterAtIndex:0] == '/')) {
            
            components[i] = [self escapeRFC2396String:s];
        }
    }
    return [NSString pathWithComponents:components];
}

+ (NSString *) IPv4AsString:(UInt32)ip
{
    char buf[INET_ADDRSTRLEN] = {0};
    if (!inet_ntop(AF_INET, &ip, buf, INET_ADDRSTRLEN)) {
        return nil;
    }
    return [NSString stringWithCString:buf encoding:NSASCIIStringEncoding];
}

+ (UInt32) stringAsIPv4:(NSString *)s
{
    UInt32 addr = 0;
    inet_pton(AF_INET, [s cStringUsingEncoding:NSASCIIStringEncoding], &addr);
    return addr;
}

+ (UInt32) dataAsIPv4:(NSData *)data
{
    if (data.length == sizeof(struct sockaddr_in)) {
        
        const struct sockaddr_in *sockaddr = (struct sockaddr_in *)data.bytes;
        return sockaddr->sin_addr.s_addr;
    }
    return 0;
}

+ (NSArray *) hostAddressesIPv4
{
    NSMutableArray *ma = [NSMutableArray array];
    
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    
    if ((getifaddrs(&addrs) == 0)) {
        
        cursor = addrs;
        while (cursor != NULL) {
            
            // only IPv4
            if (cursor->ifa_addr->sa_family == AF_INET) {
                
                struct sockaddr_in nativeAddr4;
                memcpy(&nativeAddr4, cursor->ifa_addr, sizeof(nativeAddr4));
                NSString *s = [self IPv4AsString:nativeAddr4.sin_addr.s_addr];
                if (s.length) {
                    [ma addObject:s];
                }
            }
            
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs(addrs);
    }
    
    return ma;
}

+ (BOOL) hasNetworkConnection
{
    NSArray *ips = [self hostAddressesIPv4];
    if (!ips.count ||
        (ips.count == 1 && [ips.lastObject isEqualToString:@"127.0.0.1"])) {
        
        return NO;
    }
    return YES;
}

+ (NSString *) crackURLString:(NSString *)urlString
                    outParams:(NSDictionary **)outParams
{
    const NSUInteger index = [urlString rangeOfString:@"?"].location;
    
    if (index == NSNotFound) {
        return urlString;
    }
        
    if (outParams) {
        
        NSString *query = [urlString substringFromIndex:index + 1];
        *outParams = [self parametersFromURLQuery:query];
    }
    
    return [urlString substringToIndex:index];
}

+ (NSDictionary *) parametersFromURLQuery:(NSString *)query
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    NSArray *kvs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *kv in kvs) {
        
        const NSRange r = [kv rangeOfString:@"="];
        if (r.location != NSNotFound) {
            
            NSString *key = [kv substringToIndex:r.location];
            NSString *val = [kv substringFromIndex:r.location + 1];
            
            if (key.length && val.length) {
                
                CFStringRef cfKey = CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault,
                                                                               (__bridge CFStringRef)key,
                                                                               CFSTR(""));
                
                CFStringRef cfVal = CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault,
                                                                               (__bridge CFStringRef)val,
                                                                               CFSTR(""));
                
                key = (__bridge_transfer NSString *)cfKey;
                val = (__bridge_transfer NSString *)cfVal;
                
                if (key.length && val.length) {
                    md[key] = val;
                }
            }
        }
    }
    
    return md.count ? [md copy] : nil;
}


@end
