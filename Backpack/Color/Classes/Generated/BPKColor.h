// clang-format off
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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
NS_SWIFT_NAME(Color) @interface BPKColor : NSObject

///-----------------------
/// @name Colors
///-----------------------

/**
 * The `backgroundDarkColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #000000ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundDarkColor;

/**
 * The `backgroundLightColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundLightColor;

/**
 * The `abisko` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #5a489bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * abisko;

/**
 * The `bagan` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffebd0ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bagan;

/**
 * The `bunol` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ff7b59ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bunol;

/**
 * The `erfoud` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffb54dff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * erfoud;

/**
 * The `glencoe` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #73cec6ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * glencoe;

/**
 * The `harbour` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #f6dde1ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * harbour;

/**
 * The `hillier` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #e18b96ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * hillier;

/**
 * The `kolkata` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ff9400ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * kolkata;

/**
 * The `monteverde` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #00a698ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * monteverde;

/**
 * The `nara` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffe7e0ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * nara;

/**
 * The `panjin` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #d1435bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * panjin;

/**
 * The `petra` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffab95ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * petra;

/**
 * The `primaryGradientLight` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #0770e3ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryGradientLight;

/**
 * The `sagano` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #d0eeecff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * sagano;

/**
 * The `skyBlue` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #0770e3ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlue;

/**
 * The `skyBlueShade01` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #084eb2ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueShade01;

/**
 * The `skyBlueShade02` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #042759ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueShade02;

/**
 * The `skyBlueShade03` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #02122cff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueShade03;

/**
 * The `skyBlueTint01` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #6d9febff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueTint01;

/**
 * The `skyBlueTint02` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #9dc0f2ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueTint02;

/**
 * The `skyBlueTint03` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #cddff8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyBlueTint03;

/**
 * The `skyGray` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #111236ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGray;

/**
 * The `skyGrayTint01` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #444560ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint01;

/**
 * The `skyGrayTint02` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #68697fff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint02;

/**
 * The `skyGrayTint03` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #8f90a0ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint03;

/**
 * The `skyGrayTint04` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #b2b2bfff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint04;

/**
 * The `skyGrayTint05` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #cdcdd7ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint05;

/**
 * The `skyGrayTint06` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #dddde5ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint06;

/**
 * The `skyGrayTint07` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #f1f2f8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * skyGrayTint07;

/**
 * The `systemGreen` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #00a698ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * systemGreen;

/**
 * The `systemRed` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #d1435bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * systemRed;

/**
 * The `tochigi` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #e1ddecff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * tochigi;

/**
 * The `valensole` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #a59bc8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * valensole;

/**
 * The `white` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * white;

/**
 * The `primaryLightColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #0770e3ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryLightColor;

/**
 * The `secondaryDarkColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #6d9febff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * secondaryDarkColor;

/**
 * The `shadowLgColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #111236ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * shadowLgColor;

/**
 * The `shadowSmColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #111236ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * shadowSmColor;

/**
 * The `textPrimaryDarkColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textPrimaryDarkColor;

/**
 * The `textPrimaryLightColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #111236ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textPrimaryLightColor;

/**
 * The `textQuaternaryDarkColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #cdcdd7ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textQuaternaryDarkColor;

/**
 * The `textQuaternaryLightColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #8f90a0ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textQuaternaryLightColor;

/**
 * The `textSecondaryDarkColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #8f90a0ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textSecondaryDarkColor;

/**
 * The `textSecondaryLightColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #68697fff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textSecondaryLightColor;

/**
 * The `textTertiaryDarkColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #b2b2bfff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textTertiaryDarkColor;

/**
 * The `textTertiaryLightColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #8f90a0ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textTertiaryLightColor;

/**
 * The `touchableOverlayColor` color from the Backpack palette.
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
 * The `backgroundColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #000000ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundColor;

/**
 * The `textPrimaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #111236ff; background: linear-gradient(0.375turn, #111236ff 49%, #ffffffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textPrimaryColor;

/**
 * The `textQuaternaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #8f90a0ff; background: linear-gradient(0.375turn, #8f90a0ff 49%, #cdcdd7ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textQuaternaryColor;

/**
 * The `textSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #68697fff; background: linear-gradient(0.375turn, #68697fff 49%, #8f90a0ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textSecondaryColor;

/**
 * The `textTertiaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #8f90a0ff; background: linear-gradient(0.375turn, #8f90a0ff 49%, #b2b2bfff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textTertiaryColor;


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
