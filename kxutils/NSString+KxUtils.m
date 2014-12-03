//
//  NSString+KxUtils.m
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

#import "NSString+KxUtils.h"

static NSInteger levenshteinDistance(unichar *s1, NSInteger n, unichar *s2, NSInteger m);

@implementation NSString (KxUtils)

+ (NSString *) uniqueString
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

+ (NSString *) randomAsciiString:(NSUInteger)numChars
{
    const char letters[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    const NSUInteger kNumLetters = sizeof(letters)/sizeof(letters[0]) - 1;
    
    NSMutableString *ms = [NSMutableString string];
    
    for (NSUInteger i = 0; i < numChars; ++i) {
        
        const NSUInteger index = arc4random_uniform(kNumLetters);
        const char letter = letters[index];
        [ms appendFormat:@"%c", letter];
    }
    
    return [ms copy];
}

- (BOOL) isLowercase
{
    NSCharacterSet *charset = [NSCharacterSet lowercaseLetterCharacterSet];
    return [charset isSupersetOfSet:[NSCharacterSet characterSetWithCharactersInString: self]];
}

- (BOOL) isUppercase
{
    NSCharacterSet *charset = [NSCharacterSet uppercaseLetterCharacterSet];
    return [charset isSupersetOfSet:[NSCharacterSet characterSetWithCharactersInString: self]];
}

- (NSString *) trimmed
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *) trimmedHead
{
    if (self.length) {
        
        NSCharacterSet *whites = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSInteger i = 0;
        for (; i < self.length; ++i) {
            
            const unichar ch = [self characterAtIndex:i];
            if (![whites characterIsMember:ch])
                break;
        }
        
        if (i == self.length) {
            return nil;
        }
        
        if (i != 0) {
            return [self substringFromIndex:i];
        }
    }
    
    return self;
}

- (NSString *) trimmedTail
{
    if (self.length) {
        
        NSCharacterSet *whites = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSInteger i = self.length - 1;
        for (; i >= 0 ; --i) {
            
            const unichar ch = [self characterAtIndex:i];
            if (![whites characterIsMember:ch])                
                break;
        }
        
        if (i < 0) {
            return nil;
        }
        
        if (i != self.length - 1) {
            return [self substringToIndex:i + 1];
        }
    }
    
    return self;
}

- (NSString *) stringByDeletingHTTPScheme
{
    if ([self hasPrefix:@"http://"]) {
        return [self substringFromIndex:@"http://".length];
    } else if ([self hasPrefix:@"https://"]) {
        return [self substringFromIndex:@"https://".length];
    }
    return self;
}

- (NSString *) stringByDeletingTrailingSlash
{
    if ([self hasSuffix:@"/"]) {
        return [self substringToIndex:self.length - 1];
    }
    return self;
}

- (NSString *) stripHTML:(BOOL)replaceBlockTagsWithNewLine
{
    NSMutableString *ms = [NSMutableString string];
    
    NSCharacterSet *spaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    
    while (!scanner.isAtEnd) {
        
        NSString *s, *tag = nil;
        
        if ([scanner scanUpToString:@"<" intoString:&s]) {
            [ms appendString:s];
        }
        
        if (![scanner scanString:@"<" intoString:nil]) {
            break;
        }
        
        if ([scanner scanUpToString:@">" intoString:&tag] &&
            [scanner scanString:@">" intoString:nil]) {
            
            if (replaceBlockTagsWithNewLine) {
                
                tag = [tag.lowercaseString stringByTrimmingCharactersInSet:spaces];
                
                if ([tag hasSuffix:@"/"]) { // for case of <br />
                    tag = [tag substringToIndex:tag.length-1];
                    tag = [tag stringByTrimmingCharactersInSet:spaces];
                }
                
                if ([tag isEqualToString:@"br"] ||
                    [tag isEqualToString:@"p"] ||
                    [tag isEqualToString:@"div"] ||
                    [tag isEqualToString:@"dd"] ||
                    [tag isEqualToString:@"blockquote"]) {
                    
                    [ms appendString:@"\n"];
                }
            }
            
        } else {
            
            [ms appendString:@"<"];
            if (tag.length)
                [ms appendString:tag];
        }
    }
    
    return ms;
}

- (NSInteger) levenshteinDistance:(NSString *) other
{
    const NSInteger n2 = other.length;
    
    unichar buffer2[n2];
    [other getCharacters:buffer2 range:NSMakeRange(0, n2)];
    
    const NSInteger n1 = self.length;
    
    unichar buffer1[n1];
    [self getCharacters:buffer1 range:NSMakeRange(0, n1)];
    
    return levenshteinDistance(buffer1, n1, buffer2, n2);
}

@end


static NSInteger levenshteinDistance(unichar *s1, NSInteger n, unichar *s2, NSInteger m)
{
    NSInteger d[n+1][m+1];
    
    for (NSInteger i = 0; i <= n; i++)
        d[i][0] = i;
    
    for (NSInteger i = 0; i <= m; i++)
        d[0][i] = i;
    
    for (NSInteger i = 1; i <= n; i++)
    {
        const NSInteger s1i = s1[i - 1];
        
        for (NSInteger j = 1; j <= m; j++)
        {
            const NSInteger s2j = s2[j - 1];
            const NSInteger cost = s1i == s2j ? 0 : 1;
            
            const NSInteger x = d[i-1][j  ] + 1;
            const NSInteger y = d[i  ][j-1] + 1;
            const NSInteger z = d[i-1][j-1] + cost;
            
            d[i][j] = MIN(MIN(x,y),z);
        }
    }
    return d[n][m];
}