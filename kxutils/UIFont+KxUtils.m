//
//  UIFont+KxUtils.m
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

#import "UIFont+KxUtils.h"

@implementation UIFont (KxUtils)

+ (UIFont *) monospacedFontOfSize:(CGFloat)fontSize
{
    UIFont *font;
    
    font = [UIFont fontWithName:@"Menlo" size:fontSize];
    if (font) {
        return font;
    }
    
    font = [UIFont fontWithName:@"Courier New" size:fontSize];
    if (font) {
        return font;
    }
    
    font = [UIFont fontWithName:@"Courier" size:fontSize];
    if (font) {
        return font;
    }
    
    UIFontDescriptor *fd = [UIFontDescriptor new];
    fd = [fd fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitMonoSpace];
    if (fd) {
        font = [UIFont fontWithDescriptor:fd size:fontSize];
    }
    
    return font ? font : [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *) fontFamily:(NSString *)fontFamily
                   size:(CGFloat)size
                  trait:(UIFontDescriptorSymbolicTraits)trait
{
    UIFontDescriptor *fd;
    
    fd =  [UIFontDescriptor fontDescriptorWithFontAttributes:
           @{
             UIFontDescriptorFamilyAttribute : fontFamily,
             UIFontDescriptorTraitsAttribute : @{
                     UIFontSymbolicTrait : @(trait)
                     },
             }];
    
    if (fd) {
        
        UIFont *font = [self fontWithDescriptor:fd size:size];
        if (font && (0 != (font.fontDescriptor.symbolicTraits & trait))) {
            return font;
        }
    }
    
    NSString *fontFace;
    if (0 != (trait & UIFontDescriptorTraitItalic)) {
        fontFace = @"Italic";
    } else if (0 != (trait & UIFontDescriptorTraitBold)) {
        fontFace = @"Bold";
    } else {
        fontFace = @"Regular";
    }
    
    fd = [UIFontDescriptor fontDescriptorWithFontAttributes:
          @{
            UIFontDescriptorFamilyAttribute : fontFamily,
            UIFontDescriptorFaceAttribute : fontFace,
            }];
    
    if (fd) {
        
        UIFont *font = [self fontWithDescriptor:fd size:size];
        if (font && (0 != (font.fontDescriptor.symbolicTraits & trait))) {
            return font;
        }
    }
    
    return nil;
}

+ (UIFont *) italicFontFamily:(NSString *)fontFamily
                         size:(CGFloat)size
{
    if (fontFamily.length) {
        
        UIFont *font = [self fontFamily:fontFamily size:size trait:UIFontDescriptorTraitItalic];
        if (font) {
            return font;
        }
    }
    
    return [UIFont italicSystemFontOfSize:size];
}

+ (UIFont *) boldFontFamily:(NSString *)fontFamily
                       size:(CGFloat)size
{
    if (fontFamily.length) {
        
        UIFont *font = [self fontFamily:fontFamily size:size trait:UIFontDescriptorTraitBold];
        if (font) {
            return font;
        }
    }
    
    return [UIFont boldSystemFontOfSize:size];
}

@end
