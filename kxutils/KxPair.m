//
//  KxPair.m
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

#import "KxPair.h"

@implementation KxPair

+ (instancetype) first:(id)first second:(id)second;
{
    return [[KxPair alloc] initWithFirst:first second:second];
}

- (instancetype) initWithFirst:(id)first
                        second:(id)second
{
    self = [super init];
    if (self) {
        _first = first;
        _second = second;
    }
    return self;
}

- (KxPair *) swap
{
    return [[KxPair alloc] initWithFirst:_second second:_first];
}

- (BOOL) isEqualToPair:(KxPair *)other;
{
    return
    (_first == other.first || [_first isEqual:other.first]) &&
    (_second == other.second || [_second isEqual:other.second]);
}

- (BOOL) isEqual:(id)other
{
    if (self == other) {
        return YES;
    }
    
    if (!other) {
        return NO;
    }
    
    if (![other isKindOfClass:[KxPair class]]) {
        return NO;
    }
    
    return [self isEqualToPair:other];
}

- (NSUInteger) hash
{
    return [_first hash] * 31 + [_second hash];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"(%@,%@)", _first, _second];
}

#pragma mark - NSCopying

- (id) copyWithZone:(NSZone *) zone
{
    return [[KxPair allocWithZone:zone] initWithFirst:_first second:_second];
}

#pragma mark - NSCoding

- (id) initWithCoder:(NSCoder*)coder
{
    self = [super init];
    if (self) {
        
        if ([coder allowsKeyedCoding]) {
            
            _first   = [coder decodeObjectForKey:@"1"];
            _second  = [coder decodeObjectForKey:@"2"];
            
        } else {
            
            _first   = [coder decodeObject];
            _second  = [coder decodeObject];
        }
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder*)coder
{
    if ([coder allowsKeyedCoding]) {
        
        [coder encodeObject:_first  forKey:@"1"];
        [coder encodeObject:_second forKey:@"2"];
        
    } else {
        
        [coder encodeObject:_first];
        [coder encodeObject:_second];
    }    
}

@end

@implementation NSArray (KxPair)

- (NSArray *) zip:(NSArray *)other
{
    const NSInteger len = MIN(self.count, other.count);
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:len];
    for (NSInteger i = 0; i < len; ++i) {
        KxPair *pair = [KxPair first:self[i] second:other[i]];
        [ma addObject:pair];
    }
    return [ma copy];
}

- (NSArray *) zipWithIndex
{
    const NSInteger len = self.count;
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:len];
    for (NSInteger i = 0; i < len; ++i) {
        KxPair *pair = [KxPair first:self[i] second:@(i)];
        [ma addObject:pair];
    }
    return [ma copy];
}

- (KxPair *) unzip
{
    NSMutableArray *firsts = [NSMutableArray arrayWithCapacity:self.count];
    NSMutableArray *seconds = [NSMutableArray arrayWithCapacity:self.count];
    for (KxPair *pair in self) {
        [firsts addObject:pair.first];
        [seconds addObject:pair.second];
    }
    return [KxPair first:[firsts copy] second:[seconds copy]];
}

@end

@implementation NSDictionary (KxPair)

+ (NSDictionary *) dictionaryFromPairsArray:(NSArray *)pairs
{
    NSMutableDictionary *md = [NSMutableDictionary dictionaryWithCapacity:pairs.count];
    for (KxPair *pair in pairs) {
        if (pair.first && pair.second) {
            md[pair.first] = pair.second;
        }
    }
    return [md copy];
    
    //KxPair *pair = pairs.unzip;
    //return [NSDictionary dictionaryWithObjects:pair.second forKeys:pair.first];
}

- (NSArray *) toPairsArray
{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [ma addObject:[KxPair first:key second:obj]];
    }];
    return [ma copy];
}

@end