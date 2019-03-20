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

#import "BPKTheme.h"
#import "BPKDohaThemeContainer.h"

#import <Backpack/Switch.h>

@implementation BPKTheme


+ (void)apply {
    [self applyWithContainer:[self getThemeContainerClass]];
}

+ (void)applyWithContainer:(Class) class {
    UIColor *switchPrimaryColor = [self getSwitchPrimaryColor];
    [[BPKSwitch appearanceWhenContainedInInstancesOfClasses:@[class]] setOnTintColor:switchPrimaryColor];
}

+ (UIColor *)getSwitchPrimaryColor {
    // "BPKTheme should not be applied directly. Subclasses that override `getSwitchPrimaryColor` should be used instead.
    assert(false);
    return nil;
}

+ (Class)getThemeContainerClass {
    // "BPKTheme should not be applied directly. Subclasses that override `getThemeContainerClass` should be used instead.
    assert(false);
    return nil;
}


@end
