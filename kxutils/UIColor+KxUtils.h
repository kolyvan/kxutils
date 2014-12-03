//
//  UIColor+KxUtils.h
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

#import <UIKit/UIKit.h>

typedef struct {
    CGFloat red, green, blue, alpha;
} KxRGBA;

typedef struct {
    CGFloat hue, saturation, brightness, alpha;
} KxHSBA;


@interface UIColor (KxUtils)

+ (UIColor *) linedPatternColorWithFont:(UIFont *)font
                                  width:(CGFloat)width
                             lineOffset:(CGFloat)lineOffset
                              fillColor:(UIColor *)fillColor
                              horzColor:(UIColor *)horzColor
                              vertColor:(UIColor *)vertColor;

+ (UIColor *) lerpStartColor:(UIColor *)startColor
                    endColor:(UIColor *)endColor
                        time:(CGFloat)time;

+ (UIColor *) colorFromHexString:(NSString *)hexString;
+ (UIColor *) colorWithARGBValue:(NSUInteger) argb;
+ (UIColor *) colorWithRGBValue:(NSUInteger) argb;

- (KxRGBA) RGBA;
- (KxHSBA) HSBA;
- (UInt32) argbValue;

- (UIColor *) colorWithDeltaHue:(CGFloat)dH
                     saturation:(CGFloat)dS
                     brightness:(CGFloat)dB;

- (UIColor *) reverseColor;
- (UIColor *) grayscaleColor;
- (UIColor *) contrastingColor;
- (UIColor *) complementaryColor;

- (UIColor *) darken:(CGFloat)precent;
- (UIColor *) lighten:(CGFloat)precent;

- (NSArray *) analogousColors;
- (NSArray *) monochromaticColors;
- (NSArray *) triadColors;
- (NSArray *) tetradColors;
- (NSArray *) complementaryColors;

@end
