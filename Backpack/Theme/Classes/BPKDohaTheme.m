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

#import "BPKDohaTheme.h"

#import <Backpack/Button.h>
#import <Backpack/Chip.h>
#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Gradient.h>
#import <Backpack/Radii.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

#import "BPKDohaThemeContainer.h"

@implementation BPKDohaTheme

- (NSString *)themeName {
    return @"Doha";
}

- (BPKFontMapping *)fontMapping {
    return [[BPKFontMapping alloc] initWithFamily:@"AmericanTypewriter"
                                  regularFontFace:@"AmericanTypewriter-Light"
                                 semiboldFontFace:@"AmericanTypewriter-Semibold"
                                    heavyFontFace:@"AmericanTypewriter-Bold"];
}

- (UIColor *)switchPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)primaryColor {
    return [UIColor colorWithRed:255.0f / 255.0f green:184.0f / 255.0f blue:2.0f / 255.0f alpha:1.0f];
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
    UIColor *startColor = [UIColor colorWithRed:1 green:0.757 blue:0.0275 alpha:1];
    UIColor *endColor = [UIColor colorWithRed:1 green:0.702 blue:0 alpha:1];
    CGPoint startPoint = [BPKGradient startPointForDirection:BPKGradientDirectionBottomLeft];
    CGPoint endPoint = [BPKGradient endPointForDirection:BPKGradientDirectionBottomLeft];

    return [[BPKGradient alloc] initWithColors:@[startColor, endColor] startPoint:startPoint endPoint:endPoint];
}

- (UIColor *)chipPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)spinnerPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)buttonLinkContentColor {
    return self.primaryColor;
}

- (UIColor *)buttonPrimaryContentColor {
    return BPKColor.white;
}

- (UIColor *)buttonPrimaryGradientStartColor {
    return [UIColor colorWithRed:1 green:0.757 blue:0.0275 alpha:1];
}

- (UIColor *)buttonPrimaryGradientEndColor {
    return [UIColor colorWithRed:1 green:0.702 blue:0 alpha:1];
}

- (UIColor *)buttonFeaturedContentColor {
    return BPKColor.white;
}

- (UIColor *)buttonFeaturedGradientStartColor {
    return [UIColor colorWithRed:0.749019608 green:0.211764706 blue:0.443137255 alpha:1];
}

- (UIColor *)buttonFeaturedGradientEndColor {
    return [UIColor colorWithRed:0.368627451 green:0.02745098 blue:0.17254902 alpha:1];
}

- (UIColor *)buttonSecondaryContentColor {
    return [UIColor colorWithRed:0.608 green:0.0627 blue:0.298 alpha:1];
}

- (UIColor *)buttonSecondaryBackgroundColor {
    return BPKColor.white;
}

- (UIColor *)buttonSecondaryBorderColor {
    return BPKColor.skyGrayTint06;
}

- (UIColor *)buttonDestructiveContentColor {
    return [UIColor colorWithRed:0.368627451 green:0.02745098 blue:0.17254902 alpha:1];
}

- (UIColor *)buttonDestructiveBackgroundColor {
    return BPKColor.white;
}

- (UIColor *)buttonDestructiveBorderColor {
    return BPKColor.skyGrayTint06;
}

- (NSNumber *)buttonCornerRadius {
    return @(BPKBorderRadiusSm * 2);
}

- (UIColor *)calendarDateSelectedContentColor {
    return [UIColor colorWithRed:6.0f / 255.0f green:96.0f / 255.0f blue:96.0f / 255.0f alpha:1.0f];
}

- (UIColor *)calendarDateSelectedBackgroundColor {
    return self.primaryColor;
}

- (Class)themeContainerClass {
    return [BPKDohaThemeContainer class];
}

- (UIColor *)starFilledColor {
    return BPKColor.kolkata;
}

- (UIColor *)horiontalNavigationSelectedColor {
    return self.primaryColor;
}

- (UIColor *)ratingLowColor {
    return UIColor.redColor;
}

- (UIColor *)ratingMediumColor {
    return UIColor.yellowColor;
}

- (UIColor *)ratingHighColor {
    return UIColor.greenColor;
}

@end
