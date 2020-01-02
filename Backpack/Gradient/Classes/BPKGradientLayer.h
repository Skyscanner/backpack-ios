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

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN
@class BPKGradient;

/**
 * `BPKGradientLayer` is a `CALayer` subclass that can correctly
 * render Backpack gradients for non-square views. It should be
 * preferred in favour of `CAGradientLayer` as it does not correctly
 * render gradients for non-square views.
 */
NS_SWIFT_NAME(GradientLayer) @interface BPKGradientLayer : CALayer
/**
 * The gradient being drawn by the layer. Changing this will cause
 * the layer to redraw with the new gradient.
 */
@property(nullable, nonatomic, strong) BPKGradient *gradient;
@end
NS_ASSUME_NONNULL_END
