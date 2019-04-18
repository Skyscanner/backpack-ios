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

#import "BPKHongKongTheme.h"
#import "BPKHongKongThemeContainer.h"

#import <Backpack/Button.h>
#import <Backpack/Chip.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

@implementation BPKHongKongTheme

- (NSString *)themeName {
    return @"Hong Kong";
}

- (UIColor *)chipPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)switchPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)primaryColor {
    return [UIColor colorWithRed:76.0f / 255.0f green:76.0f / 255.0f blue:76.0f / 255.0f alpha:1.0f];
}

- (UIColor *)spinnerPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)buttonLinkContentColor {
    return self.primaryColor;
}

- (UIColor *)buttonPrimaryContentColor {
    return [UIColor colorWithRed:255.0f / 255.0f green:163.0f / 255.0f blue:203.0f / 255.0f alpha:1.0f];
}

- (UIColor *)buttonPrimaryGradientStartColor {
    return [UIColor colorWithRed:126.0f / 255.0f green:126.0f / 255.0f blue:126.0f / 255.0f alpha:1.0f];
}

- (UIColor *)buttonPrimaryGradientEndColor {
    return [UIColor colorWithRed:70.0f / 255.0f green:70.0f / 255.0f blue:70.0f / 255.0f alpha:1.0f];
}

- (Class)themeContainerClass {
    return [BPKHongKongThemeContainer class];
}

@end
