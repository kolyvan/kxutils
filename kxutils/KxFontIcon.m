//
//  KxFontIcon.m
//  https://github.com/kolyvan/kxutils
//
//  Created by Kolyvan on 08.04.15.
//

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

#import "KxFontIcon.h"
#import "KxFilePath.h"
#import "UIColor+KxUtils.h"
#import "NSFileManager+KxUtils.h"
@import CoreText;

@implementation KxFontIcon {

    CTFontRef _ctFont;
}

+ (instancetype) fontIconWithPath:(NSString *)path
{
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:path
                                          options:NSDataReadingMappedIfSafe
                                            error:&error];
    
    if (!data) {
        NSLog(@"%s fail load data at %@, %@" , __PRETTY_FUNCTION__, path, error);
        return nil;
    }
    
    CGDataProviderRef fontProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGFontRef cgFont = CGFontCreateWithDataProvider(fontProvider);
    CGDataProviderRelease(fontProvider);
    
    CTFontRef ctFont;
    if (cgFont) {
    
        CTFontDescriptorRef fontDescriptor = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)@{});
        if (fontDescriptor) {
            ctFont = CTFontCreateWithGraphicsFont(cgFont, 0, NULL, fontDescriptor);
            CFRelease(fontDescriptor);
        }
        CGFontRelease(cgFont);
    }
    
    if (ctFont) {
        return [[self alloc] initWithCTFont:ctFont name:path.lastPathComponent];
    }
    
    NSLog(@"%s fail create font at %@" , __PRETTY_FUNCTION__, path);
    return nil;
    
}

- (instancetype) initWithCTFont:(CTFontRef)ctFont
                           name:(NSString *)name
{
    if ((self = [super init])) {
        _ctFont = ctFont;
        _name = name;
    }
    return self;
}

- (void) dealloc
{
    if (_ctFont) {
        CFRelease(_ctFont);
    }
}

- (UIImage *)imageWithGlyph:(NSString *)glyph
                   fontSize:(CGFloat)fontSize
{
    return [self imageWithGlyph:glyph
                       fontSize:fontSize
                      imageSize:(CGSize){fontSize, fontSize}
                      foreColor:nil
                    strokeColor:nil
                    strokeWidth:0
                      backColor:nil];
}

- (UIImage *)imageWithGlyph:(NSString *)glyph
                   fontSize:(CGFloat)fontSize
                  foreColor:(UIColor*)foreColor
{
    return [self imageWithGlyph:glyph
                       fontSize:fontSize
                      imageSize:(CGSize){fontSize, fontSize}
                      foreColor:foreColor
                    strokeColor:nil
                    strokeWidth:0
                      backColor:nil];
}

- (UIImage *)imageWithGlyph:(NSString *)glyph
                   fontSize:(CGFloat)fontSize
                  imageSize:(CGSize)imageSize
                  foreColor:(UIColor*)foreColor
                strokeColor:(UIColor*)strokeColor
                strokeWidth:(CGFloat)strokeWidth
                  backColor:(UIColor *)backColor
{
    if (!backColor) {
        backColor = [UIColor clearColor];
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, backColor.CGColor);
    CGContextFillRect(context, (CGRect){0, 0, imageSize});
    
    CTFontRef sizedFont = CTFontCreateCopyWithAttributes(_ctFont, fontSize, NULL, NULL);
    
    NSMutableDictionary *atts = [NSMutableDictionary dictionary];
    
    atts[(NSString*)kCTFontAttributeName] = (__bridge id)sizedFont;
    
    if (foreColor) {
        atts[(NSString*)kCTForegroundColorAttributeName] = (__bridge id)foreColor.CGColor;
    }
    
    if (strokeWidth && strokeColor) {
        
        atts[(NSString*)kCTStrokeWidthAttributeName] =@(strokeWidth);
        atts[(NSString*)kCTStrokeColorAttributeName] = (__bridge id)strokeColor.CGColor;
    }
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:glyph
                                                                     attributes:atts];

    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef) attrString);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, imageSize.height);
    CGContextScaleCTM(context, 1, -1);
    
    const CGRect imageBounds = CTLineGetImageBounds(line, context);
    const CGFloat yOffset = (imageSize.height - imageBounds.size.height)/2.0 - imageBounds.origin.y;
    const CGFloat penOffset = CTLineGetPenOffsetForFlush(line, 0.5, imageSize.width);
    
    CGContextSetTextPosition(context, roundf(penOffset), roundf(yOffset));
    
    CTLineDraw(line, context);
    
    CFRelease(line);
    CFRelease(sizedFont);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end


@implementation KxFontIconCache {
    
    NSString    *_fontPath;
    KxFontIcon  *_fontIcon;
    NSCache     *_cache;
    NSString    *_cachePath;
}

+ (instancetype) fontIconCacheWithPath:(NSString *)path
{
    return [[self alloc] initWithPath:path];
}

+ (instancetype) fontIconCache:(KxFontIcon *)fontIcon
{
    return [[self alloc] initWithFontIcon:fontIcon];
}

- (instancetype) initWithPath:(NSString *)path
{
    if ((self = [super init])) {
        
        _fontPath = path;
        [self _setupWithName:path.lastPathComponent];        
    }
    return self;
}

- (instancetype) initWithFontIcon:(KxFontIcon *)fontIcon
{
    if ((self = [super init])) {
        
        _fontIcon = fontIcon;
        [self _setupWithName:_fontIcon.name];
    }
    return self;
}

- (void) _setupWithName:(NSString *)name
{
    _cache = [[NSCache alloc] init];
    _cache.totalCostLimit = 64*64*64*[UIScreen mainScreen].scale;
    
    _cachePath = [KxFilePath cacheDataPath];
    _cachePath = [_cachePath stringByAppendingPathComponent:@"com.kolyvan.fonticon"];
    _cachePath = [_cachePath stringByAppendingPathComponent:name];
}

- (KxFontIcon *) fontIcon
{
    if (!_fontIcon && _fontPath) {
        _fontIcon = [KxFontIcon fontIconWithPath:_fontPath];
        if (!_fontIcon) {
            _fontPath = nil;
        }
    }
    return _fontIcon;
}

- (NSString *) _keyWithGlyph:(NSString *)glyph
                    fontSize:(CGFloat)fontSize
                   imageSize:(CGSize)imageSize
                   foreColor:(UIColor*)foreColor
                 strokeColor:(UIColor*)strokeColor
                 strokeWidth:(CGFloat)strokeWidth
                   backColor:(UIColor *)backColor
{
    NSMutableString *ms = [NSMutableString string];
    
    for (NSUInteger i = 0; i < glyph.length; ++i) {
        const unichar ch = [glyph characterAtIndex:0];
        [ms appendFormat:@"%x", ch];
    }
    
    [ms appendString:@"-"];
    [ms appendFormat:@"%u", (unsigned)imageSize.width];
    
    [ms appendString:@"-"];
    [ms appendFormat:@"%u", (unsigned)imageSize.height];
    
    [ms appendString:@"-"];
    [ms appendFormat:@"%u", (unsigned)fontSize];
    
    [ms appendString:@"-"];
    if (foreColor) {
        [ms appendFormat:@"%x", (unsigned)foreColor.argbValue];
    } else {
        [ms appendString:@"x"];
    }
    
    [ms appendString:@"-"];
    if (backColor) {
        [ms appendFormat:@"%x", (unsigned)backColor.argbValue];
    } else {
        [ms appendString:@"x"];
    }
    
    if (strokeColor && strokeWidth) {
        
        [ms appendString:@"-"];
        [ms appendFormat:@"%x", (unsigned)strokeColor.argbValue];
        
        [ms appendString:@"-"];
        [ms appendFormat:@"%x", (unsigned)strokeWidth];
    }
    
    return ms;
}

- (UIImage *)imageWithGlyph:(NSString *)glyph
                   fontSize:(CGFloat)fontSize
{
    return [self imageWithGlyph:glyph
                       fontSize:fontSize
                      imageSize:(CGSize){fontSize, fontSize}
                      foreColor:nil
                    strokeColor:nil
                    strokeWidth:0
                      backColor:nil];
}

- (UIImage *)imageWithGlyph:(NSString *)glyph
                   fontSize:(CGFloat)fontSize
                  foreColor:(UIColor*)foreColor
{
    return [self imageWithGlyph:glyph
                       fontSize:fontSize
                      imageSize:(CGSize){fontSize, fontSize}
                      foreColor:foreColor
                    strokeColor:nil
                    strokeWidth:0
                      backColor:nil];
}

- (UIImage *)imageWithGlyph:(NSString *)glyph
                   fontSize:(CGFloat)fontSize
                  imageSize:(CGSize)imageSize
                  foreColor:(UIColor*)foreColor
                strokeColor:(UIColor*)strokeColor
                strokeWidth:(CGFloat)strokeWidth
                  backColor:(UIColor *)backColor
{
    NSString *key = [self _keyWithGlyph:glyph
                               fontSize:fontSize
                              imageSize:imageSize
                              foreColor:foreColor
                            strokeColor:strokeColor
                            strokeWidth:strokeWidth
                              backColor:backColor];
    
    UIImage *image = [_cache objectForKey:key];
    if (image) {
        return image;
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *filePath = [_cachePath stringByAppendingPathComponent:key];
    filePath = [filePath stringByAppendingPathExtension:@"png"];
    
    if ([fm fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data) {
            image = [[UIImage alloc] initWithData:data scale:[UIScreen mainScreen].scale];
            if (image) {
                const NSUInteger cost = image.size.width * image.size.height * [UIScreen mainScreen].scale;
                [_cache setObject:image forKey:key cost:cost];
                return image;
            } else {
                
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            }
        }
    }
    
    image = [self.fontIcon imageWithGlyph:glyph
                                 fontSize:fontSize
                                imageSize:imageSize
                                foreColor:foreColor
                              strokeColor:strokeColor
                              strokeWidth:strokeWidth
                                backColor:backColor];
    if (image) {
    
        const NSUInteger cost = image.size.width * image.size.height * [UIScreen mainScreen].scale;
        [_cache setObject:image forKey:key cost:cost];
        
        [fm ensureFolderAtPath:_cachePath error:nil];
        NSData *data = UIImagePNGRepresentation(image);
        if (data) {
            [data writeToFile:filePath atomically:NO];
        }
    }
    
    return image;
}

- (void) purgeCache
{
    [_cache removeAllObjects];
    [[NSFileManager defaultManager] removeItemAtPath:_cachePath error:nil];
}

@end