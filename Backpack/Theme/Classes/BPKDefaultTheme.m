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
#import "BPKDefaultThemeContainer.h"

#import <Backpack/Button.h>
#import <Backpack/Chip.h>
#import <Backpack/Color.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

@implementation BPKDefaultTheme

- (NSString *)themeName {
    return @"Default";
}

- (UIColor *)switchPrimaryColor {
    return BPKColor.blue500;
}

- (UIColor *)spinnerPrimaryColor {
    return BPKColor.blue500;
}

- (Class)themeContainerClass {
    return [BPKDefaultThemeContainer class];
}

@end
