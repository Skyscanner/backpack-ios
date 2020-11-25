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

#import "BPKTabBarHelpers.h"

#import <Backpack/Color.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPKTabBarHelpers

+(UIColor*)tintColor {
    return BPKColor.primaryColor;
}

+(UIColor*)unselectedTintColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint03 darkVariant:BPKColor.blackTint06];
}

+(void)applyBrandTintColours {
    [UITabBar appearance].tintColor = self.tintColor;
    [UITabBar appearance].unselectedItemTintColor = self.unselectedTintColor;
}

@end

NS_ASSUME_NONNULL_END
