// clang-format off
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@class UIColor;
/**
 * BPKColor is the entry point for the Backpack color palette. It expose the whole palette
 * as static methods.
*/
@interface BPKColor : NSObject

///-----------------------
/// @name Colors
///-----------------------

/**
 * The `skyBlueShade03` color from the Backpack palette - rgb(5, 32, 60).
 *
 * <div style="width: 100px; height: 100px; background: #05203cff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueShade03 __deprecated;

/**
 * The `primaryGradientLight` color from the Backpack palette - rgb(0, 98, 227).
 *
 * <div style="width: 100px; height: 100px; background: #0062e3ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryGradientLight __deprecated;

/**
 * The `erfoud` color from the Backpack palette - rgb(254, 235, 135).
 *
 * <div style="width: 100px; height: 100px; background: #feeb87ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * erfoud __deprecated;

/**
 * The `valensole` color from the Backpack palette - rgb(224, 227, 229).
 *
 * <div style="width: 100px; height: 100px; background: #e0e3e5ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * valensole __deprecated;

/**
 * The `monteverde` color from the Backpack palette - rgb(12, 131, 138).
 *
 * <div style="width: 100px; height: 100px; background: #0c838aff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * monteverde __deprecated;

/**
 * The `skyGrayTint01` color from the Backpack palette - rgb(84, 88, 96).
 *
 * <div style="width: 100px; height: 100px; background: #545860ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint01 __deprecated;

/**
 * The `black` color from the Backpack palette - rgb(1, 9, 19).
 *
 * <div style="width: 100px; height: 100px; background: #010913ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * black;

/**
 * The `skyGrayTint02` color from the Backpack palette - rgb(84, 88, 96).
 *
 * <div style="width: 100px; height: 100px; background: #545860ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint02 __deprecated;

/**
 * The `sagano` color from the Backpack palette - rgb(212, 255, 242).
 *
 * <div style="width: 100px; height: 100px; background: #d4fff2ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * sagano __deprecated;

/**
 * The `skyGrayTint03` color from the Backpack palette - rgb(84, 88, 96).
 *
 * <div style="width: 100px; height: 100px; background: #545860ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint03 __deprecated;

/**
 * The `skyGrayTint04` color from the Backpack palette - rgb(194, 201, 205).
 *
 * <div style="width: 100px; height: 100px; background: #c2c9cdff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint04 __deprecated;

/**
 * The `harbour` color from the Backpack palette - rgb(255, 233, 249).
 *
 * <div style="width: 100px; height: 100px; background: #ffe9f9ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * harbour __deprecated;

/**
 * The `skyGrayTint05` color from the Backpack palette - rgb(194, 201, 205).
 *
 * <div style="width: 100px; height: 100px; background: #c2c9cdff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint05 __deprecated;

/**
 * The `skyGrayTint06` color from the Backpack palette - rgb(224, 227, 229).
 *
 * <div style="width: 100px; height: 100px; background: #e0e3e5ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint06 __deprecated;

/**
 * The `blackTint01` color from the Backpack palette - rgb(19, 29, 43).
 *
 * <div style="width: 100px; height: 100px; background: #131d2bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint01 __deprecated;

/**
 * The `skyGrayTint07` color from the Backpack palette - rgb(239, 241, 242).
 *
 * <div style="width: 100px; height: 100px; background: #eff1f2ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint07 __deprecated;

/**
 * The `blackTint02` color from the Backpack palette - rgb(19, 29, 43).
 *
 * <div style="width: 100px; height: 100px; background: #131d2bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint02 __deprecated;

/**
 * The `abisko` color from the Backpack palette - rgb(5, 32, 60).
 *
 * <div style="width: 100px; height: 100px; background: #05203cff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * abisko __deprecated;

/**
 * The `blackTint03` color from the Backpack palette - rgb(36, 51, 70).
 *
 * <div style="width: 100px; height: 100px; background: #243346ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint03 __deprecated;

/**
 * The `blackTint04` color from the Backpack palette - rgb(68, 80, 95).
 *
 * <div style="width: 100px; height: 100px; background: #44505fff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint04 __deprecated;

/**
 * The `white` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * white;

/**
 * The `blackTint05` color from the Backpack palette - rgb(68, 80, 95).
 *
 * <div style="width: 100px; height: 100px; background: #44505fff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint05 __deprecated;

/**
 * The `blackTint06` color from the Backpack palette - rgb(189, 196, 203).
 *
 * <div style="width: 100px; height: 100px; background: #bdc4cbff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint06 __deprecated;

/**
 * The `panjin` color from the Backpack palette - rgb(231, 8, 102).
 *
 * <div style="width: 100px; height: 100px; background: #e70866ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * panjin __deprecated;

/**
 * The `kolkata` color from the Backpack palette - rgb(245, 93, 66).
 *
 * <div style="width: 100px; height: 100px; background: #f55d42ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * kolkata __deprecated;

/**
 * The `glencoe` color from the Backpack palette - rgb(98, 241, 198).
 *
 * <div style="width: 100px; height: 100px; background: #62f1c6ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * glencoe __deprecated;

/**
 * The `tochigi` color from the Backpack palette - rgb(239, 241, 242).
 *
 * <div style="width: 100px; height: 100px; background: #eff1f2ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * tochigi __deprecated;

/**
 * The `petra` color from the Backpack palette - rgb(254, 235, 135).
 *
 * <div style="width: 100px; height: 100px; background: #feeb87ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * petra __deprecated;

/**
 * The `skyBlue` color from the Backpack palette - rgb(0, 98, 227).
 *
 * <div style="width: 100px; height: 100px; background: #0062e3ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlue;

/**
 * The `bagan` color from the Backpack palette - rgb(255, 247, 207).
 *
 * <div style="width: 100px; height: 100px; background: #fff7cfff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bagan __deprecated;

/**
 * The `hillier` color from the Backpack palette - rgb(255, 100, 156).
 *
 * <div style="width: 100px; height: 100px; background: #ff649cff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * hillier __deprecated;

/**
 * The `skyBlueTint01` color from the Backpack palette - rgb(132, 233, 255).
 *
 * <div style="width: 100px; height: 100px; background: #84e9ffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueTint01 __deprecated;

/**
 * The `skyBlueTint02` color from the Backpack palette - rgb(224, 227, 229).
 *
 * <div style="width: 100px; height: 100px; background: #e0e3e5ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueTint02 __deprecated;

/**
 * The `bunol` color from the Backpack palette - rgb(245, 93, 66).
 *
 * <div style="width: 100px; height: 100px; background: #f55d42ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bunol __deprecated;

/**
 * The `skyBlueTint03` color from the Backpack palette - rgb(224, 227, 229).
 *
 * <div style="width: 100px; height: 100px; background: #e0e3e5ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueTint03 __deprecated;

/**
 * The `skyGray` color from the Backpack palette - rgb(22, 22, 22).
 *
 * <div style="width: 100px; height: 100px; background: #161616ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGray __deprecated;

/**
 * The `nara` color from the Backpack palette - rgb(255, 247, 207).
 *
 * <div style="width: 100px; height: 100px; background: #fff7cfff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * nara __deprecated;

/**
 * The `skyBlueShade01` color from the Backpack palette - rgb(0, 98, 227).
 *
 * <div style="width: 100px; height: 100px; background: #0062e3ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueShade01 __deprecated;

/**
 * The `skyBlueShade02` color from the Backpack palette - rgb(5, 32, 60).
 *
 * <div style="width: 100px; height: 100px; background: #05203cff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueShade02 __deprecated;

/**
 * The `textPrimaryDarkColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textPrimaryDarkColor __deprecated;

/**
 * The `textQuaternaryDarkColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffff33; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textQuaternaryDarkColor __deprecated;

/**
 * The `textQuaternaryLightColor` color from the Backpack palette - rgb(0, 0, 0).
 *
 * <div style="width: 100px; height: 100px; background: #00000033; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textQuaternaryLightColor __deprecated;

/**
 * The `textPrimaryLightColor` color from the Backpack palette - rgb(22, 22, 22).
 *
 * <div style="width: 100px; height: 100px; background: #161616ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textPrimaryLightColor __deprecated;

/**
 * The `textTertiaryDarkColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffff33; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textTertiaryDarkColor __deprecated;

/**
 * The `textSecondaryDarkColor` color from the Backpack palette - rgb(189, 196, 203).
 *
 * <div style="width: 100px; height: 100px; background: #bdc4cbff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textSecondaryDarkColor __deprecated;

/**
 * The `textSecondaryLightColor` color from the Backpack palette - rgb(84, 88, 96).
 *
 * <div style="width: 100px; height: 100px; background: #545860ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textSecondaryLightColor __deprecated;

/**
 * The `textTertiaryLightColor` color from the Backpack palette - rgb(0, 0, 0).
 *
 * <div style="width: 100px; height: 100px; background: #00000033; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textTertiaryLightColor __deprecated;

/**
 * The `backgroundElevation03DarkColor` color from the Backpack palette - rgb(36, 51, 70).
 *
 * <div style="width: 100px; height: 100px; background: #243346ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation03DarkColor __deprecated;

/**
 * The `backgroundElevation02DarkColor` color from the Backpack palette - rgb(36, 51, 70).
 *
 * <div style="width: 100px; height: 100px; background: #243346ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation02DarkColor __deprecated;

/**
 * The `lineDarkColor` color from the Backpack palette - rgb(68, 80, 95).
 *
 * <div style="width: 100px; height: 100px; background: #44505fff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * lineDarkColor __deprecated;

/**
 * The `backgroundElevation01DarkColor` color from the Backpack palette - rgb(19, 29, 43).
 *
 * <div style="width: 100px; height: 100px; background: #131d2bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation01DarkColor __deprecated;

/**
 * The `backgroundAlternativeSecondaryDarkColor` color from the Backpack palette - rgb(1, 9, 19).
 *
 * <div style="width: 100px; height: 100px; background: #010913ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeSecondaryDarkColor __deprecated;

/**
 * The `backgroundLightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundLightColor __deprecated;

/**
 * The `backgroundDarkColor` color from the Backpack palette - rgb(1, 9, 19).
 *
 * <div style="width: 100px; height: 100px; background: #010913ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundDarkColor __deprecated;

/**
 * The `backgroundAlternativeSecondaryLightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeSecondaryLightColor __deprecated;

/**
 * The `systemGreen` color from the Backpack palette - rgb(12, 131, 138).
 *
 * <div style="width: 100px; height: 100px; background: #0c838aff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * systemGreen __deprecated;

/**
 * The `backgroundElevation01LightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation01LightColor __deprecated;

/**
 * The `lineLightColor` color from the Backpack palette - rgb(194, 201, 205).
 *
 * <div style="width: 100px; height: 100px; background: #c2c9cdff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * lineLightColor __deprecated;

/**
 * The `backgroundElevation02LightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation02LightColor __deprecated;

/**
 * The `backgroundElevation03LightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation03LightColor __deprecated;

/**
 * The `backgroundTertiaryDarkColor` color from the Backpack palette - rgb(1, 9, 19).
 *
 * <div style="width: 100px; height: 100px; background: #010913ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundTertiaryDarkColor __deprecated;

/**
 * The `backgroundSecondaryDarkColor` color from the Backpack palette - rgb(19, 29, 43).
 *
 * <div style="width: 100px; height: 100px; background: #131d2bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundSecondaryDarkColor __deprecated;

/**
 * The `backgroundAlternativeLightColor` color from the Backpack palette - rgb(239, 241, 242).
 *
 * <div style="width: 100px; height: 100px; background: #eff1f2ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeLightColor __deprecated;

/**
 * The `primaryDarkColor` color from the Backpack palette - rgb(132, 233, 255).
 *
 * <div style="width: 100px; height: 100px; background: #84e9ffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryDarkColor __deprecated;

/**
 * The `systemRed` color from the Backpack palette - rgb(231, 8, 102).
 *
 * <div style="width: 100px; height: 100px; background: #e70866ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * systemRed __deprecated;

/**
 * The `backgroundAlternativeDarkColor` color from the Backpack palette - rgb(19, 29, 43).
 *
 * <div style="width: 100px; height: 100px; background: #131d2bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeDarkColor __deprecated;

/**
 * The `primaryLightColor` color from the Backpack palette - rgb(0, 98, 227).
 *
 * <div style="width: 100px; height: 100px; background: #0062e3ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryLightColor __deprecated;

/**
 * The `backgroundTertiaryLightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundTertiaryLightColor __deprecated;

/**
 * The `backgroundSecondaryLightColor` color from the Backpack palette - rgb(239, 241, 242).
 *
 * <div style="width: 100px; height: 100px; background: #eff1f2ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundSecondaryLightColor __deprecated;

/**
 * The `shadowSmColor` color from the Backpack palette - rgb(22, 22, 22).
 *
 * <div style="width: 100px; height: 100px; background: #161616ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * shadowSmColor;

/**
 * The `shadowLgColor` color from the Backpack palette - rgb(22, 22, 22).
 *
 * <div style="width: 100px; height: 100px; background: #161616ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * shadowLgColor;

/**
 * The `touchableOverlayColor` color from the Backpack palette - rgb(22, 22, 22).
 *
 * <div style="width: 100px; height: 100px; background: #161616ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * touchableOverlayColor;

/**
 * The `clear` color from the Backpack palette.
*/
@property(nonatomic, class, readonly) UIColor * clear;

///-----------------------
/// @name Dynamic colors
///-----------------------

/**
 * The `canvasColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * canvasColor;

/**
 * The `canvasContrastColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #eff1f2ff; background: linear-gradient(0.375turn, #eff1f2ff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * canvasContrastColor;

/**
 * The `coreEcoColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0fa1a9ff; background: linear-gradient(0.375turn, #0fa1a9ff 49%, #0fa1a9ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * coreEcoColor;

/**
 * The `coreAccentColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0062e3ff; background: linear-gradient(0.375turn, #0062e3ff 49%, #84e9ffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * coreAccentColor;

/**
 * The `corePrimaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #05203cff; background: linear-gradient(0.375turn, #05203cff 49%, #054184ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * corePrimaryColor;

/**
 * The `statusSuccessSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0c838aff; background: linear-gradient(0.375turn, #0c838aff 49%, #62f1c6ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusSuccessSpotColor;

/**
 * The `statusSuccessFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #d4fff2ff; background: linear-gradient(0.375turn, #d4fff2ff 49%, #b1ffe7ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusSuccessFillColor;

/**
 * The `statusDangerSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #e70866ff; background: linear-gradient(0.375turn, #e70866ff 49%, #ff649cff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusDangerSpotColor;

/**
 * The `statusWarningSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f55d42ff; background: linear-gradient(0.375turn, #f55d42ff 49%, #feeb87ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusWarningSpotColor;

/**
 * The `statusDangerFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffe9f9ff; background: linear-gradient(0.375turn, #ffe9f9ff 49%, #ffcaddff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusDangerFillColor;

/**
 * The `statusWarningFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #fff7cfff; background: linear-gradient(0.375turn, #fff7cfff 49%, #fbf1bbff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusWarningFillColor;

/**
 * The `surfaceContrastColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #05203cff; background: linear-gradient(0.375turn, #05203cff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * surfaceContrastColor;

/**
 * The `surfaceDefaultColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #131d2bff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * surfaceDefaultColor;

/**
 * The `surfaceElevatedColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #243346ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * surfaceElevatedColor;

/**
 * The `surfaceHighlightColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #e0e3e5ff; background: linear-gradient(0.375turn, #e0e3e5ff 49%, #243346ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * surfaceHighlightColor;

/**
 * The `textOnDarkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #ffffffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textOnDarkColor;

/**
 * The `textOnLightColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #161616ff; background: linear-gradient(0.375turn, #161616ff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textOnLightColor;

/**
 * The `textDisabledOnDarkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffff80; background: linear-gradient(0.375turn, #ffffff80 49%, #ffffff80 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textDisabledOnDarkColor;

/**
 * The `textLinkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0062e3ff; background: linear-gradient(0.375turn, #0062e3ff 49%, #84e9ffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textLinkColor;

/**
 * The `textDisabledColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #00000033; background: linear-gradient(0.375turn, #00000033 49%, #ffffff33 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textDisabledColor;

/**
 * The `textPrimaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #161616ff; background: linear-gradient(0.375turn, #161616ff 49%, #ffffffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textPrimaryColor;

/**
 * The `textQuaternaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #00000033; background: linear-gradient(0.375turn, #00000033 49%, #ffffff33 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textQuaternaryColor __deprecated;

/**
 * The `textErrorColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #e70866ff; background: linear-gradient(0.375turn, #e70866ff 49%, #ff649cff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textErrorColor;

/**
 * The `textTertiaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #00000033; background: linear-gradient(0.375turn, #00000033 49%, #ffffff33 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textTertiaryColor __deprecated;

/**
 * The `textSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #545860ff; background: linear-gradient(0.375turn, #545860ff 49%, #bdc4cbff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textSecondaryColor;

/**
 * The `textPrimaryInverseColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textPrimaryInverseColor;

/**
 * The `scrimColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #000000b3; background: linear-gradient(0.375turn, #000000b3 49%, #000000b3 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * scrimColor;

/**
 * The `backgroundElevation03Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #243346ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation03Color __deprecated;

/**
 * The `backgroundElevation02Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #243346ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation02Color __deprecated;

/**
 * The `lineOnDarkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffff80; background: linear-gradient(0.375turn, #ffffff80 49%, #44505fff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * lineOnDarkColor;

/**
 * The `lineColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #c2c9cdff; background: linear-gradient(0.375turn, #c2c9cdff 49%, #44505fff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * lineColor;

/**
 * The `backgroundElevation01Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #131d2bff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation01Color __deprecated;

/**
 * The `backgroundAlternativeSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeSecondaryColor __deprecated;

/**
 * The `backgroundColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundColor __deprecated;

/**
 * The `backgroundTertiaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundTertiaryColor __deprecated;

/**
 * The `backgroundSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #eff1f2ff; background: linear-gradient(0.375turn, #eff1f2ff 49%, #131d2bff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundSecondaryColor __deprecated;

/**
 * The `backgroundAlternativeColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #eff1f2ff; background: linear-gradient(0.375turn, #eff1f2ff 49%, #131d2bff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeColor __deprecated;

/**
 * The `primaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0062e3ff; background: linear-gradient(0.375turn, #0062e3ff 49%, #84e9ffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryColor __deprecated;


/**
 * Combines two `UIColor` values with a specified weighting.
 *
 * @param firstColor The color you wish to modify.
 * @param secondColor The color to blend with the first color.
 * @param weight The relative weighting of the first color. Close to `1.0f` gives more weight to `firstColor`. Close to `0.0f` gives more weight to `secondColor`.
 */
+ (UIColor *)blend:(UIColor*)firstColor with:(UIColor*)secondColor weight:(double)weight;

/**
 * Generates a dynamic color given a light and dark variant.
 *
 * @param lightVariant The color used in light mode, or on systems that don't support dark-mode.
 * @param darkVariant The color used in dark mode.
 */
+ (UIColor *)dynamicColorWithLightVariant:(UIColor *)lightVariant darkVariant:(UIColor *)darkVariant;

@end
NS_ASSUME_NONNULL_END
// clang-format on
