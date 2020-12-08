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
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
 * Instead use `BPKGradientView` which is backed by `BPKGradientLayer`.
 *
 * @see BPKGradientView
 */
@interface BPKGradient : NSObject

/**
 * The colors that define the gradient.
 */
@property(copy, nonatomic, readonly) NSArray<UIColor *> *colors;

/**
 * The position of the stops defined as a number between 0 to 1 along the line
 * created between the `startPoint` and `endPoint`.
 *
 * The number of stops will always match the number of colors for a given gradient.
 * For stop `n`, the color at index `n` is used.
 *
 * @see colors
 * @see startPoint
 * @see endPoint
 */
@property(nonatomic, readonly) NSArray<NSNumber *> *stops;

/**
 * The start point of the gradient in a (0, 1) range for x and y.
 */
@property(nonatomic, readonly) CGPoint startPoint;

/**
 * The end point of the gradient in a (0, 1) range for x and y.
 */
@property(nonatomic, readonly) CGPoint endPoint;

/// :nodoc:
- (instancetype)init __attribute__((unavailable("init not available, use factory methods")));

/// :nodoc:
+ (instancetype)new __attribute__((unavailable("new not available, use factory methods")));

/**
 * Create a custom `BPKGradient` with specific `colors`, `stops`, `startPoint` and `endPoint`.
 * The factory methods for defined Backpack gradients are preferred, but this init can
 * be used for cases when they are not suitable.
 *
 * @param colors The colors to use in the gradient.
 * @param stops The locations to draw the corresponding color at,
 *              must have the same length as `colors`.
 * @param startPoint The start point of the gradient.
 * @param endPoint The end point of the gradient.
 */
- (instancetype)initWithColors:(NSArray<UIColor *> *)colors
                         stops:(NSArray<NSNumber *> *)stops
                    startPoint:(CGPoint)startPoint
                      endPoint:(CGPoint)endPoint NS_DESIGNATED_INITIALIZER;

/**
 * Create a custom `BPKGradient` with specific `colors`, `startPoint` and `endPoint`.
 * The factory methods for defined Backpack gradients are preferred, but this init can
 * be used for cases when they are not suitable. The `stops` are set to be evenly spaced
 * along the line formed by the `startPoint` and `endPoint`.
 *
 * @param colors The colors to use in the gradient.
 * @param startPoint The start point of the gradient.
 * @param endPoint The end point of the gradient.
 */
- (instancetype)initWithColors:(NSArray<UIColor *> *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 * Create a new instance of the receiver with the same colors, but a new direction.
 *
 * @param newDirection The direction of the new instance.
 */
- (instancetype)cloneWithNewDirection:(BPKGradientDirection)newDirection;

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
+ (instancetype)primaryWithDirection:(BPKGradientDirection)direction NS_SWIFT_NAME(primary(direction:));

/**
 * The Skyscanner baseline scrim gradient for use on images that contain text.
 *
 * The default direction is `BPKGradientDirectionUp` which is appropriate when the text
 * content is at the bottom.
 * @return The default Skyscanner baseline scrim.
 */
+ (instancetype)baselineScrim;

/**
 * The Skyscanner baseline scrim gradient for use on images that contain text.
 *
 * @param direction The desired direction. The text should be positioned near the
 * start of the gradient.
 * @return The default Skyscanner baseline scrim.
 */
+ (instancetype)baselineScrimWithDirection:(BPKGradientDirection)direction NS_SWIFT_NAME(baselineScrim(direction:));

/**
 * Calculate the start point for a given direction in the 0.0 to 1.0 inclusive range.
 *
 * @param direction A gradient direction
 * @return Start point for the given direction as a `CGPoint` with values in the inclusive range 0.0 to 1.0.
 */
+ (CGPoint)startPointForDirection:(BPKGradientDirection)direction NS_SWIFT_NAME(startPoint(for:));

/**
 * Calculate the end point for a given direction in the 0.0 to 1.0 inclusive range.
 *
 * @param direction A gradient direction
 * @return End point for the given direction as a `CGPoint` with values in the inclusive range 0.0 to 1.0.
 */
+ (CGPoint)endPointForDirection:(BPKGradientDirection)direction NS_SWIFT_NAME(endPointFor(for:));
@end
NS_ASSUME_NONNULL_END
