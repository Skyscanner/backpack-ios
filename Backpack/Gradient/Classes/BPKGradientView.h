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
@class BPKGradient;

/**
 * This class is a `UIView` subclass for correctly drawing non-square gradients.
 * It's backed by a layer that does the actual drawing, but using this view directly
 * is preferred.
 *
 * Changing the bounds or updating the gradient property causes this view to redraw
 * on the next display pass.
 */
IB_DESIGNABLE NS_SWIFT_NAME(GradientView) @interface BPKGradientView : UIView

/**
 * The gradient currently being drawn. Setting this will cause the view to redraw
 * with the new gradient.
 */
@property(nullable, nonatomic, strong) BPKGradient *gradient;

/// :nodoc:
- (instancetype)init __attribute__((unavailable("init not available, use initWithGradient")));

/// :nodoc:
+ (instancetype)new __attribute__((unavailable("new not available, use initWithGradient:")));

/**
 * Create a gradient view with the specified `BPKGradient`.
 *
 * @param gradient The gradient to use for drawing the view.
 */
- (instancetype)initWithGradient:(BPKGradient *)gradient;
@end
NS_ASSUME_NONNULL_END
