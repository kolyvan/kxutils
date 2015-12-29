//
//  UIColor+KxUtils.m
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

#import "UIColor+KxUtils.h"

static inline CGFloat lerp(CGFloat a, CGFloat b, CGFloat t)
{
    return a + (b - a) * t;
}

static inline CGFloat addDegrees(CGFloat delta, CGFloat deg)
{
    deg += delta;
    if (deg > 360.f) {
        return deg - 360.f;
    } else if (deg < 0.f) {
        return -deg;
    }
    return deg;
}

@implementation UIColor (KxUtils)

+ (UIColor *) linedPatternColorWithFont:(UIFont *)font
                                  width:(CGFloat)width
                             lineOffset:(CGFloat)lineOffset
                              fillColor:(UIColor *)fillColor
                              horzColor:(UIColor *)horzColor
                              vertColor:(UIColor *)vertColor
{
    const CGSize size = {width, font.lineHeight};
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    [fillColor set];
    UIRectFill((CGRect){CGPointZero, size});
    
    if (horzColor) {
        
        CGRect lineRect = CGRectZero;
        lineRect.size = (CGSize){size.width, 1.f};
        lineRect.origin.y = floor(font.descender) + lineOffset;
        
        if (lineRect.origin.y < 0) {
            lineRect.origin.y = font.lineHeight + lineRect.origin.y;
        }
        
        [horzColor setFill];
        [[UIBezierPath bezierPathWithRect:lineRect] fill];
    }
    
    if (vertColor) {
        
        [vertColor setFill];
        
        CGRect lineRect = CGRectZero;
        lineRect.size = CGSizeMake(1, size.width);
        lineRect.origin.x = 1;
        
        [[UIBezierPath bezierPathWithRect:lineRect] fill];
        
        lineRect.origin.x += 2;
        [[UIBezierPath bezierPathWithRect:lineRect] fill];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *) lerpStartColor:(UIColor *)startColor
                    endColor:(UIColor *)endColor
                        time:(CGFloat)time
{
    const KxRGBA rgba0 = startColor.RGBA;
    const KxRGBA rgba1 = endColor.RGBA;
    
    return [UIColor colorWithRed:lerp(rgba0.red,   rgba1.red,   time)
                           green:lerp(rgba0.green, rgba1.green, time)
                            blue:lerp(rgba0.blue,  rgba1.blue,  time)
                           alpha:lerp(rgba0.alpha, rgba1.alpha, time)];
}

+ (UIColor *) colorFromHexString:(NSString *)hexString
{
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    
    if (hexString.length) {
        
        unsigned rgbValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        if ([scanner scanHexInt:&rgbValue]) {
            return [self colorWithARGBValue:(NSUInteger)(rgbValue | 0xff000000)];
        }
    }
    
    return nil;
}

+ (UIColor *) colorWithARGBValue:(NSUInteger) argb
{
    const NSUInteger a = (argb >> 24) & 0xff;
    const NSUInteger r = (argb >> 16) & 0xff;
    const NSUInteger g = (argb >>  8) & 0xff;
    const NSUInteger b = (argb      ) & 0xff;
    
    return [UIColor colorWithRed:r / 255.f
                           green:g / 255.f
                            blue:b / 255.f
                           alpha:a / 255.f];
    
}

+ (UIColor *) colorWithRGBValue:(NSUInteger) argb
{
    const NSUInteger r = (argb >> 16) & 0xff;
    const NSUInteger g = (argb >>  8) & 0xff;
    const NSUInteger b = (argb      ) & 0xff;
    
    return [UIColor colorWithRed:r / 255.f
                           green:g / 255.f
                            blue:b / 255.f
                           alpha:1.0f];
    
}

- (KxRGBA) RGBA
{
    KxRGBA rgba = {0};
    
    CGColorRef cgColor = self.CGColor;
    const CGFloat *components = CGColorGetComponents(cgColor);
    const CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(cgColor));
    
    if (model == kCGColorSpaceModelMonochrome) {
        
        rgba.blue = rgba.green = rgba.red = components[0];
        rgba.alpha = components[1];
        
    } else if (model == kCGColorSpaceModelRGB) {
        
        rgba.red    = components[0];
        rgba.green  = components[1];
        rgba.blue   = components[2];
        rgba.alpha  = components[3];
        
    } else {
        
        // unsupported
        rgba.blue = rgba.green = rgba.red = 0;
        rgba.alpha = 1;
    }
    
    return rgba;
}

- (KxHSBA) HSBA
{
    KxHSBA hsba = {0};
    
    if (![self getHue:&hsba.hue
           saturation:&hsba.saturation
           brightness:&hsba.brightness
                alpha:&hsba.alpha])
    {
        // try convert at first
        
        const KxRGBA rgba = self.RGBA;
        UIColor *color = [UIColor colorWithRed:rgba.red
                                         green:rgba.green
                                          blue:rgba.blue
                                         alpha:rgba.alpha];
        
        [color getHue:&hsba.hue
           saturation:&hsba.saturation
           brightness:&hsba.brightness
                alpha:&hsba.alpha];
    }
    
    return hsba;
}

- (UInt32) argbValue
{
    KxRGBA rgba = self.RGBA;

    const UInt32 a = (UInt32)(rgba.alpha * 255.f);
    const UInt32 r = (UInt32)(rgba.red   * 255.f);
    const UInt32 g = (UInt32)(rgba.green * 255.f);
    const UInt32 b = (UInt32)(rgba.blue  * 255.f);
    
    return ((a & 0xff) << 24) | ((r & 0xff) << 16) | ((g & 0xff) << 8) | (b & 0xff);
}

- (UIColor *) colorWithDeltaHue:(CGFloat)dH
                     saturation:(CGFloat)dS
                     brightness:(CGFloat)dB
{
    KxHSBA hsba = self.HSBA;
    
    hsba.hue *= 360.f;
    hsba.saturation *= 100.f;
    hsba.brightness *= 100.f;
    
    hsba.hue += dH;
    
    if (hsba.hue < 0.f)    hsba.hue = -hsba.hue;
    if (hsba.hue > 360.f)  hsba.hue = hsba.hue - 360.f;
    
    return [UIColor colorWithHue:hsba.hue/360.f
                      saturation:(hsba.saturation+dS)/100.f
                      brightness:(hsba.brightness+dB)/100.f
                           alpha:hsba.alpha];
    
}

- (UIColor *)reverseColor
{
    CGColorRef cgColor0 = self.CGColor;
    
    const NSUInteger num = CGColorGetNumberOfComponents(cgColor0);
    
    if (num == 1) {
        return self;
    }
    
    CGFloat white = 0;
    if ([self getWhite:&white alpha:nil]) {
        
        if (white >= 0.5f && white < 0.67f) {
            return [UIColor darkGrayColor];
        } else if (white > 0.3f && white < 0.5f) {
            return [UIColor blackColor];
        }
    }
    
    const CGFloat *colors0 = CGColorGetComponents(cgColor0);
    CGFloat colors1[num];
    
    NSInteger i = num - 1;
    colors1[i] = colors0[i]; // alpha
    while (--i >= 0) {
        colors1[i] = 1.f - colors0[i];
    }
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace(cgColor0);
    CGColorRef cgColor1 = CGColorCreate(colorSpace, colors1);
    UIColor *result = [UIColor colorWithCGColor:cgColor1];
    CGColorRelease(cgColor1);
    //CGColorSpaceRelease(colorSpace);
    
    return result;
}

- (UIColor *) grayscaleColor
{
    const KxRGBA rgba = self.RGBA;
    const CGFloat v = ((0.299f * rgba.red) + (0.587 * rgba.green) + (0.114 * rgba.blue));
    return [UIColor colorWithWhite:v alpha:rgba.alpha];
}

// black or white
- (UIColor *) contrastingColor
{
    const KxRGBA rgba = self.RGBA;
    const CGFloat v = 1.0f - ((0.299f * rgba.red) + (0.587 * rgba.green) + (0.114 * rgba.blue));
    return v < 0.5f ? [UIColor blackColor] : [UIColor whiteColor];
}

// color directly opposite it on the color wheel
- (UIColor *) complementaryColor
{
    const KxHSBA hsba = self.HSBA;
    
    if (hsba.brightness == 0) {
        return [UIColor whiteColor];
    } else if (hsba.saturation == 0) {
        return [UIColor colorWithHue:hsba.hue saturation:0 brightness:1.f-hsba.brightness alpha:hsba.alpha];
    } else {
        const CGFloat hue = addDegrees(180.f, hsba.hue * 360.f) / 360.f;
        return [UIColor colorWithHue:hue saturation:hsba.saturation brightness:hsba.brightness alpha:hsba.alpha];
    }
}

- (UIColor *) darken:(CGFloat)precent
{
    const KxHSBA hsba = self.HSBA;
    
    return [UIColor colorWithHue:hsba.hue
                      saturation:hsba.saturation
                      brightness:hsba.brightness * precent
                           alpha:hsba.alpha];
}

- (UIColor *) lighten:(CGFloat)precent
{
    const KxHSBA hsba = self.HSBA;
    
    return [UIColor colorWithHue:hsba.hue
                      saturation:hsba.saturation
                      brightness:hsba.brightness * (precent + 1.0f)
                           alpha:hsba.alpha];
}

- (NSArray *) analogousColors
{
    const KxHSBA hsba = self.HSBA;
    
    return @[
             
             [UIColor colorWithHue:addDegrees(30.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation
                        brightness:hsba.brightness
                             alpha:hsba.alpha],
             
             [UIColor colorWithHue:addDegrees(15.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation * 1.166f
                        brightness:hsba.brightness - 0.05f
                             alpha:hsba.alpha],
             
             [UIColor colorWithHue:addDegrees(-15.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation * 1.166f
                        brightness:hsba.brightness - 0.05f
                             alpha:hsba.alpha],
             
             [UIColor colorWithHue:addDegrees(-30.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation
                        brightness:hsba.brightness
                             alpha:hsba.alpha],
             
             ];
}


- (NSArray *) monochromaticColors
{
    const KxHSBA hsba = self.HSBA;
    
    return @[
             [UIColor colorWithHue:hsba.hue
                        saturation:hsba.saturation
                        brightness:hsba.brightness * 0.25f
                             alpha:hsba.alpha],
             
             [UIColor colorWithHue:hsba.hue
                        saturation:hsba.saturation
                        brightness:hsba.brightness * 0.50f
                             alpha:hsba.alpha],
             
             [UIColor colorWithHue:hsba.hue
                        saturation:hsba.saturation
                        brightness:hsba.brightness * 0.75f
                             alpha:hsba.alpha],
             
             [UIColor colorWithHue:hsba.hue
                        saturation:hsba.saturation
                        brightness:hsba.brightness * 1.25f
                             alpha:hsba.alpha],
             ];
             
}

- (NSArray *) triadColors
{
    const KxHSBA hsba = self.HSBA;
    
    return @[
             
             [UIColor colorWithHue:addDegrees(120.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation
                        brightness:hsba.brightness
                             alpha:hsba.alpha],
             
             [UIColor colorWithHue:addDegrees(240.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation
                        brightness:hsba.brightness
                             alpha:hsba.alpha],
             
             ];
}

- (NSArray *) tetradColors
{
    const KxHSBA hsba = self.HSBA;
    
    return @[
             
             [UIColor colorWithHue:addDegrees(90.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation
                        brightness:hsba.brightness + (hsba.brightness > 0.5 ? 0.1f : -0.1f)
                             alpha:hsba.alpha],
             
             [UIColor colorWithHue:addDegrees(180.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation
                        brightness:hsba.brightness + (hsba.brightness > 0.5 ? 0.1f : -0.1f)
                             alpha:hsba.alpha],
             
             [UIColor colorWithHue:addDegrees(270.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation * 1.166f
                        brightness:hsba.brightness - 0.05f
                             alpha:hsba.alpha],
             
             ];
}

- (NSArray *) complementaryColors
{
    const KxHSBA hsba = self.HSBA;
    
    return @[
             
             [UIColor colorWithHue:addDegrees(150.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation
                        brightness:hsba.brightness
                             alpha:hsba.alpha],
             
             [UIColor colorWithHue:addDegrees(180.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation
                        brightness:hsba.brightness
                             alpha:hsba.alpha],
             
             [UIColor colorWithHue:addDegrees(210.f, hsba.hue * 360.f) / 360.f
                        saturation:hsba.saturation
                        brightness:hsba.brightness
                             alpha:hsba.alpha],
             
             ];
}

@end
