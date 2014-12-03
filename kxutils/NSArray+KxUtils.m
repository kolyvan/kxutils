//
//  NSArray+KxUtils.m
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

#import "NSArray+KxUtils.h"

@implementation NSArray (KxUtils)

- (NSArray *) tail
{
    return [self subarrayWithRange:NSMakeRange(1, self.count - 1)];
}

- (NSArray *) take:(NSInteger)n
{
    return [self subarrayWithRange:NSMakeRange(0, n)];
}

- (NSArray *) drop:(NSInteger)n
{
    return [self subarrayWithRange:NSMakeRange(n, self.count - n)];
}

- (NSArray *) sorted
{
    return [self sortedArrayUsingSelector:@selector(compare:)];
}

- (NSArray *) reverse
{
    return self.reverseObjectEnumerator.allObjects;
}

- (NSArray *) unique
{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id elem in self) {
        if (![ma containsObject:elem]) {
            [ma addObject:elem];
        }
    }
    
    return [ma copy];
}

- (NSArray *) shuffle
{
    NSMutableArray *ma = [self mutableCopy];
    [ma shuffle];
    return [ma copy];
}

- (NSArray *) map:(id(^)(id elem))block
{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        [ma addObject:block(elem)];
    }
    return [ma copy];
}

- (NSArray *) flatMap:(id(^)(id elem))block
{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        id r = block(elem);
        if (r) {
            [ma appendFlat:r];
        }
    }
    return [ma copy];
}

- (id) reduce:(id(^)(id acc, id elem))block // reduceLeft
{
    BOOL first = YES;
    id acc = nil;
    
    for (id elem in self) {
        
        if (first) {
            first = NO;
            acc = elem;
        } else {
            acc = block(acc, elem);
        }
    }
    
    return acc;
}

- (id) reduceRight:(id(^)(id elem, id acc))block
{
    return [self.reverse reduce:(id)^(id acc, id elem) {
        block(elem, acc);
    }];
}

- (id) fold:(id)start
       with:(id (^)(id acc, id elem))block // foldLeft
{
    id acc = start;
    for (id elem in self) {
        acc = block(acc, elem);
    }
    return acc;
}

- (id) foldRight:(id)start
            with:(id(^)(id elem, id acc))block
{
    return [self.reverse fold:start
                         with:(id)^(id acc, id elem) {
        block(elem, acc);
    }];
}

- (NSArray *) filter:(BOOL(^)(id elem))block
{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        if (block(elem)) {
            [ma addObject:elem];
        }
    }
    return [ma copy];
}

- (NSArray *) filterNot:(BOOL(^)(id elem))block
{
    return [self filter:^(id elem){ return (BOOL)!block(elem); }];
}

- (id) find:(BOOL(^)(id elem))block
{
    for (id elem in self) {
        if (block(elem)) {
            return elem;
        }
    }
    return nil;
}

@end


@implementation NSMutableArray (KxUtils)

- (void) appendFlat:(id)obj
{
    if ([obj isKindOfClass:[NSArray class]]) {
        
        [self addObjectsFromArray:obj];
        
    } else if ([obj conformsToProtocol:@protocol(NSFastEnumeration)]) {
        
        for (id p in obj) {
            [self addObject:p];
        }
        
    } else if ([obj respondsToSelector:@selector(objectEnumerator)]) {
        
        NSEnumerator *enumerator = [obj objectEnumerator];
        id p;
        while ((p = [enumerator nextObject])) {
            [self addObject:p];
        }
        
    } else {
        [self addObject:obj];
    }
}

- (void) push:(id)object
{
    if (object) {
        [self addObject:object];
    }
}

- (id) pop
{
    if (!self.count) {
        return nil;
    }
    
    id last = self.lastObject;
    [self removeLastObject];
    return last;
}

- (void) shuffle
{
    const NSUInteger count = self.count;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        const NSUInteger n = arc4random_uniform((UInt32)(count - i)) + i;
        if (i != n) {
            [self exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
    }
}

@end