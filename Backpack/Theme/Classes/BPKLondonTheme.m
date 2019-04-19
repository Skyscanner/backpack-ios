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
    return [UIColor colorWithRed:237.0f / 255.0f green:27.0f / 255.0f blue:40.0f / 255.0f alpha:1.0f];
}

- (UIColor *)buttonPrimaryGradientEndColor {
    return [UIColor colorWithRed:162.0f / 255.0f green:27.0f / 255.0f blue:36.0f / 255.0f alpha:1.0f];
}

- (UIColor *)buttonSecondaryContentColor {
    return self.primaryColor;
}

- (UIColor *)buttonSecondaryBackgroundColor {
    return BPKColor.blue100;
}

- (UIColor *)buttonSecondaryBorderColor {
    return self.primaryColor;
}

- (Class)themeContainerClass {
    return [BPKLondonThemeContainer class];
}

@end
