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
 * The `backgroundAlternativeDarkColor` color from the Backpack palette - rgb(0, 0, 0).
 *
 * <div style="width: 100px; height: 100px; background: #000000ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeDarkColor __deprecated;

/**
 * The `backgroundAlternativeLightColor` color from the Backpack palette - rgb(241, 242, 248).
 *
 * <div style="width: 100px; height: 100px; background: #f1f2f8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeLightColor __deprecated;

/**
 * The `backgroundAlternativeSecondaryDarkColor` color from the Backpack palette - rgb(29, 27, 32).
 *
 * <div style="width: 100px; height: 100px; background: #1d1b20ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeSecondaryDarkColor __deprecated;

/**
 * The `backgroundAlternativeSecondaryLightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeSecondaryLightColor __deprecated;

/**
 * The `backgroundDarkColor` color from the Backpack palette - rgb(0, 0, 0).
 *
 * <div style="width: 100px; height: 100px; background: #000000ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundDarkColor __deprecated;

/**
 * The `backgroundElevation01DarkColor` color from the Backpack palette - rgb(29, 27, 32).
 *
 * <div style="width: 100px; height: 100px; background: #1d1b20ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation01DarkColor __deprecated;

/**
 * The `backgroundElevation01LightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation01LightColor __deprecated;

/**
 * The `backgroundElevation02DarkColor` color from the Backpack palette - rgb(44, 44, 46).
 *
 * <div style="width: 100px; height: 100px; background: #2c2c2eff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation02DarkColor __deprecated;

/**
 * The `backgroundElevation02LightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation02LightColor __deprecated;

/**
 * The `backgroundElevation03DarkColor` color from the Backpack palette - rgb(58, 58, 60).
 *
 * <div style="width: 100px; height: 100px; background: #3a3a3cff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation03DarkColor __deprecated;

/**
 * The `backgroundElevation03LightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation03LightColor __deprecated;

/**
 * The `backgroundLightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundLightColor __deprecated;

/**
 * The `backgroundSecondaryDarkColor` color from the Backpack palette - rgb(29, 27, 32).
 *
 * <div style="width: 100px; height: 100px; background: #1d1b20ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundSecondaryDarkColor __deprecated;

/**
 * The `backgroundSecondaryLightColor` color from the Backpack palette - rgb(241, 242, 248).
 *
 * <div style="width: 100px; height: 100px; background: #f1f2f8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundSecondaryLightColor __deprecated;

/**
 * The `backgroundTertiaryDarkColor` color from the Backpack palette - rgb(44, 44, 46).
 *
 * <div style="width: 100px; height: 100px; background: #2c2c2eff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundTertiaryDarkColor __deprecated;

/**
 * The `backgroundTertiaryLightColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundTertiaryLightColor __deprecated;

/**
 * The `abisko` color from the Backpack palette - rgb(90, 72, 155).
 *
 * <div style="width: 100px; height: 100px; background: #5a489bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * abisko __deprecated;

/**
 * The `bagan` color from the Backpack palette - rgb(255, 235, 208).
 *
 * <div style="width: 100px; height: 100px; background: #ffebd0ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bagan __deprecated;

/**
 * The `black` color from the Backpack palette - rgb(0, 0, 0).
 *
 * <div style="width: 100px; height: 100px; background: #000000ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * black;

/**
 * The `blackTint01` color from the Backpack palette - rgb(29, 27, 32).
 *
 * <div style="width: 100px; height: 100px; background: #1d1b20ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint01 __deprecated;

/**
 * The `blackTint02` color from the Backpack palette - rgb(44, 44, 46).
 *
 * <div style="width: 100px; height: 100px; background: #2c2c2eff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint02 __deprecated;

/**
 * The `blackTint03` color from the Backpack palette - rgb(58, 58, 60).
 *
 * <div style="width: 100px; height: 100px; background: #3a3a3cff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint03 __deprecated;

/**
 * The `blackTint04` color from the Backpack palette - rgb(72, 72, 74).
 *
 * <div style="width: 100px; height: 100px; background: #48484aff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint04 __deprecated;

/**
 * The `blackTint05` color from the Backpack palette - rgb(99, 99, 102).
 *
 * <div style="width: 100px; height: 100px; background: #636366ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint05 __deprecated;

/**
 * The `blackTint06` color from the Backpack palette - rgb(142, 142, 147).
 *
 * <div style="width: 100px; height: 100px; background: #8e8e93ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blackTint06 __deprecated;

/**
 * The `bunol` color from the Backpack palette - rgb(255, 123, 89).
 *
 * <div style="width: 100px; height: 100px; background: #ff7b59ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bunol __deprecated;

/**
 * The `erfoud` color from the Backpack palette - rgb(255, 181, 77).
 *
 * <div style="width: 100px; height: 100px; background: #ffb54dff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * erfoud __deprecated;

/**
 * The `glencoe` color from the Backpack palette - rgb(115, 206, 198).
 *
 * <div style="width: 100px; height: 100px; background: #73cec6ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * glencoe __deprecated;

/**
 * The `harbour` color from the Backpack palette - rgb(246, 221, 225).
 *
 * <div style="width: 100px; height: 100px; background: #f6dde1ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * harbour __deprecated;

/**
 * The `hillier` color from the Backpack palette - rgb(225, 139, 150).
 *
 * <div style="width: 100px; height: 100px; background: #e18b96ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * hillier __deprecated;

/**
 * The `kolkata` color from the Backpack palette - rgb(255, 148, 0).
 *
 * <div style="width: 100px; height: 100px; background: #ff9400ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * kolkata __deprecated;

/**
 * The `monteverde` color from the Backpack palette - rgb(0, 166, 152).
 *
 * <div style="width: 100px; height: 100px; background: #00a698ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * monteverde __deprecated;

/**
 * The `nara` color from the Backpack palette - rgb(255, 231, 224).
 *
 * <div style="width: 100px; height: 100px; background: #ffe7e0ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * nara __deprecated;

/**
 * The `panjin` color from the Backpack palette - rgb(209, 67, 91).
 *
 * <div style="width: 100px; height: 100px; background: #d1435bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * panjin __deprecated;

/**
 * The `petra` color from the Backpack palette - rgb(255, 171, 149).
 *
 * <div style="width: 100px; height: 100px; background: #ffab95ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * petra __deprecated;

/**
 * The `primaryGradientLight` color from the Backpack palette - rgb(7, 112, 227).
 *
 * <div style="width: 100px; height: 100px; background: #0770e3ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryGradientLight __deprecated;

/**
 * The `sagano` color from the Backpack palette - rgb(208, 238, 236).
 *
 * <div style="width: 100px; height: 100px; background: #d0eeecff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * sagano __deprecated;

/**
 * The `skyBlue` color from the Backpack palette - rgb(7, 112, 227).
 *
 * <div style="width: 100px; height: 100px; background: #0770e3ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlue;

/**
 * The `skyBlueShade01` color from the Backpack palette - rgb(8, 78, 178).
 *
 * <div style="width: 100px; height: 100px; background: #084eb2ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueShade01 __deprecated;

/**
 * The `skyBlueShade02` color from the Backpack palette - rgb(4, 39, 89).
 *
 * <div style="width: 100px; height: 100px; background: #042759ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueShade02 __deprecated;

/**
 * The `skyBlueShade03` color from the Backpack palette - rgb(2, 18, 44).
 *
 * <div style="width: 100px; height: 100px; background: #02122cff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueShade03 __deprecated;

/**
 * The `skyBlueTint01` color from the Backpack palette - rgb(109, 159, 235).
 *
 * <div style="width: 100px; height: 100px; background: #6d9febff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueTint01 __deprecated;

/**
 * The `skyBlueTint02` color from the Backpack palette - rgb(157, 192, 242).
 *
 * <div style="width: 100px; height: 100px; background: #9dc0f2ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueTint02 __deprecated;

/**
 * The `skyBlueTint03` color from the Backpack palette - rgb(205, 223, 248).
 *
 * <div style="width: 100px; height: 100px; background: #cddff8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueTint03 __deprecated;

/**
 * The `skyGray` color from the Backpack palette - rgb(17, 18, 54).
 *
 * <div style="width: 100px; height: 100px; background: #111236ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGray __deprecated;

/**
 * The `skyGrayTint01` color from the Backpack palette - rgb(68, 69, 96).
 *
 * <div style="width: 100px; height: 100px; background: #444560ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint01 __deprecated;

/**
 * The `skyGrayTint02` color from the Backpack palette - rgb(104, 105, 127).
 *
 * <div style="width: 100px; height: 100px; background: #68697fff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint02 __deprecated;

/**
 * The `skyGrayTint03` color from the Backpack palette - rgb(143, 144, 160).
 *
 * <div style="width: 100px; height: 100px; background: #8f90a0ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint03 __deprecated;

/**
 * The `skyGrayTint04` color from the Backpack palette - rgb(178, 178, 191).
 *
 * <div style="width: 100px; height: 100px; background: #b2b2bfff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint04 __deprecated;

/**
 * The `skyGrayTint05` color from the Backpack palette - rgb(205, 205, 215).
 *
 * <div style="width: 100px; height: 100px; background: #cdcdd7ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint05 __deprecated;

/**
 * The `skyGrayTint06` color from the Backpack palette - rgb(221, 221, 229).
 *
 * <div style="width: 100px; height: 100px; background: #dddde5ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint06 __deprecated;

/**
 * The `skyGrayTint07` color from the Backpack palette - rgb(241, 242, 248).
 *
 * <div style="width: 100px; height: 100px; background: #f1f2f8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint07 __deprecated;

/**
 * The `systemGreen` color from the Backpack palette - rgb(0, 166, 152).
 *
 * <div style="width: 100px; height: 100px; background: #00a698ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * systemGreen __deprecated;

/**
 * The `systemRed` color from the Backpack palette - rgb(209, 67, 91).
 *
 * <div style="width: 100px; height: 100px; background: #d1435bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * systemRed __deprecated;

/**
 * The `tochigi` color from the Backpack palette - rgb(225, 221, 236).
 *
 * <div style="width: 100px; height: 100px; background: #e1ddecff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * tochigi __deprecated;

/**
 * The `valensole` color from the Backpack palette - rgb(165, 155, 200).
 *
 * <div style="width: 100px; height: 100px; background: #a59bc8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * valensole __deprecated;

/**
 * The `white` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * white;

/**
 * The `lineDarkColor` color from the Backpack palette - rgb(72, 72, 74).
 *
 * <div style="width: 100px; height: 100px; background: #48484aff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * lineDarkColor __deprecated;

/**
 * The `lineLightColor` color from the Backpack palette - rgb(205, 205, 215).
 *
 * <div style="width: 100px; height: 100px; background: #cdcdd7ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * lineLightColor __deprecated;

/**
 * The `primaryDarkColor` color from the Backpack palette - rgb(109, 159, 235).
 *
 * <div style="width: 100px; height: 100px; background: #6d9febff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryDarkColor __deprecated;

/**
 * The `primaryLightColor` color from the Backpack palette - rgb(7, 112, 227).
 *
 * <div style="width: 100px; height: 100px; background: #0770e3ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryLightColor __deprecated;

/**
 * The `shadowLgColor` color from the Backpack palette - rgb(17, 18, 54).
 *
 * <div style="width: 100px; height: 100px; background: #111236ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * shadowLgColor;

/**
 * The `shadowSmColor` color from the Backpack palette - rgb(17, 18, 54).
 *
 * <div style="width: 100px; height: 100px; background: #111236ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * shadowSmColor;

/**
 * The `textPrimaryDarkColor` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textPrimaryDarkColor __deprecated;

/**
 * The `textPrimaryLightColor` color from the Backpack palette - rgb(17, 18, 54).
 *
 * <div style="width: 100px; height: 100px; background: #111236ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textPrimaryLightColor __deprecated;

/**
 * The `textQuaternaryDarkColor` color from the Backpack palette - rgb(142, 142, 147).
 *
 * <div style="width: 100px; height: 100px; background: #8e8e93ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textQuaternaryDarkColor __deprecated;

/**
 * The `textQuaternaryLightColor` color from the Backpack palette - rgb(143, 144, 160).
 *
 * <div style="width: 100px; height: 100px; background: #8f90a0ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textQuaternaryLightColor __deprecated;

/**
 * The `textSecondaryDarkColor` color from the Backpack palette - rgb(178, 178, 191).
 *
 * <div style="width: 100px; height: 100px; background: #b2b2bfff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textSecondaryDarkColor __deprecated;

/**
 * The `textSecondaryLightColor` color from the Backpack palette - rgb(104, 105, 127).
 *
 * <div style="width: 100px; height: 100px; background: #68697fff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textSecondaryLightColor __deprecated;

/**
 * The `textTertiaryDarkColor` color from the Backpack palette - rgb(142, 142, 147).
 *
 * <div style="width: 100px; height: 100px; background: #8e8e93ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textTertiaryDarkColor __deprecated;

/**
 * The `textTertiaryLightColor` color from the Backpack palette - rgb(143, 144, 160).
 *
 * <div style="width: 100px; height: 100px; background: #8f90a0ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textTertiaryLightColor __deprecated;

/**
 * The `touchableOverlayColor` color from the Backpack palette - rgb(17, 18, 54).
 *
 * <div style="width: 100px; height: 100px; background: #111236ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
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
 * The `backgroundAlternativeColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f1f2f8ff; background: linear-gradient(0.375turn, #f1f2f8ff 49%, #000000ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeColor __deprecated;

/**
 * The `backgroundAlternativeSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeSecondaryColor __deprecated;

/**
 * The `backgroundColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #000000ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundColor __deprecated;

/**
 * The `backgroundElevation01Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation01Color __deprecated;

/**
 * The `backgroundElevation02Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #2c2c2eff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation02Color __deprecated;

/**
 * The `backgroundElevation03Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #3a3a3cff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation03Color __deprecated;

/**
 * The `backgroundSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f1f2f8ff; background: linear-gradient(0.375turn, #f1f2f8ff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundSecondaryColor __deprecated;

/**
 * The `backgroundTertiaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #2c2c2eff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundTertiaryColor __deprecated;

/**
 * The `canvasContrastColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f1f2f8ff; background: linear-gradient(0.375turn, #f1f2f8ff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * canvasContrastColor;

/**
 * The `canvasColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #000000ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * canvasColor;

/**
 * The `coreAccentColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0770e3ff; background: linear-gradient(0.375turn, #0770e3ff 49%, #6d9febff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * coreAccentColor;

/**
 * The `coreEcoColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0fa1a9ff; background: linear-gradient(0.375turn, #0fa1a9ff 49%, #0fa1a9ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * coreEcoColor;

/**
 * The `corePrimaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #02122cff; background: linear-gradient(0.375turn, #02122cff 49%, #054184ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * corePrimaryColor;

/**
 * The `lineColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #cdcdd7ff; background: linear-gradient(0.375turn, #cdcdd7ff 49%, #48484aff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * lineColor __deprecated;

/**
 * The `primaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0770e3ff; background: linear-gradient(0.375turn, #0770e3ff 49%, #6d9febff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryColor __deprecated;

/**
 * The `scrimColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #02122cff; background: linear-gradient(0.375turn, #02122cff 49%, #02122cff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * scrimColor;

/**
 * The `statusDangerFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f6dde1ff; background: linear-gradient(0.375turn, #f6dde1ff 49%, #ffcaddff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusDangerFillColor;

/**
 * The `statusDangerSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #d1435bff; background: linear-gradient(0.375turn, #d1435bff 49%, #d1435bff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusDangerSpotColor;

/**
 * The `statusSuccessFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #d0eeecff; background: linear-gradient(0.375turn, #d0eeecff 49%, #b1ffe7ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusSuccessFillColor;

/**
 * The `statusSuccessSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #00a698ff; background: linear-gradient(0.375turn, #00a698ff 49%, #00a698ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusSuccessSpotColor;

/**
 * The `statusWarningFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffebd0ff; background: linear-gradient(0.375turn, #ffebd0ff 49%, #fbf1bbff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusWarningFillColor;

/**
 * The `statusWarningSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ff9400ff; background: linear-gradient(0.375turn, #ff9400ff 49%, #ffb54dff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * statusWarningSpotColor;

/**
 * The `surfaceContrastColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #02122cff; background: linear-gradient(0.375turn, #02122cff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * surfaceContrastColor;

/**
 * The `surfaceDefaultColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * surfaceDefaultColor;

/**
 * The `surfaceElevatedColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #2c2c2eff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * surfaceElevatedColor;

/**
 * The `surfaceHighlightColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #dddde5ff; background: linear-gradient(0.375turn, #dddde5ff 49%, #2c2c2eff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * surfaceHighlightColor;

/**
 * The `textDisabledColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #b2b2bfff; background: linear-gradient(0.375turn, #b2b2bfff 49%, #8e8e93ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textDisabledColor;

/**
 * The `textErrorColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #d1435bff; background: linear-gradient(0.375turn, #d1435bff 49%, #d1435bff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textErrorColor;

/**
 * The `textLinkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0770e3ff; background: linear-gradient(0.375turn, #0770e3ff 49%, #6d9febff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textLinkColor;

/**
 * The `textOnDarkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #ffffffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textOnDarkColor;

/**
 * The `textOnLightColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #111236ff; background: linear-gradient(0.375turn, #111236ff 49%, #111236ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textOnLightColor;

/**
 * The `textPrimaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #111236ff; background: linear-gradient(0.375turn, #111236ff 49%, #ffffffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textPrimaryColor __deprecated;

/**
 * The `textPrimaryInverseColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #111236ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textPrimaryInverseColor;

/**
 * The `textQuaternaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #8f90a0ff; background: linear-gradient(0.375turn, #8f90a0ff 49%, #8e8e93ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textQuaternaryColor __deprecated;

/**
 * The `textSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #68697fff; background: linear-gradient(0.375turn, #68697fff 49%, #b2b2bfff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textSecondaryColor __deprecated;

/**
 * The `textTertiaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #8f90a0ff; background: linear-gradient(0.375turn, #8f90a0ff 49%, #8e8e93ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textTertiaryColor __deprecated;


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
