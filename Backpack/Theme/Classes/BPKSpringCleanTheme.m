/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import "BPKSpringCleanTheme.h"

#import <Backpack/Button.h>
#import <Backpack/Chip.h>
#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Gradient.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

#import "BPKSpringCleanThemeContainer.h"

@implementation BPKSpringCleanTheme

NSString *const BPKSpringCleanThemeName = @"Spring clean";

- (NSString *)themeName {
    return BPKSpringCleanThemeName;
}

- (UIColor *)chipPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)switchPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)primaryColor {
    return [UIColor colorWithRed:0.0f / 255.0f green:178.0f / 255.0f blue:214.0f / 255.0f alpha:1.0f];
}

- (UIColor *_Nullable)progressBarPrimaryColor {
    return self.primaryColor;
}

- (UIColor *_Nullable)linkPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)gray50 {
    return BPKColor.skyGrayTint07;
}

- (UIColor *)gray100 {
    return BPKColor.skyGrayTint06;
}

- (UIColor *)gray300 {
    return BPKColor.skyGrayTint05;
}

- (UIColor *)gray500 {
    return BPKColor.skyGrayTint04;
}

- (UIColor *)gray700 {
    return BPKColor.skyGrayTint03;
}

- (UIColor *)systemGreen {
    return [UIColor colorWithRed:0.0f / 255.0f green:215.0f / 255.0f blue:117.0f / 255.0f alpha:1.0f];
}

- (UIColor *)systemRed {
    return [UIColor colorWithRed:255.0f / 255.0f green:84.0f / 255.0f blue:82.0f / 255.0f alpha:1.0f];
}

- (UIColor *)gray900 {
    return BPKColor.skyGray;
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
    return [UIColor colorWithRed:250.0f / 255.0f green:72.0f / 255.0f blue:138.0f / 255.0f alpha:1.0f];
}

- (UIColor *)buttonFeaturedGradientEndColor {
    return [UIColor colorWithRed:217.0f / 255.0f green:43.0f / 255.0f blue:107.0f / 255.0f alpha:1.0f];
}

- (UIColor *)buttonPrimaryContentColor {
    return BPKColor.white;
}

- (UIColor *)buttonPrimaryGradientStartColor {
    return [self systemGreen];
}

- (UIColor *)buttonPrimaryGradientEndColor {
    return [UIColor colorWithRed:0.0f / 255.0f green:189.0f / 255.0f blue:104.0f / 255.0f alpha:1.0f];
}

- (UIColor *)buttonSecondaryContentColor {
    return self.primaryColor;
}

- (UIColor *)buttonSecondaryBackgroundColor {
    return BPKColor.white;
}

- (UIColor *)buttonSecondaryBorderColor {
    return BPKColor.skyGrayTint06;
}

- (UIColor *)buttonDestructiveContentColor {
    return [self systemRed];
}

- (UIColor *)buttonDestructiveBackgroundColor {
    return BPKColor.white;
}

- (UIColor *)buttonDestructiveBorderColor {
    return BPKColor.skyGrayTint06;
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
    return [BPKSpringCleanThemeContainer class];
}

- (UIColor *)starFilledColor {
    return [UIColor colorWithRed:255.0f / 255.0f green:187.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f];
}

- (UIColor *)horiontalNavigationSelectedColor {
    return self.primaryColor;
}

- (UIColor *)ratingLowColor {
    return [self systemRed];
}

- (UIColor *)ratingMediumColor {
    return [UIColor colorWithRed:255.0f / 255.0f green:187.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f];
}

- (UIColor *)ratingHighColor {
    return [self systemGreen];
}

@end
