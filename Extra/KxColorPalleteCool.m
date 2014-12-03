//
//  KxColorPalleteCool.m
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

#import "KxColorPalleteCool.h"

@implementation UIColor (KxColorPallete)

+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a
{
    return [self colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

@end

@implementation KxColorPalleteCool

// whites

+ (UIColor *)antiqueWhiteColor
{
    return [UIColor colorWithR:250 G:235 B:215 A:1.0];
}

+ (UIColor *)oldLaceColor
{
    return [UIColor colorWithR:253 G:245 B:230 A:1.0];
}

+ (UIColor *)ivoryColor
{
    return [UIColor colorWithR:255 G:255 B:240 A:1.0];
}

+ (UIColor *)seashellColor
{
    return [UIColor colorWithR:255 G:245 B:238 A:1.0];
}

+ (UIColor *)ghostWhiteColor
{
    return [UIColor colorWithR:248 G:248 B:255 A:1.0];
}

+ (UIColor *)snowColor
{
    return [UIColor colorWithR:255 G:250 B:250 A:1.0];
}

+ (UIColor *)linenColor
{
    return [UIColor colorWithR:250 G:240 B:230 A:1.0];
}

// grays

+ (UIColor *)warmGrayColor
{
    return [UIColor colorWithR:133 G:117 B:112 A:1.0];
}

+ (UIColor *)coolGrayColor
{
    return [UIColor colorWithR:118 G:122 B:133 A:1.0];
}

+ (UIColor *)charcoalColor
{
    return [UIColor colorWithR:34 G:34 B:34 A:1.0];
}

// blues
+ (UIColor *)tealColor
{
    return [UIColor colorWithR:28 G:160 B:170 A:1.0];
}

+ (UIColor *)steelBlueColor
{
    return [UIColor colorWithR:103 G:153 B:170 A:1.0];
}

+ (UIColor *)robinEggColor
{
    return [UIColor colorWithR:141 G:218 B:247 A:1.0];
}

+ (UIColor *)pastelBlueColor
{
    return [UIColor colorWithR:99 G:161 B:247 A:1.0];
}

+ (UIColor *)turquoiseColor
{
    return [UIColor colorWithR:112 G:219 B:219 A:1.0];
}

+ (UIColor *)skyBlueColor
{
    return [UIColor colorWithR:0 G:178 B:238 A:1.0];
}

+ (UIColor *)indigoColor
{
    return [UIColor colorWithR:13 G:79 B:139 A:1.0];
}

+ (UIColor *)denimColor
{
    return [UIColor colorWithR:67 G:114 B:170 A:1.0];
}

+ (UIColor *)blueberryColor
{
    return [UIColor colorWithR:89 G:113 B:173 A:1.0];
}

+ (UIColor *)cornflowerColor
{
    return [UIColor colorWithR:100 G:149 B:237 A:1.0];
}

+ (UIColor *)babyBlueColor
{
    return [UIColor colorWithR:190 G:220 B:230 A:1.0];
}

+ (UIColor *)midnightBlueColor
{
    return [UIColor colorWithR:13 G:26 B:35 A:1.0];
}

+ (UIColor *)fadedBlueColor
{
    return [UIColor colorWithR:23 G:137 B:155 A:1.0];
}

+ (UIColor *)icebergColor
{
    return [UIColor colorWithR:200 G:213 B:219 A:1.0];
}

+ (UIColor *)waveColor
{
    return [UIColor colorWithR:102 G:169 B:251 A:1.0];
}

// greens
+ (UIColor *)emeraldColor
{
    return [UIColor colorWithR:1 G:152 B:117 A:1.0];
}

+ (UIColor *)grassColor
{
    return [UIColor colorWithR:99 G:214 B:74 A:1.0];
}

+ (UIColor *)pastelGreenColor
{
    return [UIColor colorWithR:126 G:242 B:124 A:1.0];
}

+ (UIColor *)seafoamColor
{
    return [UIColor colorWithR:77 G:226 B:140 A:1.0];
}

+ (UIColor *)paleGreenColor
{
    return [UIColor colorWithR:176 G:226 B:172 A:1.0];
}

+ (UIColor *)cactusGreenColor
{
    return [UIColor colorWithR:99 G:111 B:87 A:1.0];
}

+ (UIColor *)chartreuseColor
{
    return [UIColor colorWithR:69 G:139 B:0 A:1.0];
}

+ (UIColor *)hollyGreenColor
{
    return [UIColor colorWithR:32 G:87 B:14 A:1.0];
}

+ (UIColor *)oliveColor
{
    return [UIColor colorWithR:91 G:114 B:34 A:1.0];
}

+ (UIColor *)oliveDrabColor
{
    return [UIColor colorWithR:107 G:142 B:35 A:1.0];
}

+ (UIColor *)moneyGreenColor
{
    return [UIColor colorWithR:134 G:198 B:124 A:1.0];
}

+ (UIColor *)honeydewColor
{
    return [UIColor colorWithR:216 G:255 B:231 A:1.0];
}

+ (UIColor *)limeColor
{
    return [UIColor colorWithR:56 G:237 B:56 A:1.0];
}

+ (UIColor *)cardTableColor
{
    return [UIColor colorWithR:87 G:121 B:107 A:1.0];
}

// reds
+ (UIColor *)salmonColor
{
    return [UIColor colorWithR:233 G:87 B:95 A:1.0];
}

+ (UIColor *)brickRedColor
{
    return [UIColor colorWithR:151 G:27 B:16 A:1.0];
}

+ (UIColor *)easterPinkColor
{
    return [UIColor colorWithR:241 G:167 B:162 A:1.0];
}

+ (UIColor *)grapefruitColor
{
    return [UIColor colorWithR:228 G:31 B:54 A:1.0];
}

+ (UIColor *)pinkColor
{
    return [UIColor colorWithR:255 G:95 B:154 A:1.0];
}

+ (UIColor *)indianRedColor
{
    return [UIColor colorWithR:205 G:92 B:92 A:1.0];
}

+ (UIColor *)strawberryColor
{
    return [UIColor colorWithR:190 G:38 B:37 A:1.0];
}

+ (UIColor *)coralColor
{
    return [UIColor colorWithR:240 G:128 B:128 A:1.0];
}

+ (UIColor *)maroonColor
{
    return [UIColor colorWithR:80 G:4 B:28 A:1.0];
}

+ (UIColor *)watermelonColor
{
    return [UIColor colorWithR:242 G:71 B:63 A:1.0];
}

+ (UIColor *)tomatoColor
{
    return [UIColor colorWithR:255 G:99 B:71 A:1.0];
}

+ (UIColor *)pinkLipstickColor
{
    return [UIColor colorWithR:255 G:105 B:180 A:1.0];
}

+ (UIColor *)paleRoseColor
{
    return [UIColor colorWithR:255 G:228 B:225 A:1.0];
}

+ (UIColor *)crimsonColor
{
    return [UIColor colorWithR:187 G:18 B:36 A:1.0];
}

// purples
+ (UIColor *)eggplantColor
{
    return [UIColor colorWithR:105 G:5 B:98 A:1.0];
}

+ (UIColor *)pastelPurpleColor
{
    return [UIColor colorWithR:207 G:100 B:235 A:1.0];
}

+ (UIColor *)palePurpleColor
{
    return [UIColor colorWithR:229 G:180 B:235 A:1.0];
}

+ (UIColor *)coolPurpleColor
{
    return [UIColor colorWithR:140 G:93 B:228 A:1.0];
}

+ (UIColor *)violetColor
{
    return [UIColor colorWithR:191 G:95 B:255 A:1.0];
}

+ (UIColor *)plumColor
{
    return [UIColor colorWithR:139 G:102 B:139 A:1.0];
}

+ (UIColor *)lavenderColor
{
    return [UIColor colorWithR:204 G:153 B:204 A:1.0];
}

+ (UIColor *)raspberryColor
{
    return [UIColor colorWithR:135 G:38 B:87 A:1.0];
}

+ (UIColor *)fuschiaColor
{
    return [UIColor colorWithR:255 G:20 B:147 A:1.0];
}

+ (UIColor *)grapeColor
{
    return [UIColor colorWithR:54 G:11 B:88 A:1.0];
}

+ (UIColor *)periwinkleColor
{
    return [UIColor colorWithR:135 G:159 B:237 A:1.0];
}

+ (UIColor *)orchidColor
{
    return [UIColor colorWithR:218 G:112 B:214 A:1.0];
}

// yellows
+ (UIColor *)goldenrodColor
{
    return [UIColor colorWithR:215 G:170 B:51 A:1.0];
}

+ (UIColor *)yellowGreenColor
{
    return [UIColor colorWithR:192 G:242 B:39 A:1.0];
}

+ (UIColor *)bananaColor
{
    return [UIColor colorWithR:229 G:227 B:58 A:1.0];
}

+ (UIColor *)mustardColor
{
    return [UIColor colorWithR:205 G:171 B:45 A:1.0];
}

+ (UIColor *)buttermilkColor
{
    return [UIColor colorWithR:254 G:241 B:181 A:1.0];
}

+ (UIColor *)goldColor
{
    return [UIColor colorWithR:139 G:117 B:18 A:1.0];
}

+ (UIColor *)creamColor
{
    return [UIColor colorWithR:240 G:226 B:187 A:1.0];
}

+ (UIColor *)lightCreamColor
{
    return [UIColor colorWithR:240 G:238 B:215 A:1.0];
}

+ (UIColor *)wheatColor
{
    return [UIColor colorWithR:240 G:238 B:215 A:1.0];
}

+ (UIColor *)beigeColor
{
    return [UIColor colorWithR:245 G:245 B:220 A:1.0];
}

// oranges
+ (UIColor *)peachColor
{
    return [UIColor colorWithR:242 G:187 B:97 A:1.0];
}

+ (UIColor *)burntOrangeColor
{
    return [UIColor colorWithR:184 G:102 B:37 A:1.0];
}

+ (UIColor *)pastelOrangeColor
{
    return [UIColor colorWithR:248 G:197 B:143 A:1.0];
}

+ (UIColor *)cantaloupeColor
{
    return [UIColor colorWithR:250 G:154 B:79 A:1.0];
}

+ (UIColor *)carrotColor
{
    return [UIColor colorWithR:237 G:145 B:33 A:1.0];
}

+ (UIColor *)mandarinColor
{
    return [UIColor colorWithR:247 G:145 B:55 A:1.0];
}

// browns
+ (UIColor *)chiliPowderColor
{
    return [UIColor colorWithR:199 G:63 B:23 A:1.0];
}

+ (UIColor *)burntSiennaColor
{
    return [UIColor colorWithR:138 G:54 B:15 A:1.0];
}

+ (UIColor *)chocolateColor
{
    return [UIColor colorWithR:94 G:38 B:5 A:1.0];
}

+ (UIColor *)coffeeColor
{
    return [UIColor colorWithR:141 G:60 B:15 A:1.0];
}

+ (UIColor *)cinnamonColor
{
    return [UIColor colorWithR:123 G:63 B:9 A:1.0];
}

+ (UIColor *)almondColor
{
    return [UIColor colorWithR:196 G:142 B:72 A:1.0];
}

+ (UIColor *)eggshellColor
{
    return [UIColor colorWithR:252 G:230 B:201 A:1.0];
}

+ (UIColor *)sandColor
{
    return [UIColor colorWithR:222 G:182 B:151 A:1.0];
}

+ (UIColor *)mudColor
{
    return [UIColor colorWithR:70 G:45 B:29 A:1.0];
}

+ (UIColor *)siennaColor
{
    return [UIColor colorWithR:160 G:82 B:45 A:1.0];
}

+ (UIColor *)dustColor
{
    return [UIColor colorWithR:236 G:214 B:197 A:1.0];
}

//

+ (NSArray *) colors
{
    return @[
             // whites
             self.antiqueWhiteColor,
             self.oldLaceColor,
             self.ivoryColor,
             self.seashellColor,
             self.ghostWhiteColor,
             self.snowColor,
             self.linenColor,
             
             // grays
             self.warmGrayColor,
             self.coolGrayColor,
             self.charcoalColor,
             
             // blues
             self.tealColor,
             self.steelBlueColor,
             self.robinEggColor,
             self.pastelBlueColor,
             self.turquoiseColor,
             self.skyBlueColor,
             self.indigoColor,
             self.denimColor,
             self.blueberryColor,
             self.cornflowerColor,
             self.babyBlueColor,
             self.midnightBlueColor,
             self.fadedBlueColor,
             self.icebergColor,
             self.waveColor,
             
             // greens
             self.emeraldColor,
             self.grassColor,
             self.pastelGreenColor,
             self.seafoamColor,
             self.paleGreenColor,
             self.cactusGreenColor,
             self.chartreuseColor,
             self.hollyGreenColor,
             self.oliveColor,
             self.oliveDrabColor,
             self.moneyGreenColor,
             self.honeydewColor,
             self.limeColor,
             self.cardTableColor,
             
             // reds
             self.salmonColor,
             self.brickRedColor,
             self.easterPinkColor,
             self.grapefruitColor,
             self.pinkColor,
             self.indianRedColor,
             self.strawberryColor,
             self.coralColor,
             self.maroonColor,
             self.watermelonColor,
             self.tomatoColor,
             self.pinkLipstickColor,
             self.paleRoseColor,
             self.crimsonColor,
             
             // purples
             self.eggplantColor,
             self.pastelPurpleColor,
             self.palePurpleColor,
             self.coolPurpleColor,
             self.violetColor,
             self.plumColor,
             self.lavenderColor,
             self.raspberryColor,
             self.fuschiaColor,
             self.grapeColor,
             self.periwinkleColor,
             self.orchidColor,
             
             // yellows
             self.goldenrodColor,
             self.yellowGreenColor,
             self.bananaColor,
             self.mustardColor,
             self.buttermilkColor,
             self.goldColor,
             self.creamColor,
             self.lightCreamColor,
             self.wheatColor,
             self.beigeColor,
             
             // oranges
             self.peachColor,
             self.burntOrangeColor,
             self.pastelOrangeColor,
             self.cantaloupeColor,
             self.carrotColor,
             self.mandarinColor,
             
             // browns
             self.chiliPowderColor,
             self.burntSiennaColor,
             self.chocolateColor,
             self.coffeeColor,
             self.cinnamonColor,
             self.almondColor,
             self.eggshellColor,
             self.sandColor,
             self.mudColor,
             self.siennaColor,
             self.dustColor,
             
             ];
}

+ (NSArray *) colorNames
{
    return @[
             // whites
             @"antiqueWhite",
             @"oldLace",
             @"ivory",
             @"seashell",
             @"ghostWhite",
             @"snow",
             @"linen",
             
             // grays
             @"warmGray",
             @"coolGray",
             @"charcoal",
             
             // blues
             @"teal",
             @"steelBlue",
             @"robinEgg",
             @"pastelBlue",
             @"turquoise",
             @"skyBlue",
             @"indigo",
             @"denim",
             @"blueberry",
             @"cornflower",
             @"babyBlue",
             @"midnightBlue",
             @"fadedBlue",
             @"iceberg",
             @"wave",
             
             // greens
             @"emerald",
             @"grass",
             @"pastelGreen",
             @"seafoam",
             @"paleGreen",
             @"cactusGreen",
             @"chartreuse",
             @"hollyGreen",
             @"olive",
             @"oliveDrab",
             @"moneyGreen",
             @"honeydew",
             @"lime",
             @"cardTable",
             
             // reds
             @"salmon",
             @"brickRed",
             @"easterPink",
             @"grapefruit",
             @"pink",
             @"indianRed",
             @"strawberry",
             @"coral",
             @"maroon",
             @"watermelon",
             @"tomato",
             @"pinkLipstick",
             @"paleRose",
             @"crimson",
             
             // purples
             @"eggplant",
             @"pastelPurple",
             @"palePurple",
             @"coolPurple",
             @"violet",
             @"plum",
             @"lavender",
             @"raspberry",
             @"fuschia",
             @"grape",
             @"periwinkle",
             @"orchid",
             
             // yellows
             @"goldenrod",
             @"yellowGreen",
             @"banana",
             @"mustard",
             @"buttermilk",
             @"gold",
             @"cream",
             @"lightCream",
             @"wheat",
             @"beige",
             
             // oranges
             @"peach",
             @"burntOrange",
             @"pastelOrange",
             @"cantaloupe",
             @"carrot",
             @"mandarin",
             
             // browns
             @"chiliPowder",
             @"burntSienna",
             @"chocolate",
             @"coffee",
             @"cinnamon",
             @"almond",
             @"eggshell",
             @"sand",
             @"mud",
             @"sienna",
             @"dust",
             ];
}

+ (NSString *) palleteName
{
    return NSLocalizedString(@"Cool Colors", nil);
}

@end
