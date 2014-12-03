//
//  NSLayoutManager+KxUtils.m
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

#import "NSLayoutManager+KxUtils.h"

@implementation NSLayoutManager (KxUtils)

- (void) addTextContainers:(NSUInteger)count
                  pageSize:(CGSize)pageSize
{
    for (NSUInteger i = 0; i < count; ++i) {
        
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:pageSize];
        textContainer.lineBreakMode = NSLineBreakByWordWrapping;
        [self addTextContainer:textContainer];
    }
}

- (NSRange) textRangeForTextContainer:(NSTextContainer *)textContainer
{
    const NSRange range = [self glyphRangeForTextContainer:textContainer];
    return [self characterRangeForGlyphRange:range actualGlyphRange:NULL];
}

- (NSUInteger) indexOfTextContainerWithStringLoc:(NSUInteger)stringLoc
{
    if (0 == stringLoc) {
        return 0;
    }
    
    if (stringLoc < self.textStorage.string.length) {
        
        const NSUInteger glyphIndex = [self glyphIndexForCharacterAtIndex:stringLoc];
        NSTextContainer *textContainer = [self textContainerForGlyphAtIndex:glyphIndex
                                                             effectiveRange:NULL];
        if (textContainer) {
            return [self.textContainers indexOfObject:textContainer];
        }
    }
    
    return NSNotFound;
}

@end
