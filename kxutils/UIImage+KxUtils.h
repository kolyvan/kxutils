//
//  UIImage+KxUtils.h
//  https://github.com/kolyvan/kxutils
//
//  Created by Kolyvan on 01.12.14.

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

@interface UIImage (KxUtils)

+ (UIImage *) imageRectFillColor:(UIColor *)fillColor
                     strokeColor:(UIColor *)strokeColor
                            size:(CGSize)size;

+ (UIImage *) imageCircleFillColor:(UIColor *)fillColor
                       strokeColor:(UIColor *)strokeColor
                              size:(CGSize)size;

+ (UIImage *) imageGradientWithColors:(NSArray *)colors
                                 size:(CGSize)size;

+ (UIImage *)imageWithBezierPath:(UIBezierPath *)path
                       fillColor:(UIColor *)fillColor
                     strokeColor:(UIColor *)strokeColor;

+ (UIImage *)roundedImageFillColor:(UIColor *)fillColor
                       strokeColor:(UIColor *)strokeColor
                              size:(CGSize)size
                            radius:(CGFloat)radius;

- (UIImage *) resizedWithFactor:(CGFloat)factor;

- (UIImage *) resizedWithSize:(CGSize)size;

- (UIImage *) resizedWithSize:(CGSize)size
                   aspectFill:(BOOL)aspectFill
                    backColor:(UIColor *)backColor
                      quality:(CGInterpolationQuality)quality
                        scale:(CGFloat)scale;

- (UIImage *) duplicate;

- (UIImage *) duplicateWithBackColor:(UIColor *)backColor
                               scale:(CGFloat)scale;

- (CGAffineTransform)transformForOrientation:(CGSize)newSize;
- (BOOL) hasAlpha;

- (UIImage *) applyCIFilters:(NSArray *)filters
                      contex:(CIContext *)contex;

+ (UIImage *) imageFromCIImage:(CIImage*)ciImage
                        contex:(CIContext *)contex
                         scale:(CGFloat)scale;

@end
