//
//  NSArray+KxUtils.h
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

#import <Foundation/Foundation.h>

typedef id(^KxUtilsBlock)(id elem);

@interface NSArray (KxUtils)

- (NSArray *) tail;
- (NSArray *) take:(NSInteger)n;
- (NSArray *) drop:(NSInteger)n;

- (NSArray*) sorted;
- (NSArray *) reverse;
- (NSArray *) unique;
- (NSArray *) shuffle;

- (NSArray *) map:(id(^)(id elem))block;
- (NSArray *) flatMap:(id(^)(id elem))block;

- (id) reduce:(id(^)(id acc, id elem))block; // reduceLeft
- (id) fold:(id)start with:(id (^)(id acc, id elem))block; // foldLeft
- (id) reduceRight:(id (^)(id acc, id elem))block;
- (id) foldRight:(id)start with:(id (^)(id elem, id acc))block;

- (NSArray *) filter:(BOOL(^)(id elem)) block;
- (NSArray *) filterNot:(BOOL(^)(id elem)) block;

- (id) find:(BOOL(^)(id elem))block;

@end

@interface NSMutableArray (KxUtils)

- (void) appendFlat: (id) obj;

- (void) push:(id) object;
- (id) pop;

- (void) shuffle;

@end