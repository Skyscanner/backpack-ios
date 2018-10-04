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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BPKCard.h"
#import "BPKCardDivider.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKDividedCard` is a subclass of `BPKCard` which contains the Skyscanner divided card style.
 * Divided cards are a lightweight containers with a subtle shadow and two subviews.
 * Divided cards, like Cards, can be configured to have padding or not.
 */
NS_SWIFT_NAME(DividedCard) IB_DESIGNABLE @interface BPKDividedCard: BPKCard

/**
 * The orientation of the divided card.
 */
@property(nonatomic, assign) IBInspectable UILayoutConstraintAxis orientation;

/**
 * The primary subview within the divided card.
 */
@property(nonatomic, assign, nullable) UIView *primarySubview;

/**
 * The secondary subview within the divided card.
 */
@property(nonatomic, assign, nullable) UIView *secondarySubview;

/**
 * Create a `BPKDividedCard` with padded initially set.
 *
 * @param padded Whether the card should have padding or not.
 */
- (instancetype)initWithPadded:(BOOL)padded;

/**
 * Create a `BPKDividedCard` with two subviews.
 *
 * @param primarySubview The primary subview for the divided card.
 * @param secondarySubview The secondary subview for the divided card.
 * @param padded Whether the card should have padding or not.
 */
- (instancetype)initWithPrimarySubview:(UIView *_Nullable)primarySubview secondarySubview:(UIView *_Nullable)secondarySubview padded:(BOOL)padded NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKDividedCard` with a given frame.
 *
 * @param frame The initial frame of the card.
 * @return `BPKDividedCard` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKDividedCard` with a decoder (typically when creating form Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKDividedCard` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Set the subviews used in the Divided Card
 *
 * @param primarySubview The primary subview for the divided card.
 * @param secondarySubview The secondary subview for the divided card.
 */
- (void)setPrimarySubview:(UIView *)primarySubview secondarySubview:(UIView*)secondarySubview;

/**
 * Set the orientation used in the Divided Card
 *
 * @param orientation The orientation to use.
 */
- (void)setOrientation:(UILayoutConstraintAxis)orientation;

- (void) addSubview:(UIView *)view __attribute__((unavailable("To add subviews to a divided BPKCard, use `setPrimarySubview:secondarySubview:` or `initWithPrimarySubview:secondarySubview:padded:`")));

@end
NS_ASSUME_NONNULL_END
