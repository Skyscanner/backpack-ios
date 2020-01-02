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

#import "BPKCardCornerStyleValues.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKCard` is a subclass of `UIControl` which contains the Skyscanner card style.
 * Cards are a lightweight control with a shadow.
 * Cards can be configured to have padding or not.
 */
NS_SWIFT_NAME(Card) IB_DESIGNABLE @interface BPKCard : UIControl

/**
 * Whether the card should provide padding or not.
 */
@property(nonatomic, assign, getter=isPadded) IBInspectable BOOL padded;

/**
 * The corner-style to apply to the card.
 */
@property(nonatomic, assign) IBInspectable BPKCardCornerStyle cornerStyle;

/**
 * The view to display within the card.
 */
@property(nonatomic, assign, nullable) UIView *subview;

/**
 * Create a `BPKCard` with padded initially set.
 *
 * @param padded Whether the card should have padding or not.
 */
- (instancetype)initWithPadded:(BOOL)padded;

/**
 * Create a `BPKCard` with padded and cornerStyle initially set.
 *
 * @param padded Whether the card should have padding or not.
 * @param cornerStyle The corner style that the card should have.
 */
- (instancetype)initWithPadded:(BOOL)padded cornerStyle:(BPKCardCornerStyle)cornerStyle NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKCard` with a given frame.
 *
 * @param frame The initial frame of the card.
 * @return `BPKCard` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/// :nodoc:
- (void)addSubview:(UIView *)view __attribute__((unavailable(
                       "`addSubview` cannot be used on BPKCard. Use the `subview` property to set content instead")));

/**
 * Creates a `BPKCard` with a decoder (typically when creating from Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKCard` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
@end
NS_ASSUME_NONNULL_END
