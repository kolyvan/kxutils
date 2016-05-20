//
//  UIImage+KxUtils.m
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

#import "UIImage+KxUtils.h"
#import "UIColor+KxUtils.h"
#import "UIScreen+KxUtils.h"

@implementation UIImage (KxUtils)

+ (UIImage *) imageRectFillColor:(UIColor *)fillColor
                     strokeColor:(UIColor *)strokeColor
                            size:(CGSize)size
{
    const CGRect rect = {0, 0, size};
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (fillColor) {
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillRect(context, rect);
    }
    if (strokeColor) {
        CGContextSetLineWidth(context, 1.0f);
        CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
        CGContextStrokeRect(context, rect);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) imageCircleFillColor:(UIColor *)fillColor
                       strokeColor:(UIColor *)strokeColor
                              size:(CGSize)size
{
    const CGRect rect = {0, 0, size};
    const CGRect circleRect = CGRectInset(rect, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (fillColor) {
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillEllipseInRect(context, circleRect);
    }
    if (strokeColor) {
        CGContextSetLineWidth(context, 1.0f);
        CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
        CGContextStrokeEllipseInRect(context, circleRect);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) imageGradientWithColors:(NSArray *)colors
                                 size:(CGSize)size
{
    NSCParameterAssert(colors.count > 0);

    const CGFloat W = size.width;
    const CGFloat H = size.height;
    const NSUInteger kNumColors = colors.count;
    CGFloat locations[kNumColors];
    CGFloat components[kNumColors * 4];
    
    for (NSUInteger i = 0; i < kNumColors; i++) {
        
        locations[i] = i / (CGFloat)(kNumColors - 1);
        
        UIColor *color = colors[i];
        const KxRGBA rgba = color.RGBA;
        
        components[4*i+0] = rgba.red;
        components[4*i+1] = rgba.green;
        components[4*i+2] = rgba.blue;
        components[4*i+3] = rgba.alpha;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, kNumColors);
    
    const CGPoint endPoint = size.width > size.height ? (CGPoint){W, 0} : (CGPoint){0, H};
    CGContextDrawLinearGradient(context, gradient, CGPointZero, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(rgbColorspace);
    
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return gradientImage;
}

+ (UIImage *)imageWithBezierPath:(UIBezierPath *)path
                       fillColor:(UIColor *)fillColor
                     strokeColor:(UIColor *)strokeColor
{
    const CGSize size = {
        path.bounds.origin.x * 2.f + path.bounds.size.width,
        path.bounds.origin.y * 2.f + path.bounds.size.height
    };
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    if (fillColor) {
        [fillColor set];
        [path fill];
    }
    
    if (strokeColor) {
        [strokeColor set];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)roundedImageFillColor:(UIColor *)fillColor
                       strokeColor:(UIColor *)strokeColor
                              size:(CGSize)size
                            radius:(CGFloat)radius
{
    const CGRect rect = { 0, 0, size };
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    return [UIImage imageWithBezierPath:path fillColor:fillColor strokeColor:strokeColor];
}

- (UIImage *) resizedWithFactor:(CGFloat)factor
{
    const CGSize size = { self.size.width * factor, self.size.height * factor };
    return [self resizedWithSize:size
                      aspectFill:NO
                       backColor:[UIColor clearColor]
                         quality:kCGInterpolationDefault
                           scale:self.scale];
}

- (UIImage *) resizedWithSize:(CGSize)size
{
    return [self resizedWithSize:size
                      aspectFill:NO
                       backColor:[UIColor clearColor]
                         quality:kCGInterpolationDefault
                           scale:self.scale];
}

- (UIImage *) resizedWithSize:(CGSize)size
                   aspectFill:(BOOL)aspectFill
                    backColor:(UIColor *)backColor
                      quality:(CGInterpolationQuality)quality
                        scale:(CGFloat)scale
{
    if (scale <= 0) {
        scale = self.scale;
    }
    
    size.width *= scale;
    size.height *= scale;
    
    CGImageRef selfImageRef = self.CGImage;
    
    const CGSize imgSize = {
        CGImageGetWidth(selfImageRef),
        CGImageGetHeight(selfImageRef),
    };
    
    const CGFloat dW = size.width / imgSize.width;
    const CGFloat dH = size.height / imgSize.height;
    
    CGPoint drawOrigin = {0};
    CGSize drawSize = size;
    
    if (fabs(dW - dH) > 0.001f) { // dW != dH
        
        const CGFloat D = aspectFill ? MAX(dW, dH) : MIN(dW, dH);
        
        drawSize = (CGSize) { // actual image size
            imgSize.width  * D,
            imgSize.height * D,
        };
        
        drawOrigin.x = roundf((size.width - drawSize.width) * 0.5f);
        drawOrigin.y = roundf((size.height - drawSize.height) * 0.5f);
    }
    
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(selfImageRef);
    
    const uint32_t alpha = (bitmapInfo & kCGBitmapAlphaInfoMask);
    if (alpha == kCGImageAlphaNone) {
        
        bitmapInfo &= ~kCGBitmapAlphaInfoMask;
        bitmapInfo |= kCGImageAlphaNoneSkipFirst;
        
    } else if (alpha != kCGImageAlphaNoneSkipFirst &&
               alpha != kCGImageAlphaNoneSkipLast) {
        
        bitmapInfo &= ~kCGBitmapAlphaInfoMask;
        bitmapInfo |= kCGImageAlphaPremultipliedFirst;
    }
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 size.width,
                                                 size.height,
                                                 CGImageGetBitsPerComponent(selfImageRef),
                                                 0,
                                                 CGImageGetColorSpace(selfImageRef),
                                                 bitmapInfo);    
    CGImageRef imageRef = NULL;
    
    if (context) {
        
        if (backColor) {
            CGContextSetFillColorWithColor(context, backColor.CGColor);
            CGContextFillRect(context, (CGRect){0, 0, size});
        }
        
        const CGAffineTransform transform = [self transformForOrientation:size];
        CGContextConcatCTM(context, transform);
        CGContextSetInterpolationQuality(context, quality);
        
        CGRect rect;
        rect.origin = drawOrigin;
        rect.size = self.isTransposed ? (CGSize){drawSize.height, drawSize.width} : drawSize;
        
        CGContextDrawImage(context, rect, self.CGImage);
        imageRef = CGBitmapContextCreateImage(context);
        
        CGContextRelease(context);
    }
    
    UIImage *image;
    
    if (imageRef) {
        
        image = [UIImage imageWithCGImage:imageRef
                                    scale:scale
                              orientation:UIImageOrientationUp];
        
        CGImageRelease(imageRef);
    }
    
    return image;
}

- (UIImage *) duplicate
{
    return [self duplicateWithBackColor:nil
                                  scale:self.scale];
}

- (UIImage *) duplicateWithBackColor:(UIColor *)backColor
                               scale:(CGFloat)scale
{
    if (scale <= 0) {
        scale = self.scale;
    }
    
    const CGSize size = {
        self.size.width * scale,
        self.size.height * scale,
    };
    
    CGImageRef selfImageRef = self.CGImage;
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 size.width,
                                                 size.height,
                                                 CGImageGetBitsPerComponent(selfImageRef),
                                                 0,
                                                 CGImageGetColorSpace(selfImageRef),
                                                 CGImageGetBitmapInfo(selfImageRef));
    
    CGImageRef imageRef = NULL;
    
    if (context) {
        
        if (backColor) {
            CGContextSetFillColorWithColor(context, backColor.CGColor);
            CGContextFillRect(context, (CGRect){0, 0, size});
        }
        
        const CGAffineTransform transform = [self transformForOrientation:size];
        CGContextConcatCTM(context, transform);
                
        CGRect rect;
        rect.origin = CGPointZero;
        rect.size = self.isTransposed ? (CGSize){size.height, size.width} : size;
        
        CGContextDrawImage(context, rect, self.CGImage);
        imageRef = CGBitmapContextCreateImage(context);
        
        CGContextRelease(context);
    }
    
    UIImage *image;
    
    if (imageRef) {
        
        image = [UIImage imageWithCGImage:imageRef
                                    scale:scale
                              orientation:UIImageOrientationUp];
        
        CGImageRelease(imageRef);
    }
    
    return image;
}

- (CGAffineTransform)transformForOrientation:(CGSize)newSize
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        default:
            break;
    }
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        default:
            break;
    }
    
    return transform;
}


- (BOOL) hasAlpha
{
    const CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

- (BOOL) isTransposed
{
    return (self.imageOrientation == UIImageOrientationLeft ||
            self.imageOrientation == UIImageOrientationLeftMirrored ||
            self.imageOrientation == UIImageOrientationRight ||
            self.imageOrientation == UIImageOrientationRightMirrored);
}

- (UIImage *) applyCIFilters:(NSArray *)filters
                      contex:(CIContext *)contex
{
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    for (CIFilter *filter in filters) {

        [filter setValue:ciImage forKey:kCIInputImageKey];
        ciImage = filter.outputImage;
    }
    
    return [self.class imageFromCIImage:ciImage
                                 contex:contex
                                  scale:self.scale];
}

+ (UIImage *) imageFromCIImage:(CIImage*)ciImage
                        contex:(CIContext *)context
                         scale:(CGFloat)scale

{
    if (scale <= 0) {
        scale = [UIScreen mainScreen].realScale;
    }
    
    if (!context) {
        context = [CIContext contextWithOptions:nil];
    }
    
    CGImageRef cgImage = [context createCGImage:ciImage
                                       fromRect:ciImage.extent];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:scale
                                   orientation:UIImageOrientationUp];
    CGImageRelease(cgImage);
    return image;
    
    /*
    CGSize size = ciImage.extent.size;
    size.width  /= scale;
    size.height /= scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    UIImage *tmp = [UIImage imageWithCIImage:ciImage];
    [tmp drawInRect:(CGRect){0,0,size}];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    */
}

@end
