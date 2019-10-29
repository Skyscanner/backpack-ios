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

#import "BPKSilverTheme.h"

#import <Backpack/Button.h>
#import <Backpack/Chip.h>
#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Gradient.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

#import "BPKSilverThemeContainer.h"

@implementation BPKSilverTheme

- (NSString *)themeName {
    return @"Silver";
}

- (BPKFontMapping *)fontMapping {
    return [[BPKFontMapping alloc] initWithFamily:@"Charter"
                                  regularFontFace:@"Charter-Roman"
                                 semiboldFontFace:@"Charter-Bold"
                                    heavyFontFace:@"Charter-Black"];
}

- (UIColor *)chipPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)switchPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)primaryColor {
    return BPKColor.skyBlueTint03;
}

- (UIColor *_Nullable)progressBarPrimaryColor {
    return self.primaryColor;
}

- (UIColor *_Nullable)linkPrimaryColor {
    return self.primaryColor;
}

/**
 * Gray50 colour, #F1F2F8
 */
- (UIColor *)gray50 {
    return BPKColor.skyGrayTint07;
}

/**
 * Gray100 colour, #DDDDE5
 */
- (UIColor *)gray100 {
    return BPKColor.skyGrayTint06;
}

/**
 * Gray300 colour, #B2B2BF
 */
- (UIColor *)gray300 {
    return BPKColor.skyGrayTint04;
}

/**
 * Gray500 colour, #68697F
 */
- (UIColor *)gray500 {
    return BPKColor.skyGrayTint02;
}

/**
 * Gray700, #444560
 */
- (UIColor *)gray700 {
    return BPKColor.skyGrayTint01;
}

/**
 * Gray900 colour, #111236
 */
- (UIColor *)gray900 {
    return BPKColor.skyGray;
}

- (UIColor *)systemGreen {
    return [UIColor colorWithRed:0.0f / 255.0f green:255.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f];
}

- (UIColor *)systemRed {
    return [UIColor colorWithRed:255.0f / 255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f];
}

- (BPKGradient *)primaryGradient {
    UIColor *startColor = BPKColor.skyGrayTint05;
    UIColor *endColor = BPKColor.skyGray;
    CGPoint startPoint = [BPKGradient startPointForDirection:BPKGradientDirectionBottomLeft];
    CGPoint endPoint = [BPKGradient endPointForDirection:BPKGradientDirectionBottomLeft];

    return [[BPKGradient alloc] initWithColors:@[startColor, endColor] startPoint:startPoint endPoint:endPoint];
}

- (UIColor *)spinnerPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)buttonLinkContentColor {
    return BPKColor.skyBlueShade02;
}

- (UIColor *)buttonFeaturedContentColor {
    return BPKColor.skyGrayTint05;
}

- (UIColor *)buttonFeaturedGradientStartColor {
    return BPKColor.skyBlueShade02;
}

- (UIColor *)buttonFeaturedGradientEndColor {
    return BPKColor.skyBlueShade01;
}

- (UIColor *)buttonDestructiveContentColor {
    return BPKColor.panjin;
}

- (UIColor *)buttonDestructiveBackgroundColor {
    return BPKColor.skyGrayTint06;
}

- (UIColor *)buttonDestructiveBorderColor {
    return BPKColor.panjin;
}

- (UIColor *)buttonPrimaryContentColor {
    return BPKColor.skyBlueShade01;
}

- (UIColor *)buttonPrimaryGradientStartColor {
    return BPKColor.white;
}

- (UIColor *)buttonPrimaryGradientEndColor {
    return BPKColor.skyGrayTint05;
}

- (UIColor *)buttonSecondaryContentColor {
    return BPKColor.skyBlueShade01;
}

- (UIColor *)buttonSecondaryBackgroundColor {
    return BPKColor.skyGrayTint06;
}

- (UIColor *)buttonSecondaryBorderColor {
    return BPKColor.skyBlueShade02;
}

- (NSNumber *)buttonCornerRadius {
    return @4.0;
}

- (UIColor *)calendarDateSelectedContentColor {
    return self.primaryColor;
}

- (UIColor *)calendarDateSelectedBackgroundColor {
    return BPKColor.skyGrayTint06;
}

- (Class)themeContainerClass {
    return [BPKSilverThemeContainer class];
}

- (UIColor *)starFilledColor {
    return BPKColor.panjin;
}

- (UIColor *)horiontalNavigationSelectedColor {
    return self.primaryColor;
}

- (UIColor *)ratingLowColor {
    return UIColor.purpleColor;
}

- (UIColor *)ratingMediumColor {
    return UIColor.orangeColor;
}

- (UIColor *)ratingHighColor {
    return UIColor.cyanColor;
}

@end
