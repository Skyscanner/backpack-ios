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

#import "BPKStar.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A component for displaying a star rating for example for reviews.
 *
 * The component uses a scale of 0 to 5 stars. It supports half stars and will round down to the nearest
 * half star for display. When using the stars to show an average of many ratings
 * it's advisable to display a text string adjecent to the star rating with the exact
 * rating value.
 */
IB_DESIGNABLE @interface BPKStarRating : UIView

/**
 * Rating value the star rating view will displaying by rounding the value to full and half stars between 0.0 and 5.0.
 * Example 1: setting 4.3 to rating will render 4.0 stars. 5 stars where the first 4 of them are filled with
 * BPKThemeDefinition.starFilledColor and the last star is not filled.
 * Example 2: setting 4.6 to rating will render 4.5 stars. 5 stars where the first 4 of them are filled with
 * BPKThemeDefinition.starFilledColor and the last star is half filled with the same color.
 * Set this property to render new rating.
 * The default value is 0.0, in case of setting a value smaller than 0.0 or greater than 5.0 the view will show 0.0
 * or 5.0.
 */
@property(nonatomic) IBInspectable float rating;

/**
 * Size of the stars, its default value is BPKStarSizeSmall. Setting updates
 * the displayed stars.
 *
 * @see BPKStarSize
 */
@property(nonatomic) BPKStarSize size;

- (instancetype)initWithSize:(BPKStarSize)size NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKStarRating` with a decoder (typically when creating from Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKStarRating` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKStarRating` with a given frame.
 *
 * @param frame The initial frame of the star rating.
 * @return `BPKStarRating` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
