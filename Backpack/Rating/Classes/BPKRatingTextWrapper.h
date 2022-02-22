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
#import <UIKit/UIKit.h>

#import "BPKRatingLayout.h"
#import "BPKRatingSize.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKRatingTextWrapper` is a subclass of `UIView` configured with Skyscanner style properties.
 */
IB_DESIGNABLE @interface BPKRatingTextWrapper : UIView

/**
 * The title to display inside the ratingTextWrapper.
 */
@property(nonatomic, copy) NSString *title;

/**
 * The subtitle to display inside the ratingTextWrapper.
 */
@property(nonatomic, copy, nullable) NSString *subtitle;

/**
 * Size of the rating
 *
 * @see BPKRatingSize
 */
@property(nonatomic) BPKRatingSize size;

/**
 * Layout of the rating
 *
 * @see BPKRatingLayout
 */
@property(nonatomic) BPKRatingLayout layout;

/**
 * Creates a `BPKRatingTextWrapper` with a decoder (typically when creating from Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKRatingTextWrapper` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKRatingTextWrapper` with a given frame.
 *
 * @param frame The initial frame of the ratingTextWrapper.
 * @return `BPKRatingTextWrapper` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
