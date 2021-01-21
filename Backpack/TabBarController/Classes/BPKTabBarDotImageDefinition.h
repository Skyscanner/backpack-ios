/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKTabBarDotImageDefinition` contains a pair of UIImages to use in light mode and dark mode respectively.
 */
IB_DESIGNABLE @interface BPKTabBarDotImageDefinition : NSObject

/**
 * The dot image to display in light mode.
 */
@property(nonatomic, strong) UIImage *lightImage;

/**
 * The dot image to display in dark mode.
 */
@property(nonatomic, strong) UIImage *darkImage;

/**
 * Create a `BPKTabBarDotImageDefinition`.
 *
 * @param lightImage The dot image to display in light mode.
 * @param darkImage The dot image to display in dark mode.
 * @return `BPKTabBarDotImageDefinition` instance.
 */
- (instancetype)initWithLightImage:(UIImage *)lightImage darkImage:(UIImage *)darkImage;

@end

NS_ASSUME_NONNULL_END
