//
//  KxColorPallete.m
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

#import "KxColorPallete.h"
#import "KxPair.h"
@import ObjectiveC;

@implementation KxColorPallete {
    
    NSArray *_colors;
    NSArray *_colorNames;
}

+ (void) enumerateColors:(void(^)(NSString *name, UIColor *color))block
{    
    unsigned int numMethods = 9;
    Method *methods = class_copyMethodList(object_getClass(self), &numMethods);
    for (unsigned int i = 0; i < numMethods; i++) {
        
        Method method = methods[i];
        SEL sel = method_getName(method);
        if (sel) {
            NSString *name = NSStringFromSelector(sel);
            if ([name hasSuffix:@"Color"]) {
                
                // need to check method_copyReturnType == @ and method_getNumberOfArguments == 2 ?
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                UIColor *color = [self performSelector:sel];
#pragma clang diagnostic pop
                
                if (color) {
                    block(name, color);
                }
            }
        }
    }
}

+ (NSArray *) colors
{
    NSMutableArray *ma = [NSMutableArray array];
    
    [self enumerateColors:^(NSString *name, UIColor *color) {
        [ma addObject:color];
    }];
    
    return [ma copy];
}

+ (NSArray *) colorNames
{
    NSMutableArray *ma = [NSMutableArray array];
    
    [self enumerateColors:^(NSString *name, UIColor *color) {
        
        name = [name substringToIndex:name.length - 5];
        [ma addObject:name];
    }];
    
    return [ma copy];
}

+ (NSString *) palleteName
{
    return NSStringFromClass(self.class);
}

- (NSArray *)colors
{
    if (!_colors) {
        _colors = [self.class colors];
    }
    return _colors;
}

- (NSArray *)colorNames
{
    if (!_colorNames) {
        _colorNames = [self.class colorNames];
    }
    return _colorNames;
}

- (NSString *) palleteName
{
    return [self.class palleteName];
}

@end

// system colors

@implementation KxColorPalleteSystem

+ (UIColor *)infoBlueColor
{
    return [UIColor colorWithRed:47.f/255.f green:112.f/255.f blue:225.f/255.f alpha:1.f];
}

+ (UIColor *)successColor
{
    return [UIColor colorWithRed:83.f/255.f green:215.f/255.f blue:106.f/255.f alpha:1.f];
}

+ (UIColor *)warningColor
{
    return [UIColor colorWithRed:221.f/255.f green:170.f/255.f blue:59.f/255.f alpha:1.f];
}

+ (UIColor *)dangerColor
{
    return [UIColor colorWithRed:229.f/255.f green:0.f/255.f blue:15.f/255.f alpha:1.f];
}

//

+ (NSArray *) colors
{
    return @[
             self.infoBlueColor,
             self.successColor,
             self.warningColor,
             self.dangerColor
             ];
}

+ (NSArray *) colorNames
{
    return @[
             @"infoBlue",
             @"success",
             @"warning",
             @"danger",
             ];
}

+ (NSString *) palleteName
{
    return NSLocalizedString(@"System Colors", nil);
}

@end

// ios7 colors

@implementation KxColorPalleteSeven

+ (UIColor *)redColor
{
    return [UIColor colorWithRed:1.000 green:0.231 blue:0.188 alpha:1.000];
}

+ (UIColor *)deepRedColor
{
    return [UIColor colorWithRed:1.000 green:0.227 blue:0.176 alpha:1.000];
}

+ (UIColor *)orangeColor
{
    return [UIColor colorWithRed:1.000 green:0.584 blue:0.000 alpha:1.000];
}

+ (UIColor *)yellowColor
{
    return [UIColor colorWithRed:1.000 green:0.800 blue:0.000 alpha:1.000];
}

+ (UIColor *)greenColor
{
    return [UIColor colorWithRed:0.298 green:0.851 blue:0.392 alpha:1.000];
}

+ (UIColor *)lightGreenColor
{
    return [UIColor colorWithRed:0.878 green:0.973 blue:0.847 alpha:1.000];
}

+ (UIColor *)blueColor
{
    return [UIColor colorWithRed:0.000 green:0.478 blue:1.000 alpha:1.000];
}

+ (UIColor *)lightBlueColor
{
    return [UIColor colorWithRed:0.204 green:0.667 blue:0.863 alpha:1.000];
}

+ (UIColor *)violetColor
{
    return [UIColor colorWithRed:0.345 green:0.337 blue:0.839 alpha:1.000];
}

+ (UIColor *)pinkColor
{
    return [UIColor colorWithRed:1.000 green:0.286 blue:0.506 alpha:1.000];
}

+ (UIColor *)lightPinkColor
{
    return [UIColor colorWithRed:1.000 green:0.827 blue:0.878 alpha:1.000];
}

+ (UIColor *)hotPinkColor
{
    return [UIColor colorWithRed:1.000 green:0.176 blue:0.333 alpha:1.000];
}

+ (UIColor *)grayColor
{
    return [UIColor colorWithRed:0.557 green:0.557 blue:0.576 alpha:1.000];
}

+ (UIColor *)lightGrayColor
{
    return [UIColor colorWithRed:0.741 green:0.745 blue:0.761 alpha:1.000];
}

+ (UIColor *)whiteColor
{
    return [UIColor colorWithWhite:0.969 alpha:1.000];
}

+ (UIColor *)blackColor
{
    return [UIColor colorWithRed:0.122 green:0.122 blue:0.129 alpha:1.000];
}

//

+ (NSArray *) colors
{
    return @[
             self.redColor,
             self.deepRedColor,
             self.orangeColor,
             self.yellowColor,
             self.greenColor,
             self.lightGreenColor,
             self.blueColor,
             self.lightBlueColor,
             self.violetColor,
             self.pinkColor,
             self.lightPinkColor,
             self.hotPinkColor,
             self.grayColor,
             self.lightGrayColor,
             self.whiteColor,
             self.blackColor,
             ];
}

+ (NSArray *) colorNames
{
    return @[
             @"red",
             @"deepRed",
             @"orange",
             @"yellow",
             @"green",
             @"lightGreen",
             @"blue",
             @"lightBlue",
             @"violet",
             @"pink",
             @"lightPink",
             @"hotPink",
             @"gray",
             @"lightGray",
             @"white",
             @"black",
             ];
}

+ (NSString *) palleteName
{
    return NSLocalizedString(@"iOS7 Colors", nil);
}

@end
