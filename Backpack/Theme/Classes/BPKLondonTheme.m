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

#import "BPKLondonTheme.h"
#import "BPKLondonThemeContainer.h"

#import <Backpack/Button.h>
#import <Backpack/Chip.h>
#import <Backpack/Color.h>
#import <Backpack/Radii.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

@implementation BPKLondonTheme

- (NSString *)themeName {
    return @"London";
}

- (UIColor *)chipPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)switchPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)primaryColor {
    return [UIColor colorWithRed:237.0f / 255.0f green:27.0f / 255.0f blue:40.0f / 255.0f alpha:1.0f];
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
    return [UIColor colorWithRed:0.00392 green:0.227 blue:0.463 alpha:1];
}

- (UIColor *)buttonPrimaryGradientEndColor {
    return [UIColor colorWithRed:0 green:0.184 blue:0.38 alpha:1];
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
- (NSNumber *)buttonCornerRadius {
    return @(BPKBorderRadiusSm);
}

- (UIColor *)calendarDateSelectedContentColor {
    return BPKColor.white;
}

- (UIColor *)calendarDateSelectedBackgroundColor {
    return self.primaryColor;
}

- (Class)themeContainerClass {
    return [BPKLondonThemeContainer class];
}

@end
