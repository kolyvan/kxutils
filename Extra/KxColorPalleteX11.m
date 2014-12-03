//
//  KxColorPalleteX11.m
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

#import "KxColorPalleteX11.h"
#import "UIColor+KxUtils.h"

#define DEFINE_COLOR(value, name) +(UIColor *)name ## Color { return [UIColor colorWithRGBValue:value]; }

@implementation KxColorPalleteX11

// simple (whites,gray,black)
DEFINE_COLOR(0xFFFFFF, white)
DEFINE_COLOR(0xFFFAFA, snow)
DEFINE_COLOR(0xF0FFF0, honeydew)
DEFINE_COLOR(0xF5FFFA, mintCream)
DEFINE_COLOR(0xF0FFFF, azure)
DEFINE_COLOR(0xF0F8FF, aliceBlue)
DEFINE_COLOR(0xF8F8FF, ghostWhite)
DEFINE_COLOR(0xF5F5F5, whiteSmoke)
DEFINE_COLOR(0xFFF5EE, seashell)
DEFINE_COLOR(0xF5F5DC, beige)
DEFINE_COLOR(0xFDF5E6, oldLace)
DEFINE_COLOR(0xFFFAF0, floralWhite)
DEFINE_COLOR(0xFFFFF0, ivory)
DEFINE_COLOR(0xFAEBD7, antiqueWhite)
DEFINE_COLOR(0xFAF0E6, linen)
DEFINE_COLOR(0xFFF0F5, lavenderBlush)
DEFINE_COLOR(0xFFE4E1, mistyRose)
DEFINE_COLOR(0xDCDCDC, gainsboro)
DEFINE_COLOR(0xD3D3D3, lightGray)
DEFINE_COLOR(0xD3D3D3, lightGrey)
DEFINE_COLOR(0xC0C0C0, silver)
DEFINE_COLOR(0xA9A9A9, darkGray)
DEFINE_COLOR(0xA9A9A9, darkGrey)
DEFINE_COLOR(0x808080, gray)
DEFINE_COLOR(0x808080, grey)
DEFINE_COLOR(0x696969, dimGray)
DEFINE_COLOR(0x696969, dimGrey)
DEFINE_COLOR(0x778899, lightSlateGray)
DEFINE_COLOR(0x778899, lightSlateGrey)
DEFINE_COLOR(0x708090, slateGray)
DEFINE_COLOR(0x708090, slateGrey)
DEFINE_COLOR(0x2F4F4F, darkSlateGray)
DEFINE_COLOR(0x2F4F4F, darkSlateGrey)
DEFINE_COLOR(0x000000, black)

// pink
DEFINE_COLOR(0xFFC0CB, pink)
DEFINE_COLOR(0xFFB6C1, lightPink)
DEFINE_COLOR(0xFF69B4, hotPink)
DEFINE_COLOR(0xFF1493, deepPink)
DEFINE_COLOR(0xD87093, paleVioletRed)
DEFINE_COLOR(0xC71585, mediumVioletRed)

// red
DEFINE_COLOR(0xFFA07A, lightSalmon)
DEFINE_COLOR(0xFA8072, salmon)
DEFINE_COLOR(0xE9967A, darkSalmon)
DEFINE_COLOR(0xF08080, lightCoral)
DEFINE_COLOR(0xCD5C5C, indianRed)
DEFINE_COLOR(0xDC143C, crimson)
DEFINE_COLOR(0xB22222, fireBrick)
DEFINE_COLOR(0x8B0000, darkRed)
DEFINE_COLOR(0xFF0000, red)

// orange
DEFINE_COLOR(0xFF4500, orangeRed)
DEFINE_COLOR(0xFF6347, tomato)
DEFINE_COLOR(0xFF7F50, coral)
DEFINE_COLOR(0xFF8C00, darkOrange)
DEFINE_COLOR(0xFFA500, orange)
DEFINE_COLOR(0xFFD700, gold)

//yellow
DEFINE_COLOR(0xFFFF00, yellow)
DEFINE_COLOR(0xFFFFE0, lightYellow)
DEFINE_COLOR(0xFFFACD, lemonChiffon)
DEFINE_COLOR(0xFAFAD2, lightGoldenrodYellow)
DEFINE_COLOR(0xFFEFD5, papayaWhip)
DEFINE_COLOR(0xFFE4B5, moccasin)
DEFINE_COLOR(0xFFDAB9, peachPuff)
DEFINE_COLOR(0xEEE8AA, paleGoldenrod)
DEFINE_COLOR(0xF0E68C, khaki)
DEFINE_COLOR(0xBDB76B, darkKhaki)

// brown
DEFINE_COLOR(0xFFF8DC, cornSilk)
DEFINE_COLOR(0xFFEBCD, blanchedAlmond)
DEFINE_COLOR(0xFFE4C4, bisque)
DEFINE_COLOR(0xFFDEAD, navajoWhite)
DEFINE_COLOR(0xF5DEB3, wheat)
DEFINE_COLOR(0xDEB887, burlyWood)
DEFINE_COLOR(0xD2B48C, tan)
DEFINE_COLOR(0xBC8F8F, rosyBrown)
DEFINE_COLOR(0xF4A460, sandyBrown)
DEFINE_COLOR(0xDAA520, goldenrod)
DEFINE_COLOR(0xB8860B, darkGoldenrod)
DEFINE_COLOR(0xCD853F, peru)
DEFINE_COLOR(0xD2691E, chocolate)
DEFINE_COLOR(0x8B4513, saddleBrown)
DEFINE_COLOR(0xA0522D, sienna)
DEFINE_COLOR(0xA52A2A, brown)
DEFINE_COLOR(0x800000, maroon)

// green
DEFINE_COLOR(0x556B2F, darkOliveGreen)
DEFINE_COLOR(0x808000, olive)
DEFINE_COLOR(0x6B8E23, oliveDrab)
DEFINE_COLOR(0x9ACD32, yellowGreen)
DEFINE_COLOR(0x32CD32, limeGreen)
DEFINE_COLOR(0x00FF00, lime)
DEFINE_COLOR(0x7CFC00, lawnGreen)
DEFINE_COLOR(0x7FFF00, chartreuse)
DEFINE_COLOR(0xADFF2F, greenYellow)
DEFINE_COLOR(0x00FF7F, springGreen)
DEFINE_COLOR(0x00FA9A, mediumSpringGreen)
DEFINE_COLOR(0x90EE90, lightGreen)
DEFINE_COLOR(0x98FB98, paleGreen)
DEFINE_COLOR(0x8FBC8F, darkSeaGreen)
DEFINE_COLOR(0x3CB371, mediumSeaGreen)
DEFINE_COLOR(0x2E8B57, seaGreen)
DEFINE_COLOR(0x228B22, forestGreen)
DEFINE_COLOR(0x008000, green)
DEFINE_COLOR(0x006400, darkGreen)
DEFINE_COLOR(0xAFEEEE, paleTurquoise)

// cyan
DEFINE_COLOR(0x66CDAA, mediumAquamarine)
DEFINE_COLOR(0x00FFFF, aqua)
DEFINE_COLOR(0x00FFFF, cyan)
DEFINE_COLOR(0xE0FFFF, lightCyan)
DEFINE_COLOR(0x7FFFD4, aquamarine)
DEFINE_COLOR(0x40E0D0, turquoise)
DEFINE_COLOR(0x48D1CC, mediumTurquoise)
DEFINE_COLOR(0x00CED1, darkTurquoise)
DEFINE_COLOR(0x20B2AA, lightSeaGreen)
DEFINE_COLOR(0x5F9EA0, cadetBlue)
DEFINE_COLOR(0x008B8B, darkCyan)
DEFINE_COLOR(0x008080, teal)

// blue
DEFINE_COLOR(0xB0C4DE, lightSteelBlue)
DEFINE_COLOR(0xB0E0E6, powderBlue)
DEFINE_COLOR(0xADD8E6, lightBlue)
DEFINE_COLOR(0x87CEEB, skyBlue)
DEFINE_COLOR(0x87CEFA, lightSkyBlue)
DEFINE_COLOR(0x00BFFF, deepSkyBlue)
DEFINE_COLOR(0x1E90FF, dodgerBlue)
DEFINE_COLOR(0x6495ED, cornflowerBlue)
DEFINE_COLOR(0x4682B4, steelBlue)
DEFINE_COLOR(0x4169E1, royalBlue)
DEFINE_COLOR(0x0000FF, blue)
DEFINE_COLOR(0x0000CD, mediumBlue)
DEFINE_COLOR(0x00008B, darkBlue)
DEFINE_COLOR(0x000080, navy)
DEFINE_COLOR(0x191970, midnightBlue)

// purple
DEFINE_COLOR(0xE6E6FA, lavender)
DEFINE_COLOR(0xD8BFD8, thistle)
DEFINE_COLOR(0xDDA0DD, plum)
DEFINE_COLOR(0xEE82EE, violet)
DEFINE_COLOR(0xDA70D6, orchid)
DEFINE_COLOR(0xFF00FF, fuchsia)
DEFINE_COLOR(0xFF00FF, magenta)
DEFINE_COLOR(0xBA55D3, mediumOrchid)
DEFINE_COLOR(0x9370D8, mediumPurple)
DEFINE_COLOR(0x8A2BE2, blueViolet)
DEFINE_COLOR(0x9400D3, darkViolet)
DEFINE_COLOR(0x9932CC, darkOrchid)
DEFINE_COLOR(0x8B008B, darkMagenta)
DEFINE_COLOR(0x800080, purple)
DEFINE_COLOR(0x4B0082, indigo)
DEFINE_COLOR(0x483D8B, darkSlateBlue)
DEFINE_COLOR(0x6A5ACD, slateBlue)
DEFINE_COLOR(0x7B68EE, mediumSlateBlue)

+ (NSArray *) colors
{
    return @[
             self.whiteColor,
             self.snowColor,
             self.honeydewColor,
             self.mintCreamColor,
             self.azureColor,
             self.aliceBlueColor,
             self.ghostWhiteColor,
             self.whiteSmokeColor,
             self.seashellColor,
             self.beigeColor,
             self.oldLaceColor,
             self.floralWhiteColor,
             self.ivoryColor,
             self.antiqueWhiteColor,
             self.linenColor,
             self.lavenderBlushColor,
             self.mistyRoseColor,
             self.gainsboroColor,
             self.lightGrayColor,
             self.lightGreyColor,
             self.silverColor,
             self.darkGrayColor,
             self.darkGreyColor,
             self.grayColor,
             self.greyColor,
             self.dimGrayColor,
             self.dimGreyColor,
             self.lightSlateGrayColor,
             self.lightSlateGreyColor,
             self.slateGrayColor,
             self.slateGreyColor,
             self.darkSlateGrayColor,
             self.darkSlateGreyColor,
             self.blackColor,
             self.pinkColor,
             self.lightPinkColor,
             self.hotPinkColor,
             self.deepPinkColor,
             self.paleVioletRedColor,
             self.mediumVioletRedColor,
             self.lightSalmonColor,
             self.salmonColor,
             self.darkSalmonColor,
             self.lightCoralColor,
             self.indianRedColor,
             self.crimsonColor,
             self.fireBrickColor,
             self.darkRedColor,
             self.redColor,
             self.orangeRedColor,
             self.tomatoColor,
             self.coralColor,
             self.darkOrangeColor,
             self.orangeColor,
             self.goldColor,
             self.yellowColor,
             self.lightYellowColor,
             self.lemonChiffonColor,
             self.lightGoldenrodYellowColor,
             self.papayaWhipColor,
             self.moccasinColor,
             self.peachPuffColor,
             self.paleGoldenrodColor,
             self.khakiColor,
             self.darkKhakiColor,
             self.cornSilkColor,
             self.blanchedAlmondColor,
             self.bisqueColor,
             self.navajoWhiteColor,
             self.wheatColor,
             self.burlyWoodColor,
             self.tanColor,
             self.rosyBrownColor,
             self.sandyBrownColor,
             self.goldenrodColor,
             self.darkGoldenrodColor,
             self.peruColor,
             self.chocolateColor,
             self.saddleBrownColor,
             self.siennaColor,
             self.brownColor,
             self.maroonColor,
             self.darkOliveGreenColor,
             self.oliveColor,
             self.oliveDrabColor,
             self.yellowGreenColor,
             self.limeGreenColor,
             self.limeColor,
             self.lawnGreenColor,
             self.chartreuseColor,
             self.greenYellowColor,
             self.springGreenColor,
             self.mediumSpringGreenColor,
             self.lightGreenColor,
             self.paleGreenColor,
             self.darkSeaGreenColor,
             self.mediumSeaGreenColor,
             self.seaGreenColor,
             self.forestGreenColor,
             self.greenColor,
             self.darkGreenColor,
             self.paleTurquoiseColor,
             self.mediumAquamarineColor,
             self.aquaColor,
             self.cyanColor,
             self.lightCyanColor,
             self.aquamarineColor,
             self.turquoiseColor,
             self.mediumTurquoiseColor,
             self.darkTurquoiseColor,
             self.lightSeaGreenColor,
             self.cadetBlueColor,
             self.darkCyanColor,
             self.tealColor,
             self.lightSteelBlueColor,
             self.powderBlueColor,
             self.lightBlueColor,
             self.skyBlueColor,
             self.lightSkyBlueColor,
             self.deepSkyBlueColor,
             self.dodgerBlueColor,
             self.cornflowerBlueColor,
             self.steelBlueColor,
             self.royalBlueColor,
             self.blueColor,
             self.mediumBlueColor,
             self.darkBlueColor,
             self.navyColor,
             self.midnightBlueColor,
             self.lavenderColor,
             self.thistleColor,
             self.plumColor,
             self.violetColor,
             self.orchidColor,
             self.fuchsiaColor,
             self.magentaColor,
             self.mediumOrchidColor,
             self.mediumPurpleColor,
             self.blueVioletColor,
             self.darkVioletColor,
             self.darkOrchidColor,
             self.darkMagentaColor,
             self.purpleColor,
             self.indigoColor,
             self.darkSlateBlueColor,
             self.slateBlueColor,
             self.mediumSlateBlueColor,
             ];
}

+ (NSArray *) colorNames
{
    return @[
             @"white",
             @"snow",
             @"honeydew",
             @"mintCream",
             @"azure",
             @"aliceBlue",
             @"ghostWhite",
             @"whiteSmoke",
             @"seashell",
             @"beige",
             @"oldLace",
             @"floralWhite",
             @"ivory",
             @"antiqueWhite",
             @"linen",
             @"lavenderBlush",
             @"mistyRose",
             @"gainsboro",
             @"lightGray",
             @"lightGrey",
             @"silver",
             @"darkGray",
             @"darkGrey",
             @"gray",
             @"grey",
             @"dimGray",
             @"dimGrey",
             @"lightSlateGray",
             @"lightSlateGrey",
             @"slateGray",
             @"slateGrey",
             @"darkSlateGray",
             @"darkSlateGrey",
             @"black",
             @"pink",
             @"lightPink",
             @"hotPink",
             @"deepPink",
             @"paleVioletRed",
             @"mediumVioletRed",
             @"lightSalmon",
             @"salmon",
             @"darkSalmon",
             @"lightCoral",
             @"indianRed",
             @"crimson",
             @"fireBrick",
             @"darkRed",
             @"red",
             @"orangeRed",
             @"tomato",
             @"coral",
             @"darkOrange",
             @"orange",
             @"gold",
             @"yellow",
             @"lightYellow",
             @"lemonChiffon",
             @"lightGoldenrodYellow",
             @"papayaWhip",
             @"moccasin",
             @"peachPuff",
             @"paleGoldenrod",
             @"khaki",
             @"darkKhaki",
             @"cornSilk",
             @"blanchedAlmond",
             @"bisque",
             @"navajoWhite",
             @"wheat",
             @"burlyWood",
             @"tan",
             @"rosyBrown",
             @"sandyBrown",
             @"goldenrod",
             @"darkGoldenrod",
             @"peru",
             @"chocolate",
             @"saddleBrown",
             @"sienna",
             @"brown",
             @"maroon",
             @"darkOliveGreen",
             @"olive",
             @"oliveDrab",
             @"yellowGreen",
             @"limeGreen",
             @"lime",
             @"lawnGreen",
             @"chartreuse",
             @"greenYellow",
             @"springGreen",
             @"mediumSpringGreen",
             @"lightGreen",
             @"paleGreen",
             @"darkSeaGreen",
             @"mediumSeaGreen",
             @"seaGreen",
             @"forestGreen",
             @"green",
             @"darkGreen",
             @"paleTurquoise",
             @"mediumAquamarine",
             @"aqua",
             @"cyan",
             @"lightCyan",
             @"aquamarine",
             @"turquoise",
             @"mediumTurquoise",
             @"darkTurquoise",
             @"lightSeaGreen",
             @"cadetBlue",
             @"darkCyan",
             @"teal",
             @"lightSteelBlue",
             @"powderBlue",
             @"lightBlue",
             @"skyBlue",
             @"lightSkyBlue",
             @"deepSkyBlue",
             @"dodgerBlue",
             @"cornflowerBlue",
             @"steelBlue",
             @"royalBlue",
             @"blue",
             @"mediumBlue",
             @"darkBlue",
             @"navy",
             @"midnightBlue",
             @"lavender",
             @"thistle",
             @"plum",
             @"violet",
             @"orchid",
             @"fuchsia",
             @"magenta",
             @"mediumOrchid",
             @"mediumPurple",
             @"blueViolet",
             @"darkViolet",
             @"darkOrchid",
             @"darkMagenta",
             @"purple",
             @"indigo",
             @"darkSlateBlue",
             @"slateBlue",
             @"mediumSlateBlue",
             ];
}

+ (NSString *) palleteName
{
    return NSLocalizedString(@"X11 Colors", nil);
}

@end