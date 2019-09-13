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

#import "BPKDefaultTheme.h"

#import <Backpack/Button.h>
#import <Backpack/Chip.h>
#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Gradient.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

#import "BPKDefaultThemeContainer.h"

@implementation BPKDefaultTheme

NSString *const BPKDefaultThemeName = @"Default";

- (NSString *)themeName {
    return BPKDefaultThemeName;
}

- (BPKFontMapping *)fontMapping {
    return nil;
}

- (UIColor *)chipPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)switchPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)primaryColor {
    return BPKColor.blue500;
}

- (UIColor *)gray50 {
    return BPKColor.gray50;
}

- (UIColor *)gray100 {
    return BPKColor.gray100;
}

- (UIColor *)gray300 {
    return BPKColor.gray300;
}

- (UIColor *)gray500 {
    return BPKColor.gray500;
}

- (UIColor *)gray700 {
    return BPKColor.gray700;
}

- (UIColor *)systemGreen {
    return BPKColor.green500;
}

- (UIColor *)systemRed {
    return BPKColor.red500;
}

- (UIColor *)gray900 {
    return BPKColor.gray900;
}

- (BPKGradient *)primaryGradient {
    return BPKGradient.primary;
}

- (UIColor *)spinnerPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)buttonLinkContentColor {
    return self.primaryColor;
}

- (UIColor *)buttonFeaturedContentColor {
    return BPKColor.white;
}

- (UIColor *)buttonFeaturedGradientStartColor {
    return BPKColor.pink500;
}

- (UIColor *)buttonFeaturedGradientEndColor {
    return BPKColor.pink600;
}

- (UIColor *)buttonPrimaryContentColor {
    return BPKColor.white;
}

- (UIColor *)buttonPrimaryGradientStartColor {
    return BPKColor.green500;
}

- (UIColor *)buttonPrimaryGradientEndColor {
    return BPKColor.green600;
}

- (UIColor *)buttonSecondaryContentColor {
    return self.primaryColor;
}

- (UIColor *)buttonSecondaryBackgroundColor {
    return BPKColor.white;
}

- (UIColor *)buttonSecondaryBorderColor {
    return BPKColor.gray100;
}

- (UIColor *)buttonDestructiveContentColor {
    return BPKColor.red500;
}

- (UIColor *)buttonDestructiveBackgroundColor {
    return BPKColor.white;
}

- (UIColor *)buttonDestructiveBorderColor {
    return BPKColor.gray100;
}

- (NSNumber *)buttonCornerRadius {
    return nil;
}

- (UIColor *)calendarDateSelectedContentColor {
    return BPKColor.white;
}

- (UIColor *)calendarDateSelectedBackgroundColor {
    return self.primaryColor;
}

- (Class)themeContainerClass {
    return [BPKDefaultThemeContainer class];
}

- (UIColor *)starFilledColor {
    return BPKColor.yellow500;
}

- (UIColor *)horiontalNavigationSelectedColor {
    return self.primaryColor;
}

- (UIColor *)ratingLowColor {
    return BPKColor.red500;
}

- (UIColor *)ratingMediumColor {
    return BPKColor.yellow500;
}

- (UIColor *)ratingHighColor {
    return BPKColor.green500;
}

@end
