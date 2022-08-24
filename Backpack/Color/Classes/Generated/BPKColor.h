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
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeColor;

/**
 * The `backgroundAlternativeSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundAlternativeSecondaryColor;

/**
 * The `backgroundColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #000000ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundColor;

/**
 * The `backgroundElevation01Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation01Color;

/**
 * The `backgroundElevation02Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #2c2c2eff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation02Color;

/**
 * The `backgroundElevation03Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #3a3a3cff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundElevation03Color;

/**
 * The `backgroundSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f1f2f8ff; background: linear-gradient(0.375turn, #f1f2f8ff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundSecondaryColor;

/**
 * The `backgroundTertiaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #2c2c2eff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * backgroundTertiaryColor;

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
@property(nonatomic, class, readonly) UIColor * lineColor;

/**
 * The `primaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0770e3ff; background: linear-gradient(0.375turn, #0770e3ff 49%, #6d9febff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryColor;

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
@property(nonatomic, class, readonly) UIColor * textPrimaryColor;

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
@property(nonatomic, class, readonly) UIColor * textQuaternaryColor;

/**
 * The `textSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #68697fff; background: linear-gradient(0.375turn, #68697fff 49%, #b2b2bfff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * textSecondaryColor;

/**
 * The `textTertiaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #8f90a0ff; background: linear-gradient(0.375turn, #8f90a0ff 49%, #8e8e93ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
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
