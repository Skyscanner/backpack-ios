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
 * The `iDontWantThisAnymore` color from the Backpack palette - rgb(255, 255, 255).
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_iDontWantThisAnymore;

/**
 * The `clear` color from the Backpack palette.
*/
@property(nonatomic, class, readonly) UIColor * bpk_clear;

///-----------------------
/// @name Dynamic colors
///-----------------------

/**
 * The `canvasColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_canvasColor;

/**
 * The `canvasContrastColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #eff3f8ff; background: linear-gradient(0.375turn, #eff3f8ff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_canvasContrastColor;

/**
 * The `coreEcoColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0fa1a9ff; background: linear-gradient(0.375turn, #0fa1a9ff 49%, #0fa1a9ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_coreEcoColor;

/**
 * The `coreAccentColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0062e3ff; background: linear-gradient(0.375turn, #0062e3ff 49%, #84e9ffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_coreAccentColor;

/**
 * The `corePrimaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #05203cff; background: linear-gradient(0.375turn, #05203cff 49%, #054184ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_corePrimaryColor;

/**
 * The `statusSuccessSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0c838aff; background: linear-gradient(0.375turn, #0c838aff 49%, #62f1c6ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusSuccessSpotColor;

/**
 * The `statusSuccessFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #d4fff2ff; background: linear-gradient(0.375turn, #d4fff2ff 49%, #b1ffe7ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusSuccessFillColor;

/**
 * The `statusDangerSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #e70866ff; background: linear-gradient(0.375turn, #e70866ff 49%, #ff649cff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusDangerSpotColor;

/**
 * The `statusWarningSpotColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f55d42ff; background: linear-gradient(0.375turn, #f55d42ff 49%, #feeb87ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusWarningSpotColor;

/**
 * The `statusDangerFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffe9f9ff; background: linear-gradient(0.375turn, #ffe9f9ff 49%, #ffcaddff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusDangerFillColor;

/**
 * The `statusWarningFillColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #fff7cfff; background: linear-gradient(0.375turn, #fff7cfff 49%, #fbf1bbff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_statusWarningFillColor;

/**
 * The `surfaceHeroColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0062e3ff; background: linear-gradient(0.375turn, #0062e3ff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_surfaceHeroColor;

/**
 * The `surfaceDefaultColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #131d2bff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_surfaceDefaultColor;

/**
 * The `surfaceContrastColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #05203cff; background: linear-gradient(0.375turn, #05203cff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_surfaceContrastColor;

/**
 * The `surfaceElevatedColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #243346ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_surfaceElevatedColor;

/**
 * The `surfaceLowContrastColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #f5f7faff; background: linear-gradient(0.375turn, #f5f7faff 49%, #243346ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_surfaceLowContrastColor;

/**
 * The `surfaceSubtleColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #e3f0ffff; background: linear-gradient(0.375turn, #e3f0ffff 49%, #243346ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_surfaceSubtleColor;

/**
 * The `surfaceHighlightColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #e0e4e9ff; background: linear-gradient(0.375turn, #e0e4e9ff 49%, #243346ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_surfaceHighlightColor;

/**
 * The `textOnDarkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #ffffffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textOnDarkColor;

/**
 * The `textOnLightColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #161616ff; background: linear-gradient(0.375turn, #161616ff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textOnLightColor;

/**
 * The `textDisabledOnDarkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffff80; background: linear-gradient(0.375turn, #ffffff80 49%, #ffffff80 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textDisabledOnDarkColor;

/**
 * The `textLinkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0062e3ff; background: linear-gradient(0.375turn, #0062e3ff 49%, #84e9ffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textLinkColor;

/**
 * The `textHeroColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #0062e3ff; background: linear-gradient(0.375turn, #0062e3ff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textHeroColor;

/**
 * The `textDisabledColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #00000033; background: linear-gradient(0.375turn, #00000033 49%, #ffffff33 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textDisabledColor;

/**
 * The `textPrimaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #161616ff; background: linear-gradient(0.375turn, #161616ff 49%, #ffffffff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textPrimaryColor;

/**
 * The `textErrorColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #e70866ff; background: linear-gradient(0.375turn, #e70866ff 49%, #ff649cff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textErrorColor;

/**
 * The `textPrimaryInverseColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffffff; background: linear-gradient(0.375turn, #ffffffff 49%, #010913ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textPrimaryInverseColor;

/**
 * The `textSecondaryColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #626971ff; background: linear-gradient(0.375turn, #626971ff 49%, #bdc4cbff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_textSecondaryColor;

/**
 * The `lineColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #c1c7cfff; background: linear-gradient(0.375turn, #c1c7cfff 49%, #44505fff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_lineColor;

/**
 * The `lineOnDarkColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #ffffff80; background: linear-gradient(0.375turn, #ffffff80 49%, #44505fff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_lineOnDarkColor;

/**
 * The `scrimColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #000000b3; background: linear-gradient(0.375turn, #000000b3 49%, #000000b3 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_scrimColor;

/**
 * The `overlayColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #00000033; background: linear-gradient(0.375turn, #00000033 49%, #ffffffcc 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_overlayColor;

/**
 * The `shadowColor` dynamic color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background-color: #161616ff; background: linear-gradient(0.375turn, #161616ff 49%, #161616ff 50%); box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * bpk_shadowColor;


@end
NS_ASSUME_NONNULL_END
// clang-format on
