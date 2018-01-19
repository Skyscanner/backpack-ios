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
#import <Foundation/Foundation.h>

/**
 * These constants represent the directions available for gradients in Backpack.
 * The direction specifies the location that the last color in the gradient will fall on. 
 */
typedef NS_ENUM(NSUInteger, BPKGradientDirection) {

    /**
     * Gradient runs from bottom to top.
     */
    BPKGradientDirectionUp,

    /**
    * Gradient runs from top to bottom.
    */
    BPKGradientDirectionDown,

    /**
    * Gradient runs from right to left.
    */
    BPKGradientDirectionLeft,

    /**
    * Gradient runs from left to right.
    */
    BPKGradientDirectionRight,

    /**
    * Gradient runs from bottom-right to top-left.
    */
    BPKGradientDirectionTopLeft,

    /**
    * Gradient runs from bottom-left to top-right.
    */
    BPKGradientDirectionTopRight,

    /**
     * Gradient runs from top-right to bottom-left.
     */
    BPKGradientDirectionBottomLeft,

    /**
    * Gradient runs from top-left to bottom-right.
    */
    BPKGradientDirectionBottomRight,
};

NS_ASSUME_NONNULL_BEGIN
@class UIColor;

/**
 * The `BPKGradient` class contains definitions for the Backpack gradients.
 * It has factory methods for creating instances of supported gradients.
 * Instances of BPKGradient capture the configuration of the gradient, but
 * are not concerned with rendering.
 * @warning Don't render Backpack gradients with `CAGradientLayer`
 * as it does not accurately render gradients for non-square views.
 */
@interface BPKGradient: NSObject

/**
 * The colors that define the gradient.
 */
@property (copy, nonatomic, readonly) NSArray<UIColor *> *colors;

/**
 * The position of the stops that define the gradient.
 * The number of stops will always match the number of colors for a given gradient.
 * For stop `n`, the color at index `n` is used.
 * 
 * @note The values used for the stops are `CGPoints` encoded as `NSValues` using `valueWithPoint`.
 * You can get the values back using `stops[0].GCPointValue`.
 * 
 * @see colors
 */
@property (nonatomic, readonly) NSArray<NSValue *> *stops;

- (instancetype)init __attribute__((unavailable("init not available, use factory methods")));
+ (instancetype)new __attribute__((unavailable("new not available, use factory methods")));

/**
 * The Skyscanner primary gradient with the default direction.
 * 
 * @return The Skyscanner primary gradient.
 */
+ (instancetype)primary;

/**
 * The Skyscanner primary gradient with the direction specified.
 * 
 * @param direction The desired direction.
 * @return The Skyscanner primary gradient.
 */
+ (instancetype)primaryWithDirection:(BPKGradientDirection)direction;

@end
NS_ASSUME_NONNULL_END
