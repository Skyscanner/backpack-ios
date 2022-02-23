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
#import "BPKRatingTextDefinition.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKRating` is a subclass of `UIView` configured with Skyscanner style properties.
 */
IB_DESIGNABLE @interface BPKRating : UIView

/**
 * The title to display inside the rating.
 */
@property(nonatomic, strong) BPKRatingTextDefinition *title;

/**
 * The subtitle to display inside the rating.
 */
@property(nonatomic, strong, nullable) BPKRatingTextDefinition *subtitle;

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
 * The rating value
 */
@property(nonatomic) double ratingValue;

/**
 * Creates a `BPKRating` with a decoder (typically when creating from Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKRating` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKRating` with a given frame.
 *
 * @param frame The initial frame of the rating.
 * @return `BPKRating` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKRating` with a given rating value and title.
 *
 * @param ratingValue The value shown in the rating component
 * @param title The title of the rating
 * @param subtitle The subtitle of the rating
 * @return `BPKRating` instance.
 */
- (instancetype)initWithRatingValue:(CGFloat)ratingValue
                              title:(BPKRatingTextDefinition *)title
                           subtitle:(BPKRatingTextDefinition *_Nullable)subtitle NS_DESIGNATED_INITIALIZER;

@property(nullable, nonatomic, strong) UIColor *lowRatingColor UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic, strong) UIColor *mediumRatingColor UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic, strong) UIColor *highRatingColor UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
