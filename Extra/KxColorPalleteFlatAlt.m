//
//  KxColorPalleteFlatAlt.m
//  kxutils
//
//  Created by Kolyvan on 24.11.15.
//  Copyright © 2015 Kolyvan. All rights reserved.
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

// These colors taken from
// 'Flat Colors For UI Design' by Vasilis Baimas
// http://www.flatuicolorpicker.com

#import "KxColorPalleteFlatAlt.h"

@implementation KxColorPalleteFlatAlt

// Red
// Chestnut Rose 210, 77, 87
// Pomegranate 242, 38, 19
// Thunderbird 217, 30, 24
// Old Brick 150, 40, 27
// Flamingo 239, 72, 54
// Valencia 214, 69, 65
// Tall Poppy 192, 57, 43
// Monza 207, 0, 15
// Cinnabar 231, 76, 60

// Pink
// Razzmatazz 219, 10, 91
// Sunset Orange 246, 71, 71
// Wax Flower 241, 169, 160
// Cabaret 210, 82, 127
// New York Pink 224, 130, 131
// Radical Red 246, 36, 89
// Sunglo 226, 106, 106

// Purple
// Snuff 220, 198, 224
// rebeccapurple 102, 51, 153
// Honey Flower 103, 65, 114
// Wistful 174, 168, 211
// Plum 145, 61, 136
// Seance 154, 18, 179
// Medium Purple 191, 85, 236
// Light Wisteria 190, 144, 212
// Studio 142, 68, 173
// Wisteria 155, 89, 182

// Blue
// San Marino 68,108,179
// Alice Blue 228, 241, 254
// Royal Blue 65, 131, 215
// Picton Blue 89, 171, 227
// Spray 129, 207, 224
// Shakespeare 82, 179, 217
// Humming Bird 197, 239, 247
// Picton Blue 34, 167, 240
// Curious Blue 52, 152, 219
// Madison 44, 62, 80
// Dodger Blue 25, 181, 254
// Ming 51, 110, 123
// Ebony Clay 34, 49, 63
// Malibu 107, 185, 240
// Summer Sky 30, 139, 195
// Chambray 58, 83, 155
// Pickled Bluewood 52, 73, 94
// Hoki 103, 128, 159
// Jelly Bean 37, 116, 169
// Jacksons Purple 31, 58, 147
// Jordy Blue 137, 196, 244
// Steel Blue 75, 119, 190
// Fountain Blue 92, 151, 191

// Green
// Medium Turquoise 78,205,196
// Aqua Island 162, 222, 208
// Gossip 135, 211, 124
// Dark Sea Green 144, 198, 149
// Eucalyptus 38, 166, 91
// Caribbean Green 3, 201, 169
// Silver Tree 104, 195, 163
// Downy 101, 198, 187
// Mountain Meadow 27, 188, 155
// Light Sea Green 27, 163, 156
// Medium Aquamarine 102, 204, 153
// Turquoise 54, 215, 183
// Madang 200, 247, 197
// Riptide 134, 226, 213
// Shamrock 46, 204, 113
// Niagara 22, 160, 133
// Emerald 63, 195, 128
// Green Haze 1, 152, 117
// Free Speech Aquamarine 3, 166, 120
// Ocean Green 77, 175, 124
// Niagara 1 42, 187, 155
// Jade 0, 177, 106
// Salem 30, 130, 76
// Observatory 4, 147, 114
// Jungle Green 38, 194, 129

// Yellow
// Cream Can 245, 215, 110
// Ripe Lemon 247, 202, 24
// Saffron 244, 208, 63

// Orange
// Confetti 233,212,96
// Cape Honey 253, 227, 167
// California 248, 148, 6
// Fire Bush 235, 149, 50
// Tahiti Gold 232, 126, 4
// Casablanca 244, 179, 80
// Crusta 242, 120, 75
// Sea Buckthorn 235, 151, 78
// Lightning Yellow 245, 171, 53
// Burnt Orange 211, 84, 0
// Buttercup 243, 156, 18
// Ecstasy 249, 105, 14
// Sandstorm 249, 191, 59
// Jaffa 242, 121, 53
// Zest 230, 126, 34

// Gray
// White Smoke 236,236,236
// Lynch 108, 122, 137
// Pumice 210, 215, 211
// Gallery 238, 238, 238
// Silver Sand 189, 195, 199
// Porcelain 236, 240, 241
// Cascade 149, 165, 166
// Iron 218, 223, 225
// Edward 171, 183, 183
// Cararra 242, 241, 239
// Silver 191, 191, 191

#define DEF_COLOR_PROP(name, R, G, B) \
    + (UIColor *) name ## Color \
    { \
        return [UIColor colorWithRed:R/255. green:G/255. blue:B/255. alpha:1.]; \
    }


DEF_COLOR_PROP(chestnutRose, 210, 77, 87)
DEF_COLOR_PROP(pomegranate, 242, 38, 19)
DEF_COLOR_PROP(thunderbird, 217, 30, 24)
DEF_COLOR_PROP(oldBrick, 150, 40, 27)
DEF_COLOR_PROP(flamingo, 239, 72, 54)
DEF_COLOR_PROP(valencia, 214, 69, 65)
DEF_COLOR_PROP(tallPoppy, 192, 57, 43)
DEF_COLOR_PROP(monza, 207, 0, 15)
DEF_COLOR_PROP(cinnabar, 231, 76, 60)

DEF_COLOR_PROP(razzmatazz, 219, 10, 91)
DEF_COLOR_PROP(sunsetOrange, 246, 71, 71)
DEF_COLOR_PROP(waxFlower, 241, 169, 160)
DEF_COLOR_PROP(cabaret, 210, 82, 127)
DEF_COLOR_PROP(newYorkPink, 224, 130, 131)
DEF_COLOR_PROP(radicalRed, 246, 36, 89)
DEF_COLOR_PROP(sunglo, 226, 106, 106)

DEF_COLOR_PROP(snuff, 220, 198, 224)
DEF_COLOR_PROP(rebeccaPurple, 102, 51, 153)
DEF_COLOR_PROP(honeyFlower, 103, 65, 114)
DEF_COLOR_PROP(wistful, 174, 168, 211)
DEF_COLOR_PROP(plum, 145, 61, 136)
DEF_COLOR_PROP(seance, 154, 18, 179)
DEF_COLOR_PROP(mediumPurple, 191, 85, 236)
DEF_COLOR_PROP(lightWisteria, 190, 144, 212)
DEF_COLOR_PROP(studio, 142, 68, 173)
DEF_COLOR_PROP(wisteria, 155, 89, 182)

DEF_COLOR_PROP(sanMarino, 68,108,179)
DEF_COLOR_PROP(aliceBlue, 228, 241, 254)
DEF_COLOR_PROP(royalBlue, 65, 131, 215)
DEF_COLOR_PROP(pictonBlue, 89, 171, 227)
DEF_COLOR_PROP(spray, 129, 207, 224)
DEF_COLOR_PROP(shakespeare, 82, 179, 217)
DEF_COLOR_PROP(hummingBird, 197, 239, 247)
DEF_COLOR_PROP(pistonBlue, 34, 167, 240)
DEF_COLOR_PROP(curiousBlue, 52, 152, 219)
DEF_COLOR_PROP(madison, 44, 62, 80)
DEF_COLOR_PROP(dodgerBlue, 25, 181, 254)
DEF_COLOR_PROP(ming, 51, 110, 123)
DEF_COLOR_PROP(ebonyClay, 34, 49, 63)
DEF_COLOR_PROP(malibu, 107, 185, 240)
DEF_COLOR_PROP(summerSky, 30, 139, 195)
DEF_COLOR_PROP(chambray, 58, 83, 155)
DEF_COLOR_PROP(pickledBluewood, 52, 73, 94)
DEF_COLOR_PROP(hoki, 103, 128, 159)
DEF_COLOR_PROP(jellyBean, 37, 116, 169)
DEF_COLOR_PROP(jacksonsPurple, 31, 58, 147)
DEF_COLOR_PROP(jordyBlue, 137, 196, 244)
DEF_COLOR_PROP(steelBlue, 75, 119, 190)
DEF_COLOR_PROP(fountainBlue, 92, 151, 191)

DEF_COLOR_PROP(mediumTurquoise, 78,205,196)
DEF_COLOR_PROP(aquaIsland, 162, 222, 208)
DEF_COLOR_PROP(gossip, 135, 211, 124)
DEF_COLOR_PROP(darkSeaGreen, 144, 198, 149)
DEF_COLOR_PROP(eucalyptus, 38, 166, 91)
DEF_COLOR_PROP(caribbeanGreen, 3, 201, 169)
DEF_COLOR_PROP(silverTree, 104, 195, 163)
DEF_COLOR_PROP(downy, 101, 198, 187)
DEF_COLOR_PROP(mountainMeadow, 27, 188, 155)
DEF_COLOR_PROP(lightSeaGreen, 27, 163, 156)
DEF_COLOR_PROP(mediumAquamarine, 102, 204, 153)
DEF_COLOR_PROP(turquoise, 54, 215, 183)
DEF_COLOR_PROP(madang, 200, 247, 197)
DEF_COLOR_PROP(riptide, 134, 226, 213)
DEF_COLOR_PROP(shamrock, 46, 204, 113)
DEF_COLOR_PROP(niagara, 22, 160, 133)
DEF_COLOR_PROP(emerald, 63, 195, 128)
DEF_COLOR_PROP(greenHaze, 1, 152, 117)
DEF_COLOR_PROP(aquamarine, 3, 166, 120)
DEF_COLOR_PROP(oceanGreen, 77, 175, 124)
DEF_COLOR_PROP(niagaraOne, 42, 187, 155)
DEF_COLOR_PROP(jade, 0, 177, 106)
DEF_COLOR_PROP(salem, 30, 130, 76)
DEF_COLOR_PROP(observatory, 4, 147, 114)
DEF_COLOR_PROP(jungleGreen, 38, 194, 129)

DEF_COLOR_PROP(creamCan, 245, 215, 110)
DEF_COLOR_PROP(ripeLemon, 247, 202, 24)
DEF_COLOR_PROP(saffron, 244, 208, 63)

DEF_COLOR_PROP(confetti, 233,212,96)
DEF_COLOR_PROP(capeHoney, 253, 227, 167)
DEF_COLOR_PROP(california, 248, 148, 6)
DEF_COLOR_PROP(fireBush, 235, 149, 50)
DEF_COLOR_PROP(tahitiGold, 232, 126, 4)
DEF_COLOR_PROP(casablanca, 244, 179, 80)
DEF_COLOR_PROP(crusta, 242, 120, 75)
DEF_COLOR_PROP(seaBuckthorn, 235, 151, 78)
DEF_COLOR_PROP(lightningYellow, 245, 171, 53)
DEF_COLOR_PROP(burntOrange, 211, 84, 0)
DEF_COLOR_PROP(buttercup, 243, 156, 18)
DEF_COLOR_PROP(ecstasy, 249, 105, 14)
DEF_COLOR_PROP(sandstorm, 249, 191, 59)
DEF_COLOR_PROP(jaffa, 242, 121, 53)
DEF_COLOR_PROP(zest, 230, 126, 34)

DEF_COLOR_PROP(whiteSmoke, 236,236,236)
DEF_COLOR_PROP(lynch, 108, 122, 137)
DEF_COLOR_PROP(pumice, 210, 215, 211)
DEF_COLOR_PROP(gallery, 238, 238, 238)
DEF_COLOR_PROP(silverSand, 189, 195, 199)
DEF_COLOR_PROP(porcelain, 236, 240, 241)
DEF_COLOR_PROP(cascade, 149, 165, 166)
DEF_COLOR_PROP(iron, 218, 223, 225)
DEF_COLOR_PROP(edward, 171, 183, 183)
DEF_COLOR_PROP(cararra, 242, 241, 239)
DEF_COLOR_PROP(silver, 191, 191, 191)

+ (NSArray *) colors
{
    return @[
             self.chestnutRoseColor,
             self.pomegranateColor,
             self.thunderbirdColor,
             self.oldBrickColor,
             self.flamingoColor,
             self.valenciaColor,
             self.tallPoppyColor,
             self.monzaColor,
             self.cinnabarColor,
             
             self.razzmatazzColor,
             self.sunsetOrangeColor,
             self.waxFlowerColor,
             self.cabaretColor,
             self.newYorkPinkColor,
             self.radicalRedColor,
             self.sungloColor,
             
             self.snuffColor,
             self.rebeccaPurpleColor,
             self.honeyFlowerColor,
             self.wistfulColor,
             self.plumColor,
             self.seanceColor,
             self.mediumPurpleColor,
             self.lightWisteriaColor,
             self.studioColor,
             self.wisteriaColor,
             
             self.sanMarinoColor,
             self.aliceBlueColor,
             self.royalBlueColor,
             self.pictonBlueColor,
             self.sprayColor,
             self.shakespeareColor,
             self.hummingBirdColor,
             self.pistonBlueColor,
             self.curiousBlueColor,
             self.madisonColor,
             self.dodgerBlueColor,
             self.mingColor,
             self.ebonyClayColor,
             self.malibuColor,
             self.summerSkyColor,
             self.chambrayColor,
             self.pickledBluewoodColor,
             self.hokiColor,
             self.jellyBeanColor,
             self.jacksonsPurpleColor,
             self.jordyBlueColor,
             self.steelBlueColor,
             self.fountainBlueColor,
             
             self.mediumTurquoiseColor,
             self.aquaIslandColor,
             self.gossipColor,
             self.darkSeaGreenColor,
             self.eucalyptusColor,
             self.caribbeanGreenColor,
             self.silverTreeColor,
             self.downyColor,
             self.mountainMeadowColor,
             self.lightSeaGreenColor,
             self.mediumAquamarineColor,
             self.turquoiseColor,
             self.madangColor,
             self.riptideColor,
             self.shamrockColor,
             self.niagaraColor,
             self.emeraldColor,
             self.greenHazeColor,
             self.aquamarineColor,
             self.oceanGreenColor,
             self.niagaraOneColor,
             self.jadeColor,
             self.salemColor,
             self.observatoryColor,
             self.jungleGreenColor,
             
             self.creamCanColor,
             self.ripeLemonColor,
             self.saffronColor,
             
             self.confettiColor,
             self.capeHoneyColor,
             self.californiaColor,
             self.fireBushColor,
             self.tahitiGoldColor,
             self.casablancaColor,
             self.crustaColor,
             self.seaBuckthornColor,
             self.lightningYellowColor,
             self.burntOrangeColor,
             self.buttercupColor,
             self.ecstasyColor,
             self.sandstormColor,
             self.jaffaColor,
             self.zestColor,
             
             self.whiteSmokeColor,
             self.lynchColor,
             self.pumiceColor,
             self.galleryColor,
             self.silverSandColor,
             self.porcelainColor,
             self.cascadeColor,
             self.ironColor,
             self.edwardColor,
             self.cararraColor,
             self.silverColor,
             ];
}

+ (NSArray *) colorNames
{
    return @[
             @"chestnutRose",
             @"pomegranate",
             @"thunderbird",
             @"oldBrick",
             @"flamingo",
             @"valencia",
             @"tallPoppy",
             @"monza",
             @"cinnabar",
             
             @"razzmatazz",
             @"sunsetOrange",
             @"waxFlower",
             @"cabaret",
             @"newYorkPink",
             @"radicalRed",
             @"sunglo",
             
             @"snuff",
             @"rebeccaPurple",
             @"honeyFlower",
             @"wistful",
             @"plum",
             @"seance",
             @"mediumPurple",
             @"lightWisteria",
             @"studio",
             @"wisteria",
             
             @"sanMarino",
             @"aliceBlue",
             @"royalBlue",
             @"pictonBlue",
             @"spray",
             @"shakespeare",
             @"hummingBird",
             @"pistonBlue",
             @"curiousBlue",
             @"madison",
             @"dodgerBlue",
             @"ming",
             @"ebonyClay",
             @"malibu",
             @"summerSky",
             @"chambray",
             @"pickledBluewood",
             @"hoki",
             @"jellyBean",
             @"jacksonsPurple",
             @"jordyBlue",
             @"steelBlue",
             @"fountainBlue",
             
             @"mediumTurquoise",
             @"aquaIsland",
             @"gossip",
             @"darkSeaGreen",
             @"eucalyptus",
             @"caribbeanGreen",
             @"silverTree",
             @"downy",
             @"mountainMeadow",
             @"lightSeaGreen",
             @"mediumAquamarine",
             @"turquoise",
             @"madang",
             @"riptide",
             @"shamrock",
             @"niagara",
             @"emerald",
             @"greenHaze",
             @"aquamarine",
             @"oceanGreen",
             @"niagaraOne",
             @"jade",
             @"salem",
             @"observatory",
             @"jungleGreen",
             
             @"creamCan",
             @"ripeLemon",
             @"saffron",
             
             @"confetti",
             @"capeHoney",
             @"california",
             @"fireBush",
             @"tahitiGold",
             @"casablanca",
             @"crusta",
             @"seaBuckthorn",
             @"lightningYellow",
             @"burntOrange",
             @"buttercup",
             @"ecstasy",
             @"sandstorm",
             @"jaffa",
             @"zest",
             
             @"whiteSmoke",
             @"lynch",
             @"pumice",
             @"gallery",
             @"silverSand",
             @"porcelain",
             @"cascade",
             @"iron",
             @"edward",
             @"cararra",
             @"silver",
             ];
}


+ (NSString *) palleteName
{
    return NSLocalizedString(@"Alt Flat Colors", nil);
}

@end

