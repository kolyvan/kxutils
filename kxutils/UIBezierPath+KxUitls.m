//
//  UIBezierPath+KxUitls.m
//  https://github.com/kolyvan/kxutils
//
//  Created by Kolyvan on 03.12.14.

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

#import "UIBezierPath+KxUitls.h"
@import CoreText;

@implementation UIBezierPath (KxUitls)

+ (UIBezierPath *)bezierPathWithLetter:(unichar)letter
                              fontName:(NSString *)fontName
                              fontSize:(CGFloat)fontSize
{
    UIBezierPath *path;
    
    CFStringRef cfString = fontName ? (__bridge CFStringRef)fontName : CFSTR(".PhoneFallback");
    
    if (!fontSize) {
        fontSize = 18.f;
    }
    
    CTFontRef ctFont = CTFontCreateWithName(cfString, fontSize, NULL);
    
    if (ctFont) {
        
        CGGlyph glyph;
        unichar chars[] = { letter };
        
        if (CTFontGetGlyphsForCharacters(ctFont, chars, &glyph, 1)) {
            
            CGPathRef letterPath = CTFontCreatePathForGlyph(ctFont, glyph, NULL);
            
            if (letterPath) {
                
                path = [UIBezierPath bezierPath];
                // [path moveToPoint: (CGPoint){0, -_markFont.descender}];
                [path appendPath:[UIBezierPath bezierPathWithCGPath:letterPath]];
                [path closePath];
                
                // mirror vertical
                const CGPoint center = {
                    CGRectGetMidX(path.bounds),
                    CGRectGetMidY(path.bounds)
                };
                
                CGAffineTransform scaleT = CGAffineTransformMakeScale(1.0f, -1.0f);
                CGAffineTransform t = CGAffineTransformIdentity;
                t = CGAffineTransformTranslate(t, center.x, center.y);
                t = CGAffineTransformConcat(scaleT, t);
                t = CGAffineTransformTranslate(t, -center.x, -center.y);
                [path applyTransform:t];
                
                CGPathRelease(letterPath);
                
            } else {
#ifdef DEBUG
                NSLog(@"bezierPathWithLetter unable create path for letter: %C", letter);
#endif
            }
            
        } else {
#ifdef DEBUG
            NSLog(@"bezierPathWithLetter unable get glyph for letter: %C", letter);
#endif
        }
        
        CFRelease(ctFont);
        
    } else {
#ifdef DEBUG
        NSLog(@"bezierPathWithLetter unable create font: %@", fontName);
#endif        
    }
    
    return path;
}

@end
