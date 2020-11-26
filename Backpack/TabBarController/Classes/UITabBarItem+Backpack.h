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
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UITabBarItem (Backpack)

/**
 * Applies a small dot in the specified colour. Similar in appearance to an empty badge, but smaller.
 *
 * @param color The color to render the dot.
 */
- (void)bpk_addDotWithColor:(UIColor *)color;

/**
 * Removes a dot if one is applied. If no dot has been applied, this will have no effect.
 */
- (void)bpk_removeDot;

@end
NS_ASSUME_NONNULL_END
