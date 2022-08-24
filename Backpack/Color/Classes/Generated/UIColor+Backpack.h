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

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
/**
 * Backpack's color palette.
*/
@interface UIColor(Backpack)

///-----------------------
/// @name Colors
///-----------------------

/**
 * The `clear` color from the Backpack palette.
*/
@property(nonatomic, class, readonly) UIColor * bpk_clear;

///-----------------------
/// @name Dynamic colors
///-----------------------

/**
 * The `backgroundAlternativeColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f1f2f8ff; background: linear-gradient(0.375turn, #f1f2f8ff 49%, #000000ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_backgroundAlternativeColor;

/**
 * The `backgroundAlternativeSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_backgroundAlternativeSecondaryColor;

/**
 * The `backgroundColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #000000ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_backgroundColor;

/**
 * The `backgroundElevation01Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_backgroundElevation01Color;

/**
 * The `backgroundElevation02Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #2c2c2eff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_backgroundElevation02Color;

/**
 * The `backgroundElevation03Color` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #3a3a3cff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_backgroundElevation03Color;

/**
 * The `backgroundSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f1f2f8ff; background: linear-gradient(0.375turn, #f1f2f8ff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_backgroundSecondaryColor;

/**
 * The `backgroundTertiaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #2c2c2eff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_backgroundTertiaryColor;

/**
 * The `canvasContrastColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f1f2f8ff; background: linear-gradient(0.375turn, #f1f2f8ff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_canvasContrastColor;

/**
 * The `canvasColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #000000ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_canvasColor;

/**
 * The `coreAccentColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0770e3ff; background: linear-gradient(0.375turn, #0770e3ff 49%, #6d9febff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_coreAccentColor;

/**
 * The `coreEcoColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0fa1a9ff; background: linear-gradient(0.375turn, #0fa1a9ff 49%, #0fa1a9ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_coreEcoColor;

/**
 * The `corePrimaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #02122cff; background: linear-gradient(0.375turn, #02122cff 49%, #054184ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_corePrimaryColor;

/**
 * The `lineColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #cdcdd7ff; background: linear-gradient(0.375turn, #cdcdd7ff 49%, #48484aff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_lineColor;

/**
 * The `primaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0770e3ff; background: linear-gradient(0.375turn, #0770e3ff 49%, #6d9febff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_primaryColor;

/**
 * The `scrimColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #02122cff; background: linear-gradient(0.375turn, #02122cff 49%, #02122cff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_scrimColor;

/**
 * The `statusDangerFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f6dde1ff; background: linear-gradient(0.375turn, #f6dde1ff 49%, #ffcaddff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusDangerFillColor;

/**
 * The `statusDangerSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #d1435bff; background: linear-gradient(0.375turn, #d1435bff 49%, #d1435bff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusDangerSpotColor;

/**
 * The `statusSuccessFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #d0eeecff; background: linear-gradient(0.375turn, #d0eeecff 49%, #b1ffe7ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusSuccessFillColor;

/**
 * The `statusSuccessSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #00a698ff; background: linear-gradient(0.375turn, #00a698ff 49%, #00a698ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusSuccessSpotColor;

/**
 * The `statusWarningFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffebd0ff; background: linear-gradient(0.375turn, #ffebd0ff 49%, #fbf1bbff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusWarningFillColor;

/**
 * The `statusWarningSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ff9400ff; background: linear-gradient(0.375turn, #ff9400ff 49%, #ffb54dff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusWarningSpotColor;

/**
 * The `surfaceContrastColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #02122cff; background: linear-gradient(0.375turn, #02122cff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_surfaceContrastColor;

/**
 * The `surfaceDefaultColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #1d1b20ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_surfaceDefaultColor;

/**
 * The `surfaceElevatedColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #2c2c2eff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_surfaceElevatedColor;

/**
 * The `surfaceHighlightColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #dddde5ff; background: linear-gradient(0.375turn, #dddde5ff 49%, #2c2c2eff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_surfaceHighlightColor;

/**
 * The `textDisabledColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #b2b2bfff; background: linear-gradient(0.375turn, #b2b2bfff 49%, #8e8e93ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textDisabledColor;

/**
 * The `textErrorColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #d1435bff; background: linear-gradient(0.375turn, #d1435bff 49%, #d1435bff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textErrorColor;

/**
 * The `textLinkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0770e3ff; background: linear-gradient(0.375turn, #0770e3ff 49%, #6d9febff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textLinkColor;

/**
 * The `textOnDarkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #ffffffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textOnDarkColor;

/**
 * The `textOnLightColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #111236ff; background: linear-gradient(0.375turn, #111236ff 49%, #111236ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textOnLightColor;

/**
 * The `textPrimaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #111236ff; background: linear-gradient(0.375turn, #111236ff 49%, #ffffffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textPrimaryColor;

/**
 * The `textPrimaryInverseColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #111236ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textPrimaryInverseColor;

/**
 * The `textQuaternaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #8f90a0ff; background: linear-gradient(0.375turn, #8f90a0ff 49%, #8e8e93ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textQuaternaryColor;

/**
 * The `textSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #68697fff; background: linear-gradient(0.375turn, #68697fff 49%, #b2b2bfff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textSecondaryColor;

/**
 * The `textTertiaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #8f90a0ff; background: linear-gradient(0.375turn, #8f90a0ff 49%, #8e8e93ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textTertiaryColor;


@end
NS_ASSUME_NONNULL_END
// clang-format on
