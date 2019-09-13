/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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
 * `BPKRatingBubble` is a subclass of `UIView` configured with Skyscanner style properties.
 */
NS_SWIFT_NAME(RatingBubble) IB_DESIGNABLE @interface BPKRatingBubble : UIView

/**
 * The rating value
 */
@property(nonatomic) double ratingValue;

/**
 * Creates a `BPKRatingBubble` with a decoder (typically when creating from Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKRatingBubble` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKRatingBubble` with a given frame.
 *
 * @param frame The initial frame of the ratingBubble.
 * @return `BPKRatingBubble` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@property(nonatomic, strong) UIColor *lowRatingColor;
@property(nonatomic, strong) UIColor *mediumRatingColor;
@property(nonatomic, strong) UIColor *highRatingColor;

@end

NS_ASSUME_NONNULL_END
