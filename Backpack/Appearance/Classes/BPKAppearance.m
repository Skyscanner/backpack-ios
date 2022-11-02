/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

#import "BPKAppearance.h"

#import <Backpack/Color.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPKAppearance

+ (void)apply {
    UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
    [appearance configureWithDefaultBackground];
    appearance.backgroundColor = BPKColor.surfaceDefaultColor;
    appearance.selectionIndicatorTintColor = BPKColor.coreEcoColor;
    
    if (@available(iOS 15, *)) {
        [UITabBar appearance].scrollEdgeAppearance = appearance;
    }
    
    [BPKAppearance updateTabBarItemAppearance:appearance.compactInlineLayoutAppearance];
    [BPKAppearance updateTabBarItemAppearance:appearance.inlineLayoutAppearance];
    [BPKAppearance updateTabBarItemAppearance:appearance.stackedLayoutAppearance];
    
    [[UITabBar appearance] setStandardAppearance:appearance];
}

+ (void)updateTabBarItemAppearance:(UITabBarItemAppearance *) appearance {
    appearance.selected.iconColor = BPKColor.coreAccentColor;
    appearance.normal.iconColor = BPKColor.textSecondaryColor;
    appearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName: BPKColor.textSecondaryColor};
}

@end

NS_ASSUME_NONNULL_END
