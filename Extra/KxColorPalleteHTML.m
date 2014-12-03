//
//  KxColorPalleteHTML.m
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

#import "KxColorPalleteHTML.h"
#import "UIColor+KxUtils.h"

#define DEFINE_COLOR(value, name) +(UIColor *)name ## Color { return [UIColor colorWithRGBValue:value]; }

@implementation KxColorPalleteHTML

DEFINE_COLOR(0x000000, black)
DEFINE_COLOR(0x0C090A, night)
DEFINE_COLOR(0x2C3539, gunmetal)
DEFINE_COLOR(0x2B1B17, midnight)
DEFINE_COLOR(0x34282C, charcoal)
DEFINE_COLOR(0x25383C, darkSlateGrey)
DEFINE_COLOR(0x3B3131, oil)
DEFINE_COLOR(0x413839, blackCat)
DEFINE_COLOR(0x3D3C3A, iridium)
DEFINE_COLOR(0x463E3F, blackEel)
DEFINE_COLOR(0x4C4646, blackCow)
DEFINE_COLOR(0x504A4B, grayWolf)
DEFINE_COLOR(0x565051, vampireGray)
DEFINE_COLOR(0x5C5858, grayDolphin)
DEFINE_COLOR(0x625D5D, carbonGray)
DEFINE_COLOR(0x666362, ashGray)
DEFINE_COLOR(0x6D6968, cloudyGray)
DEFINE_COLOR(0x726E6D, smokeyGray)
DEFINE_COLOR(0x736F6E, gray)
DEFINE_COLOR(0x837E7C, granite)
DEFINE_COLOR(0x848482, battleshipGray)
DEFINE_COLOR(0xB6B6B4, grayCloud)
DEFINE_COLOR(0xD1D0CE, grayGoose)
DEFINE_COLOR(0xE5E4E2, platinum)
DEFINE_COLOR(0xBCC6CC, metallicSilver)
DEFINE_COLOR(0x98AFC7, blueGray)
DEFINE_COLOR(0x6D7B8D, lightSlateGray)
DEFINE_COLOR(0x657383, slateGray)
DEFINE_COLOR(0x616D7E, jetGray)
DEFINE_COLOR(0x646D7E, mistBlue)
DEFINE_COLOR(0x566D7E, marbleBlue)
DEFINE_COLOR(0x737CA1, mediumSlateBlue)
DEFINE_COLOR(0x4863A0, steelBlue)
DEFINE_COLOR(0x2B547E, blueJay)
DEFINE_COLOR(0x2B3856, darkSlateBlue)
DEFINE_COLOR(0x151B54, midnightBlue)
DEFINE_COLOR(0x000080, navyBlue)
DEFINE_COLOR(0x342D7E, blueWhale)
DEFINE_COLOR(0x15317E, lapisBlue)
DEFINE_COLOR(0x0000A0, earthBlue)
DEFINE_COLOR(0x0020C2, cobaltBlue)
DEFINE_COLOR(0x0041C2, blueberryBlue)
DEFINE_COLOR(0x2554C7, sapphireBlue)
DEFINE_COLOR(0x1569C7, blueEyes)
DEFINE_COLOR(0x2B60DE, royalBlue)
DEFINE_COLOR(0x1F45FC, blueOrchid)
DEFINE_COLOR(0x6960EC, blueLotus)
DEFINE_COLOR(0x736AFF, lightSlateBlue)
DEFINE_COLOR(0x357EC7, slateBlue)
DEFINE_COLOR(0x368BC1, glacialBlueIce)
DEFINE_COLOR(0x488AC7, silkBlue)
DEFINE_COLOR(0x3090C7, blueIvy)
DEFINE_COLOR(0x659EC7, blueKoi)
DEFINE_COLOR(0x87AFC7, columbiaBlue)
DEFINE_COLOR(0x95B9C7, babyBlue)
DEFINE_COLOR(0x728FCE, lightSteelBlue)
DEFINE_COLOR(0x2B65EC, oceanBlue)
DEFINE_COLOR(0x306EFF, blueRibbon)
DEFINE_COLOR(0x157DEC, blueDress)
DEFINE_COLOR(0x1589FF, dodgerBlue)
DEFINE_COLOR(0x6495ED, cornflowerBlue)
DEFINE_COLOR(0x6698FF, skyBlue)
DEFINE_COLOR(0x38ACEC, butterflyBlue)
DEFINE_COLOR(0x56A5EC, iceberg)
DEFINE_COLOR(0x5CB3FF, crystalBlue)
DEFINE_COLOR(0x3BB9FF, deepSkyBlue)
DEFINE_COLOR(0x79BAEC, denimBlue)
DEFINE_COLOR(0x82CAFA, lightSkyBlue)
DEFINE_COLOR(0x82CAFF, daySkyBlue)
DEFINE_COLOR(0xA0CFEC, jeansBlue)
DEFINE_COLOR(0xB7CEEC, blueAngel)
DEFINE_COLOR(0xB4CFEC, pastelBlue)
DEFINE_COLOR(0xC2DFFF, seaBlue)
DEFINE_COLOR(0xC6DEFF, powderBlue)
DEFINE_COLOR(0xAFDCEC, coralBlue)
DEFINE_COLOR(0xADDFFF, lightBlue)
DEFINE_COLOR(0xBDEDFF, robinEggBlue)
DEFINE_COLOR(0xCFECEC, paleBlueLily)
DEFINE_COLOR(0xE0FFFF, lightCyan)
DEFINE_COLOR(0xEBF4FA, water)
DEFINE_COLOR(0xF0F8FF, aliceBlue)
DEFINE_COLOR(0xF0FFFF, azure)
DEFINE_COLOR(0xCCFFFF, lightSlate)
DEFINE_COLOR(0x93FFE8, lightAquamarine)
DEFINE_COLOR(0x9AFEFF, electricBlue)
DEFINE_COLOR(0x7FFFD4, aquamarine)
DEFINE_COLOR(0x00FFFF, aqua)
DEFINE_COLOR(0x7DFDFE, tronBlue)
DEFINE_COLOR(0x57FEFF, blueZircon)
DEFINE_COLOR(0x8EEBEC, blueLagoon)
DEFINE_COLOR(0x50EBEC, celeste)
DEFINE_COLOR(0x4EE2EC, blueDiamond)
DEFINE_COLOR(0x81D8D0, tiffanyBlue)
DEFINE_COLOR(0x92C7C7, cyanOpaque)
DEFINE_COLOR(0x77BFC7, blueHosta)
DEFINE_COLOR(0x78C7C7, northernLightsBlue)
DEFINE_COLOR(0x48CCCD, mediumTurquoise)
DEFINE_COLOR(0x43C6DB, turquoise)
DEFINE_COLOR(0x46C7C7, jellyfish)
DEFINE_COLOR(0x43BFC7, macawBlueGreen)
DEFINE_COLOR(0x3EA99F, lightSeaGreen)
DEFINE_COLOR(0x3B9C9C, darkTurquoise)
DEFINE_COLOR(0x438D80, seaTurtleGreen)
DEFINE_COLOR(0x348781, mediumAquamarine)
DEFINE_COLOR(0x307D7E, greenishBlue)
DEFINE_COLOR(0x5E7D7E, grayishTurquoise)
DEFINE_COLOR(0x4C787E, beetleGreen)
DEFINE_COLOR(0x008080, teal)
DEFINE_COLOR(0x4E8975, seaGreen)
DEFINE_COLOR(0x78866B, camouflageGreen)
DEFINE_COLOR(0x848b79, sageGreen)
DEFINE_COLOR(0x617C58, hazelGreen)
DEFINE_COLOR(0x728C00, venomGreen)
DEFINE_COLOR(0x667C26, fernGreen)
DEFINE_COLOR(0x254117, darkForrestGreen)
DEFINE_COLOR(0x306754, mediumSeaGreen)
DEFINE_COLOR(0x347235, mediumForestGreen)
DEFINE_COLOR(0x437C17, seaweedGreen)
DEFINE_COLOR(0x387C44, pineGreen)
DEFINE_COLOR(0x347C2C, jungleGreen)
DEFINE_COLOR(0x347C17, shamrockGreen)
DEFINE_COLOR(0x348017, mediumSpringGreen)
DEFINE_COLOR(0x4E9258, forestGreen)
DEFINE_COLOR(0x6AA121, greenOnion)
DEFINE_COLOR(0x4AA02C, springGreen)
DEFINE_COLOR(0x41A317, limeGreen)
DEFINE_COLOR(0x3EA055, cloverGreen)
DEFINE_COLOR(0x6CBB3C, greenSnake)
DEFINE_COLOR(0x6CC417, alienGreen)
DEFINE_COLOR(0x4CC417, greenApple)
DEFINE_COLOR(0x52D017, yellowGreen)
DEFINE_COLOR(0x4CC552, kellyGreen)
DEFINE_COLOR(0x54C571, zombieGreen)
DEFINE_COLOR(0x99C68E, frogGreen)
DEFINE_COLOR(0x89C35C, greenPeas)
DEFINE_COLOR(0x85BB65, dollarBillGreen)
DEFINE_COLOR(0x8BB381, darkSeaGreen)
DEFINE_COLOR(0x9CB071, iguanaGreen)
DEFINE_COLOR(0xB2C248, avocadoGreen)
DEFINE_COLOR(0x9DC209, pistachioGreen)
DEFINE_COLOR(0xA1C935, saladGreen)
DEFINE_COLOR(0x7FE817, hummingbirdGreen)
DEFINE_COLOR(0x59E817, nebulaGreen)
DEFINE_COLOR(0x57E964, stoplightGoGreen)
DEFINE_COLOR(0x64E986, algaeGreen)
DEFINE_COLOR(0x5EFB6E, jadeGreen)
DEFINE_COLOR(0x00FF00, green)
DEFINE_COLOR(0x5FFB17, emeraldGreen)
DEFINE_COLOR(0x87F717, lawnGreen)
DEFINE_COLOR(0x8AFB17, chartreuse)
DEFINE_COLOR(0x6AFB92, dragonGreen)
DEFINE_COLOR(0x98FF98, mintGreen)
DEFINE_COLOR(0xB5EAAA, greenThumb)
DEFINE_COLOR(0xC3FDB8, lightJade)
DEFINE_COLOR(0xCCFB5D, teaGreen)
DEFINE_COLOR(0xB1FB17, greenYellow)
DEFINE_COLOR(0xBCE954, slimeGreen)
DEFINE_COLOR(0xEDDA74, goldenrod)
DEFINE_COLOR(0xEDE275, harvestGold)
DEFINE_COLOR(0xFFE87C, sunYellow)
DEFINE_COLOR(0xFFFF00, yellow)
DEFINE_COLOR(0xFFF380, cornYellow)
DEFINE_COLOR(0xFFFFC2, parchment)
DEFINE_COLOR(0xFFFFCC, cream)
DEFINE_COLOR(0xFFF8C6, lemonChiffon)
DEFINE_COLOR(0xFFF8DC, cornsilk)
DEFINE_COLOR(0xF5F5DC, beige)
DEFINE_COLOR(0xFBF6D9, blonde)
DEFINE_COLOR(0xFAEBD7, antiqueWhite)
DEFINE_COLOR(0xF7E7CE, champagne)
DEFINE_COLOR(0xFFEBCD, blanchedAlmond)
DEFINE_COLOR(0xF3E5AB, vanilla)
DEFINE_COLOR(0xECE5B6, tanBrown)
DEFINE_COLOR(0xFFE5B4, peach)
DEFINE_COLOR(0xFFDB58, mustard)
DEFINE_COLOR(0xFFD801, rubberDuckyYellow)
DEFINE_COLOR(0xFDD017, brightGold)
DEFINE_COLOR(0xEAC117, goldenBrown)
DEFINE_COLOR(0xF2BB66, cheese)
DEFINE_COLOR(0xFBB917, saffron)
DEFINE_COLOR(0xFBB117, beer)
DEFINE_COLOR(0xFFA62F, cantaloupe)
DEFINE_COLOR(0xE9AB17, beeYellow)
DEFINE_COLOR(0xE2A76F, brownSugar)
DEFINE_COLOR(0xDEB887, burlyWood)
DEFINE_COLOR(0xFFCBA4, deepPeach)
DEFINE_COLOR(0xC9BE62, gingerBrown)
DEFINE_COLOR(0xE8A317, schoolBusYellow)
DEFINE_COLOR(0xEE9A4D, sandyBrown)
DEFINE_COLOR(0xC8B560, fallLeafBrown)
DEFINE_COLOR(0xD4A017, orangeGold)
DEFINE_COLOR(0xC2B280, sand)
DEFINE_COLOR(0xC7A317, cookieBrown)
DEFINE_COLOR(0xC68E17, caramel)
DEFINE_COLOR(0xB5A642, brass)
DEFINE_COLOR(0xADA96E, khaki)
DEFINE_COLOR(0xC19A6B, camelBrown)
DEFINE_COLOR(0xCD7F32, bronze)
DEFINE_COLOR(0xC88141, tigerOrange)
DEFINE_COLOR(0xC58917, cinnamon)
DEFINE_COLOR(0xAF9B60, bulletShell)
DEFINE_COLOR(0xAF7817, darkGoldenrod)
DEFINE_COLOR(0xB87333, copper)
DEFINE_COLOR(0x966F33, wood)
DEFINE_COLOR(0x806517, oakBrown)
DEFINE_COLOR(0x827839, moccasin)
DEFINE_COLOR(0x827B60, armyBrown)
DEFINE_COLOR(0x786D5F, sandstone)
DEFINE_COLOR(0x493D26, mocha)
DEFINE_COLOR(0x483C32, taupe)
DEFINE_COLOR(0x6F4E37, coffee)
DEFINE_COLOR(0x835C3B, brownBear)
DEFINE_COLOR(0x7F5217, redDirt)
DEFINE_COLOR(0x7F462C, sepia)
DEFINE_COLOR(0xC47451, orangeSalmon)
DEFINE_COLOR(0xC36241, rust)
DEFINE_COLOR(0xC35817, redFox)
DEFINE_COLOR(0xC85A17, chocolate)
DEFINE_COLOR(0xCC6600, sedona)
DEFINE_COLOR(0xE56717, papayaOrange)
DEFINE_COLOR(0xE66C2C, halloweenOrange)
DEFINE_COLOR(0xF87217, pumpkinOrange)
DEFINE_COLOR(0xF87431, constructionConeOrange)
DEFINE_COLOR(0xE67451, sunriseOrange)
DEFINE_COLOR(0xFF8040, mangoOrange)
DEFINE_COLOR(0xF88017, darkOrange)
DEFINE_COLOR(0xFF7F50, coral)
DEFINE_COLOR(0xF88158, basketBallOrange)
DEFINE_COLOR(0xF9966B, lightSalmon)
DEFINE_COLOR(0xE78A61, tangerine)
DEFINE_COLOR(0xE18B6B, darkSalmon)
DEFINE_COLOR(0xE77471, lightCoral)
DEFINE_COLOR(0xF75D59, beanRed)
DEFINE_COLOR(0xE55451, valentineRed)
DEFINE_COLOR(0xE55B3C, shockingOrange)
DEFINE_COLOR(0xFF0000, red)
DEFINE_COLOR(0xFF2400, scarlet)
DEFINE_COLOR(0xF62217, rubyRed)
DEFINE_COLOR(0xF70D1A, ferrariRed)
DEFINE_COLOR(0xF62817, fireEngineRed)
DEFINE_COLOR(0xE42217, lavaRed)
DEFINE_COLOR(0xE41B17, loveRed)
DEFINE_COLOR(0xDC381F, grapefruit)
DEFINE_COLOR(0xC34A2C, chestnutRed)
DEFINE_COLOR(0xC24641, cherryRed)
DEFINE_COLOR(0xC04000, mahogany)
DEFINE_COLOR(0xC11B17, chilliPepper)
DEFINE_COLOR(0x9F000F, cranberry)
DEFINE_COLOR(0x990012, redWine)
DEFINE_COLOR(0x8C001A, burgundy)
DEFINE_COLOR(0x954535, chestnut)
DEFINE_COLOR(0x7E3517, bloodRed)
DEFINE_COLOR(0x8A4117, sienna)
DEFINE_COLOR(0x7E3817, sangria)
DEFINE_COLOR(0x800517, firebrick)
DEFINE_COLOR(0x810541, maroon)
DEFINE_COLOR(0x7D0541, plumPie)
DEFINE_COLOR(0x7E354D, velvetMaroon)
DEFINE_COLOR(0x7D0552, plumVelvet)
DEFINE_COLOR(0x7F4E52, rosyFinch)
DEFINE_COLOR(0x7F5A58, puce)
DEFINE_COLOR(0x7F525D, dullPurple)
DEFINE_COLOR(0xB38481, rosyBrown)
DEFINE_COLOR(0xC5908E, khakiRose)
DEFINE_COLOR(0xC48189, pinkBow)
DEFINE_COLOR(0xC48793, lipstickPink)
DEFINE_COLOR(0xE8ADAA, rose)
DEFINE_COLOR(0xEDC9AF, desertSand)
DEFINE_COLOR(0xFDD7E4, pigPink)
DEFINE_COLOR(0xFCDFFF, cottonCandy)
DEFINE_COLOR(0xFFDFDD, pinkBubblegum)
DEFINE_COLOR(0xFBBBB9, mistyRose)
DEFINE_COLOR(0xFAAFBE, pink)
DEFINE_COLOR(0xFAAFBA, lightPink)
DEFINE_COLOR(0xF9A7B0, flamingoPink)
DEFINE_COLOR(0xE7A1B0, pinkRose)
DEFINE_COLOR(0xE799A3, pinkDaisy)
DEFINE_COLOR(0xE38AAE, cadillacPink)
DEFINE_COLOR(0xF778A1, carnationPink)
DEFINE_COLOR(0xE56E94, blushRed)
DEFINE_COLOR(0xF660AB, hotPink)
DEFINE_COLOR(0xFC6C85, watermelonPink)
DEFINE_COLOR(0xF6358A, violetRed)
DEFINE_COLOR(0xF52887, deepPink)
DEFINE_COLOR(0xE45E9D, pinkCupcake)
DEFINE_COLOR(0xE4287C, pinkLemonade)
DEFINE_COLOR(0xF535AA, neonPink)
DEFINE_COLOR(0xFF00FF, magenta)
DEFINE_COLOR(0xE3319D, dimorphothecaMagenta)
DEFINE_COLOR(0xF433FF, brightNeonPink)
DEFINE_COLOR(0xD16587, paleVioletRed)
DEFINE_COLOR(0xC25A7C, tulipPink)
DEFINE_COLOR(0xCA226B, mediumVioletRed)
DEFINE_COLOR(0xC12869, roguePink)
DEFINE_COLOR(0xC12267, burntPink)
DEFINE_COLOR(0xC25283, bashfulPink)
DEFINE_COLOR(0xB93B8F, plum)
DEFINE_COLOR(0x7E587E, violaPurple)
DEFINE_COLOR(0x571B7E, purpleIris)
DEFINE_COLOR(0x583759, plumPurple)
DEFINE_COLOR(0x4B0082, indigo)
DEFINE_COLOR(0x461B7E, purpleMonster)
DEFINE_COLOR(0x4E387E, purpleHaze)
DEFINE_COLOR(0x614051, eggplant)
DEFINE_COLOR(0x5E5A80, grape)
DEFINE_COLOR(0x6A287E, purpleJam)
DEFINE_COLOR(0x7D1B7E, darkOrchid)
DEFINE_COLOR(0xA74AC7, purpleFlower)
DEFINE_COLOR(0xB048B5, mediumOrchid)
DEFINE_COLOR(0x6C2DC7, purpleAmethyst)
DEFINE_COLOR(0x842DCE, darkViolet)
DEFINE_COLOR(0x8D38C9, violet)
DEFINE_COLOR(0x7A5DC7, purpleSageBush)
DEFINE_COLOR(0x7F38EC, lovelyPurple)
DEFINE_COLOR(0x8E35EF, purple)
DEFINE_COLOR(0x893BFF, aztechPurple)
DEFINE_COLOR(0x8467D7, mediumPurple)
DEFINE_COLOR(0xA23BEC, jasminePurple)
DEFINE_COLOR(0xB041FF, purpleDaffodil)
DEFINE_COLOR(0xC45AEC, tyrianPurple)
DEFINE_COLOR(0x9172EC, crocusPurple)
DEFINE_COLOR(0x9E7BFF, purpleMimosa)
DEFINE_COLOR(0xD462FF, heliotropePurple)
DEFINE_COLOR(0xE238EC, crimson)
DEFINE_COLOR(0xC38EC7, purpleDragon)
DEFINE_COLOR(0xC8A2C8, lilac)
DEFINE_COLOR(0xE6A9EC, blushPink)
DEFINE_COLOR(0xE0B0FF, mauve)
DEFINE_COLOR(0xC6AEC7, wisteriaPurple)
DEFINE_COLOR(0xF9B7FF, blossomPink)
DEFINE_COLOR(0xD2B9D3, thistle)
DEFINE_COLOR(0xE9CFEC, periwinkle)
DEFINE_COLOR(0xEBDDE2, lavenderPinocchio)
DEFINE_COLOR(0xE3E4FA, lavenderBlue)
DEFINE_COLOR(0xFDEEF4, pearl)
DEFINE_COLOR(0xFFF5EE, seaShell)
DEFINE_COLOR(0xFEFCFF, milkWhite)
DEFINE_COLOR(0xFFFFFF, white)

+ (NSArray *) colors
{
    return @[
             self.blackColor,
             self.nightColor,
             self.gunmetalColor,
             self.midnightColor,
             self.charcoalColor,
             self.darkSlateGreyColor,
             self.oilColor,
             self.blackCatColor,
             self.iridiumColor,
             self.blackEelColor,
             self.blackCowColor,
             self.grayWolfColor,
             self.vampireGrayColor,
             self.grayDolphinColor,
             self.carbonGrayColor,
             self.ashGrayColor,
             self.cloudyGrayColor,
             self.smokeyGrayColor,
             self.grayColor,
             self.graniteColor,
             self.battleshipGrayColor,
             self.grayCloudColor,
             self.grayGooseColor,
             self.platinumColor,
             self.metallicSilverColor,
             self.blueGrayColor,
             self.lightSlateGrayColor,
             self.slateGrayColor,
             self.jetGrayColor,
             self.mistBlueColor,
             self.marbleBlueColor,
             self.mediumSlateBlueColor,
             self.steelBlueColor,
             self.blueJayColor,
             self.darkSlateBlueColor,
             self.midnightBlueColor,
             self.navyBlueColor,
             self.blueWhaleColor,
             self.lapisBlueColor,
             self.earthBlueColor,
             self.cobaltBlueColor,
             self.blueberryBlueColor,
             self.sapphireBlueColor,
             self.blueEyesColor,
             self.royalBlueColor,
             self.blueOrchidColor,
             self.blueLotusColor,
             self.lightSlateBlueColor,
             self.slateBlueColor,
             self.glacialBlueIceColor,
             self.silkBlueColor,
             self.blueIvyColor,
             self.blueKoiColor,
             self.columbiaBlueColor,
             self.babyBlueColor,
             self.lightSteelBlueColor,
             self.oceanBlueColor,
             self.blueRibbonColor,
             self.blueDressColor,
             self.dodgerBlueColor,
             self.cornflowerBlueColor,
             self.skyBlueColor,
             self.butterflyBlueColor,
             self.icebergColor,
             self.crystalBlueColor,
             self.deepSkyBlueColor,
             self.denimBlueColor,
             self.lightSkyBlueColor,
             self.daySkyBlueColor,
             self.jeansBlueColor,
             self.blueAngelColor,
             self.pastelBlueColor,
             self.seaBlueColor,
             self.powderBlueColor,
             self.coralBlueColor,
             self.lightBlueColor,
             self.robinEggBlueColor,
             self.paleBlueLilyColor,
             self.lightCyanColor,
             self.waterColor,
             self.aliceBlueColor,
             self.azureColor,
             self.lightSlateColor,
             self.lightAquamarineColor,
             self.electricBlueColor,
             self.aquamarineColor,
             self.aquaColor,
             self.tronBlueColor,
             self.blueZirconColor,
             self.blueLagoonColor,
             self.celesteColor,
             self.blueDiamondColor,
             self.tiffanyBlueColor,
             self.cyanOpaqueColor,
             self.blueHostaColor,
             self.northernLightsBlueColor,
             self.mediumTurquoiseColor,
             self.turquoiseColor,
             self.jellyfishColor,
             self.macawBlueGreenColor,
             self.lightSeaGreenColor,
             self.darkTurquoiseColor,
             self.seaTurtleGreenColor,
             self.mediumAquamarineColor,
             self.greenishBlueColor,
             self.grayishTurquoiseColor,
             self.beetleGreenColor,
             self.tealColor,
             self.seaGreenColor,
             self.camouflageGreenColor,
             self.sageGreenColor,
             self.hazelGreenColor,
             self.venomGreenColor,
             self.fernGreenColor,
             self.darkForrestGreenColor,
             self.mediumSeaGreenColor,
             self.mediumForestGreenColor,
             self.seaweedGreenColor,
             self.pineGreenColor,
             self.jungleGreenColor,
             self.shamrockGreenColor,
             self.mediumSpringGreenColor,
             self.forestGreenColor,
             self.greenOnionColor,
             self.springGreenColor,
             self.limeGreenColor,
             self.cloverGreenColor,
             self.greenSnakeColor,
             self.alienGreenColor,
             self.greenAppleColor,
             self.yellowGreenColor,
             self.kellyGreenColor,
             self.zombieGreenColor,
             self.frogGreenColor,
             self.greenPeasColor,
             self.dollarBillGreenColor,
             self.darkSeaGreenColor,
             self.iguanaGreenColor,
             self.avocadoGreenColor,
             self.pistachioGreenColor,
             self.saladGreenColor,
             self.hummingbirdGreenColor,
             self.nebulaGreenColor,
             self.stoplightGoGreenColor,
             self.algaeGreenColor,
             self.jadeGreenColor,
             self.greenColor,
             self.emeraldGreenColor,
             self.lawnGreenColor,
             self.chartreuseColor,
             self.dragonGreenColor,
             self.mintGreenColor,
             self.greenThumbColor,
             self.lightJadeColor,
             self.teaGreenColor,
             self.greenYellowColor,
             self.slimeGreenColor,
             self.goldenrodColor,
             self.harvestGoldColor,
             self.sunYellowColor,
             self.yellowColor,
             self.cornYellowColor,
             self.parchmentColor,
             self.creamColor,
             self.lemonChiffonColor,
             self.cornsilkColor,
             self.beigeColor,
             self.blondeColor,
             self.antiqueWhiteColor,
             self.champagneColor,
             self.blanchedAlmondColor,
             self.vanillaColor,
             self.tanBrownColor,
             self.peachColor,
             self.mustardColor,
             self.rubberDuckyYellowColor,
             self.brightGoldColor,
             self.goldenBrownColor,
             self.cheeseColor, //Macaroni
             self.saffronColor,
             self.beerColor,
             self.cantaloupeColor,
             self.beeYellowColor,
             self.brownSugarColor,
             self.burlyWoodColor,
             self.deepPeachColor,
             self.gingerBrownColor,
             self.schoolBusYellowColor,
             self.sandyBrownColor,
             self.fallLeafBrownColor,
             self.orangeGoldColor,
             self.sandColor,
             self.cookieBrownColor,
             self.caramelColor,
             self.brassColor,
             self.khakiColor,
             self.camelBrownColor,
             self.bronzeColor,
             self.tigerOrangeColor,
             self.cinnamonColor,
             self.bulletShellColor,
             self.darkGoldenrodColor,
             self.copperColor,
             self.woodColor,
             self.oakBrownColor,
             self.moccasinColor,
             self.armyBrownColor,
             self.sandstoneColor,
             self.mochaColor,
             self.taupeColor,
             self.coffeeColor,
             self.brownBearColor,
             self.redDirtColor,
             self.sepiaColor,
             self.orangeSalmonColor,
             self.rustColor,
             self.redFoxColor,
             self.chocolateColor,
             self.sedonaColor,
             self.papayaOrangeColor,
             self.halloweenOrangeColor,
             self.pumpkinOrangeColor,
             self.constructionConeOrangeColor,
             self.sunriseOrangeColor,
             self.mangoOrangeColor,
             self.darkOrangeColor,
             self.coralColor,
             self.basketBallOrangeColor,
             self.lightSalmonColor,
             self.tangerineColor,
             self.darkSalmonColor,
             self.lightCoralColor,
             self.beanRedColor,
             self.valentineRedColor,
             self.shockingOrangeColor,
             self.redColor,
             self.scarletColor,
             self.rubyRedColor,
             self.ferrariRedColor,
             self.fireEngineRedColor,
             self.lavaRedColor,
             self.loveRedColor,
             self.grapefruitColor,
             self.chestnutRedColor,
             self.cherryRedColor,
             self.mahoganyColor,
             self.chilliPepperColor,
             self.cranberryColor,
             self.redWineColor,
             self.burgundyColor,
             self.chestnutColor,
             self.bloodRedColor,
             self.siennaColor,
             self.sangriaColor,
             self.firebrickColor,
             self.maroonColor,
             self.plumPieColor,
             self.velvetMaroonColor,
             self.plumVelvetColor,
             self.rosyFinchColor,
             self.puceColor,
             self.dullPurpleColor,
             self.rosyBrownColor,
             self.khakiRoseColor,
             self.pinkBowColor,
             self.lipstickPinkColor,
             self.roseColor,
             self.desertSandColor,
             self.pigPinkColor,
             self.cottonCandyColor,
             self.pinkBubblegumColor,
             self.mistyRoseColor,
             self.pinkColor,
             self.lightPinkColor,
             self.flamingoPinkColor,
             self.pinkRoseColor,
             self.pinkDaisyColor,
             self.cadillacPinkColor,
             self.carnationPinkColor,
             self.blushRedColor,
             self.hotPinkColor,
             self.watermelonPinkColor,
             self.violetRedColor,
             self.deepPinkColor,
             self.pinkCupcakeColor,
             self.pinkLemonadeColor,
             self.neonPinkColor,
             self.magentaColor,
             self.dimorphothecaMagentaColor,
             self.brightNeonPinkColor,
             self.paleVioletRedColor,
             self.tulipPinkColor,
             self.mediumVioletRedColor,
             self.roguePinkColor,
             self.burntPinkColor,
             self.bashfulPinkColor,
             self.plumColor,
             self.violaPurpleColor,
             self.purpleIrisColor,
             self.plumPurpleColor,
             self.indigoColor,
             self.purpleMonsterColor,
             self.purpleHazeColor,
             self.eggplantColor,
             self.grapeColor,
             self.purpleJamColor,
             self.darkOrchidColor,
             self.purpleFlowerColor,
             self.mediumOrchidColor,
             self.purpleAmethystColor,
             self.darkVioletColor,
             self.violetColor,
             self.purpleSageBushColor,
             self.lovelyPurpleColor,
             self.purpleColor,
             self.aztechPurpleColor,
             self.mediumPurpleColor,
             self.jasminePurpleColor,
             self.purpleDaffodilColor,
             self.tyrianPurpleColor,
             self.crocusPurpleColor,
             self.purpleMimosaColor,
             self.heliotropePurpleColor,
             self.crimsonColor,
             self.purpleDragonColor,
             self.lilacColor,
             self.blushPinkColor,
             self.mauveColor,
             self.wisteriaPurpleColor,
             self.blossomPinkColor,
             self.thistleColor,
             self.periwinkleColor,
             self.lavenderPinocchioColor,
             self.lavenderBlueColor,
             self.pearlColor,
             self.seaShellColor,
             self.milkWhiteColor,
             self.whiteColor,

             ];
}

+ (NSArray *) colorNames
{
    return @[
             @"black",
             @"night",
             @"gunmetal",
             @"midnight",
             @"charcoal",
             @"darkSlateGrey",
             @"oil",
             @"blackCat",
             @"iridium",
             @"blackEel",
             @"blackCow",
             @"grayWolf",
             @"vampireGray",
             @"grayDolphin",
             @"carbonGray",
             @"ashGray",
             @"cloudyGray",
             @"smokeyGray",
             @"gray",
             @"granite",
             @"battleshipGray",
             @"grayCloud",
             @"grayGoose",
             @"platinum",
             @"metallicSilver",
             @"blueGray",
             @"lightSlateGray",
             @"slateGray",
             @"jetGray",
             @"mistBlue",
             @"marbleBlue",
             @"mediumSlateBlue",
             @"steelBlue",
             @"blueJay",
             @"darkSlateBlue",
             @"midnightBlue",
             @"navyBlue",
             @"blueWhale",
             @"lapisBlue",
             @"earthBlue",
             @"cobaltBlue",
             @"blueberryBlue",
             @"sapphireBlue",
             @"blueEyes",
             @"royalBlue",
             @"blueOrchid",
             @"blueLotus",
             @"lightSlateBlue",
             @"slateBlue",
             @"glacialBlueIce",
             @"silkBlue",
             @"blueIvy",
             @"blueKoi",
             @"columbiaBlue",
             @"babyBlue",
             @"lightSteelBlue",
             @"oceanBlue",
             @"blueRibbon",
             @"blueDress",
             @"dodgerBlue",
             @"cornflowerBlue",
             @"skyBlue",
             @"butterflyBlue",
             @"iceberg",
             @"crystalBlue",
             @"deepSkyBlue",
             @"denimBlue",
             @"lightSkyBlue",
             @"daySkyBlue",
             @"jeansBlue",
             @"blueAngel",
             @"pastelBlue",
             @"seaBlue",
             @"powderBlue",
             @"coralBlue",
             @"lightBlue",
             @"robinEggBlue",
             @"paleBlueLily",
             @"lightCyan",
             @"water",
             @"aliceBlue",
             @"azure",
             @"lightSlate",
             @"lightAquamarine",
             @"electricBlue",
             @"aquamarine",
             @"aqua",
             @"tronBlue",
             @"blueZircon",
             @"blueLagoon",
             @"celeste",
             @"blueDiamond",
             @"tiffanyBlue",
             @"cyanOpaque",
             @"blueHosta",
             @"northernLightsBlue",
             @"mediumTurquoise",
             @"turquoise",
             @"jellyfish",
             @"macawBlueGreen",
             @"lightSeaGreen",
             @"darkTurquoise",
             @"seaTurtleGreen",
             @"mediumAquamarine",
             @"greenishBlue",
             @"grayishTurquoise",
             @"beetleGreen",
             @"teal",
             @"seaGreen",
             @"camouflageGreen",
             @"sageGreen",
             @"hazelGreen",
             @"venomGreen",
             @"fernGreen",
             @"darkForrestGreen",
             @"mediumSeaGreen",
             @"mediumForestGreen",
             @"seaweedGreen",
             @"pineGreen",
             @"jungleGreen",
             @"shamrockGreen",
             @"mediumSpringGreen",
             @"forestGreen",
             @"greenOnion",
             @"springGreen",
             @"limeGreen",
             @"cloverGreen",
             @"greenSnake",
             @"alienGreen",
             @"greenApple",
             @"yellowGreen",
             @"kellyGreen",
             @"zombieGreen",
             @"frogGreen",
             @"greenPeas",
             @"dollarBillGreen",
             @"darkSeaGreen",
             @"iguanaGreen",
             @"avocadoGreen",
             @"pistachioGreen",
             @"saladGreen",
             @"hummingbirdGreen",
             @"nebulaGreen",
             @"stoplightGoGreen",
             @"algaeGreen",
             @"jadeGreen",
             @"green",
             @"emeraldGreen",
             @"lawnGreen",
             @"chartreuse",
             @"dragonGreen",
             @"mintGreen",
             @"greenThumb",
             @"lightJade",
             @"teaGreen",
             @"greenYellow",
             @"slimeGreen",
             @"goldenrod",
             @"harvestGold",
             @"sunYellow",
             @"yellow",
             @"cornYellow",
             @"parchment",
             @"cream",
             @"lemonChiffon",
             @"cornsilk",
             @"beige",
             @"blonde",
             @"antiqueWhite",
             @"champagne",
             @"blanchedAlmond",
             @"vanilla",
             @"tanBrown",
             @"peach",
             @"mustard",
             @"rubberDuckyYellow",
             @"brightGold",
             @"goldenBrown",
             @"cheese", //Macaroni
             @"saffron",
             @"beer",
             @"cantaloupe",
             @"beeYellow",
             @"brownSugar",
             @"burlyWood",
             @"deepPeach",
             @"gingerBrown",
             @"schoolBusYellow",
             @"sandyBrown",
             @"fallLeafBrown",
             @"orangeGold",
             @"sand",
             @"cookieBrown",
             @"caramel",
             @"brass",
             @"khaki",
             @"camelBrown",
             @"bronze",
             @"tigerOrange",
             @"cinnamon",
             @"bulletShell",
             @"darkGoldenrod",
             @"copper",
             @"wood",
             @"oakBrown",
             @"moccasin",
             @"armyBrown",
             @"sandstone",
             @"mocha",
             @"taupe",
             @"coffee",
             @"brownBear",
             @"redDirt",
             @"sepia",
             @"orangeSalmon",
             @"rust",
             @"redFox",
             @"chocolate",
             @"sedona",
             @"papayaOrange",
             @"halloweenOrange",
             @"pumpkinOrange",
             @"constructionConeOrange",
             @"sunriseOrange",
             @"mangoOrange",
             @"darkOrange",
             @"coral",
             @"basketBallOrange",
             @"lightSalmon",
             @"tangerine",
             @"darkSalmon",
             @"lightCoral",
             @"beanRed",
             @"valentineRed",
             @"shockingOrange",
             @"red",
             @"scarlet",
             @"rubyRed",
             @"ferrariRed",
             @"fireEngineRed",
             @"lavaRed",
             @"loveRed",
             @"grapefruit",
             @"chestnutRed",
             @"cherryRed",
             @"mahogany",
             @"chilliPepper",
             @"cranberry",
             @"redWine",
             @"burgundy",
             @"chestnut",
             @"bloodRed",
             @"sienna",
             @"sangria",
             @"firebrick",
             @"maroon",
             @"plumPie",
             @"velvetMaroon",
             @"plumVelvet",
             @"rosyFinch",
             @"puce",
             @"dullPurple",
             @"rosyBrown",
             @"khakiRose",
             @"pinkBow",
             @"lipstickPink",
             @"rose",
             @"desertSand",
             @"pigPink",
             @"cottonCandy",
             @"pinkBubblegum",
             @"mistyRose",
             @"pink",
             @"lightPink",
             @"flamingoPink",
             @"pinkRose",
             @"pinkDaisy",
             @"cadillacPink",
             @"carnationPink",
             @"blushRed",
             @"hotPink",
             @"watermelonPink",
             @"violetRed",
             @"deepPink",
             @"pinkCupcake",
             @"pinkLemonade",
             @"neonPink",
             @"magenta",
             @"dimorphothecaMagenta",
             @"brightNeonPink",
             @"paleVioletRed",
             @"tulipPink",
             @"mediumVioletRed",
             @"roguePink",
             @"burntPink",
             @"bashfulPink",
             @"plum",
             @"violaPurple",
             @"purpleIris",
             @"plumPurple",
             @"indigo",
             @"purpleMonster",
             @"purpleHaze",
             @"eggplant",
             @"grape",
             @"purpleJam",
             @"darkOrchid",
             @"purpleFlower",
             @"mediumOrchid",
             @"purpleAmethyst",
             @"darkViolet",
             @"violet",
             @"purpleSageBush",
             @"lovelyPurple",
             @"purple",
             @"aztechPurple",
             @"mediumPurple",
             @"jasminePurple",
             @"purpleDaffodil",
             @"tyrianPurple",
             @"crocusPurple",
             @"purpleMimosa",
             @"heliotropePurple",
             @"crimson",
             @"purpleDragon",
             @"lilac",
             @"blushPink",
             @"mauve",
             @"wisteriaPurple",
             @"blossomPink",
             @"thistle",
             @"periwinkle",
             @"lavenderPinocchio",
             @"lavenderBlue",
             @"pearl",
             @"seaShell",
             @"milkWhite",
             @"white",

             ];
}

+ (NSString *) palleteName
{
    return NSLocalizedString(@"HTML Colors", nil);
}


@end
