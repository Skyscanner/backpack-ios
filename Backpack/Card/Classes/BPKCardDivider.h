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

#import "BPKCard.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKCardDivider` is a subclass of `UIView` which contains the Skyscanner card divider style.
 */
NS_SWIFT_NAME(CardDivider) IB_DESIGNABLE @interface BPKCardDivider : UIView

/**
 * The orientation of the card divider.
 */
@property(nonatomic, assign) IBInspectable UILayoutConstraintAxis orientation;

/**
 * Create a `BPKCardDivider` with orientation initially set.
 *
 * @param orientation Whether the divider is for a vertical or horizontal layout.
 */
- (instancetype)initWithOrientation:(UILayoutConstraintAxis)orientation NS_DESIGNATED_INITIALIZER;

/// :nodoc:
- (instancetype)initWithFrame:(CGRect)frame
    __attribute__((unavailable("CardDivider cannot be initialised with frame. Use `initWithOrientation` instead")));

/// :nodoc:
- (instancetype)init
    __attribute__((unavailable("CardDivider cannot be initialised using `init`. Use `initWithOrientation` instead")));

/// :nodoc:
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
    __attribute__((unavailable("CardDivider cannot be initialised with coder. Use `initWithOrientation` instead")));

/// :nodoc:
+ (instancetype)new
    __attribute__((unavailable("CardDivider cannot be initialised with coder. Use `initWithOrientation` instead")));

/**
 * Set the orientation for the card divider
 *
 * @param orientation The orientation to use.
 */
- (void)setOrientation:(UILayoutConstraintAxis)orientation;

@end
NS_ASSUME_NONNULL_END
