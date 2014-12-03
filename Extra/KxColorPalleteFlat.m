//
//  KxColorPalleteFlat.m
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

#import "KxColorPalleteFlat.h"

@implementation KxColorPalleteFlat

+ (UIColor *) turquoiseColor
{
    return [UIColor colorWithRed:26.f/255.f green:188.f/255.f blue:156.f/255.f alpha:1];
}

+ (UIColor *) greenseaColor
{
    return [UIColor colorWithRed:22.f/255.f green:160.f/255.f blue:133.f/255.f alpha:1];
}

+ (UIColor *) emerlandColor
{
    return [UIColor colorWithRed:46.f/255.f green:204.f/255.f blue:113.f/255.f alpha:1];
}

+ (UIColor *) nephritisColor
{
    return [UIColor colorWithRed:39.f/255.f green:174.f/255.f blue:96.f/255.f alpha:1];
}

+ (UIColor *) peterriverColor
{
    return [UIColor colorWithRed:52.f/255.f green:152.f/255.f blue:219.f/255.f alpha:1];
}

+ (UIColor *) belizeholeColor
{
    return [UIColor colorWithRed:41.f/255.f green:128.f/255.f blue:185.f/255.f alpha:1];
}

+ (UIColor *) amethystColor
{
    return [UIColor colorWithRed:155.f/255.f green:89.f/255.f blue:182.f/255.f alpha:1];
}

+ (UIColor *) wisteriaColor
{
    return [UIColor colorWithRed:142.f/255.f green:68.f/255.f blue:173.f/255.f alpha:1];
}

+ (UIColor *) wetasphaltColor
{
    return [UIColor colorWithRed:52.f/255.f green:73.f/255.f blue:94.f/255.f alpha:1];
}

+ (UIColor *) midnightblueColor
{
    return [UIColor colorWithRed:44.f/255.f green:62.f/255.f blue:80.f/255.f alpha:1];
}

+ (UIColor *) sunflowerColor
{
    return [UIColor colorWithRed:241.f/255.f green:196.f/255.f blue:15.f/255.f alpha:1];
}

+ (UIColor *) orangeColor
{
    return [UIColor colorWithRed:243.f/255.f green:156.f/255.f blue:18.f/255.f alpha:1];
}

+ (UIColor *) carrotColor
{
    return [UIColor colorWithRed:230.f/255.f green:126.f/255.f blue:34.f/255.f alpha:1];
}

+ (UIColor *) pumpkinColor
{
    return [UIColor colorWithRed:211.f/255.f green:84.f/255.f blue:0.f/255.f alpha:1];
}

+ (UIColor *) alizarinColor
{
    return [UIColor colorWithRed:231.f/255.f green:76.f/255.f blue:60.f/255.f alpha:1];
}

+ (UIColor *) pomegranateColor
{
    return [UIColor colorWithRed:192.f/255.f green:57.f/255.f blue:43.f/255.f alpha:1];
}

+ (UIColor *) cloudsColor
{
    return [UIColor colorWithRed:236.f/255.f green:240.f/255.f blue:241.f/255.f alpha:1];
}

+ (UIColor *) silverColor
{
    return [UIColor colorWithRed:189.f/255.f green:195.f/255.f blue:199.f/255.f alpha:1];
}

+ (UIColor *) concreteColor
{
    return [UIColor colorWithRed:149.f/255.f green:165.f/255.f blue:166.f/255.f alpha:1];
}

+ (UIColor *) asbestosColor
{
    return [UIColor colorWithRed:127.f/255.f green:140.f/255.f blue:141.f/255.f alpha:1];
}

//

+ (NSArray *) colors
{
    return @[
             self.turquoiseColor,
             self.greenseaColor,
             self.emerlandColor,
             self.nephritisColor,
             self.peterriverColor,
             self.belizeholeColor,
             self.amethystColor,
             self.wisteriaColor,
             self.wetasphaltColor,
             self.midnightblueColor,
             self.sunflowerColor,
             self.orangeColor,
             self.carrotColor,
             self.pumpkinColor,
             self.alizarinColor,
             self.pomegranateColor,
             self.cloudsColor,
             self.silverColor,
             self.concreteColor,
             self.asbestosColor,
             ];
}

+ (NSArray *) colorNames
{
    return @[
             @"turquoise",
             @"greensea",
             @"emerland",
             @"nephritis",
             @"peterriver",
             @"belizehole",
             @"amethyst",
             @"wisteria",
             @"wetasphalt",
             @"midnightblue",
             @"sunflower",
             @"orange",
             @"carrot",
             @"pumpkin",
             @"alizarin",
             @"pomegranate",
             @"clouds",
             @"silver",
             @"concrete",
             @"asbestos",
             ];
}

+ (NSString *) palleteName
{
    return NSLocalizedString(@"Flat Colors", nil);
}

@end
