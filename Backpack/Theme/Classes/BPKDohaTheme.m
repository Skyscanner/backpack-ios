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
#import "BPKDohaThemeContainer.h"

#import <Backpack/Switch.h>

@implementation BPKDohaTheme


+ (void)apply {
    [self applyWithContainer:[BPKDohaThemeContainer class]];
}

+ (void)applyWithContainer:(Class) class {
    UIColor *switchPrimaryColor = [UIColor colorWithRed:237.0f/255.0f green:27.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
    [[BPKSwitch appearanceWhenContainedInInstancesOfClasses:@[class]] setOnTintColor:switchPrimaryColor];
}

@end
