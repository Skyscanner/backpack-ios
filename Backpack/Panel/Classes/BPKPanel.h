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

/**
 * Enum values for specifying panel style
 */
typedef NS_ENUM(NSUInteger, BPKPanelStyle) {
    BPKPanelStyleDefault = 0,
    BPKPanelStyleElevated = 1,
};

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKPanel` is a subclass of `UIView` which contains the Skyscanner panel style.
 * Panels are a lightweight container with a subtle shadow.
 * Panels can be configured to have padding or not.
 */
IB_DESIGNABLE @interface BPKPanel : UIView

/**
 * Whether the panel should provide padding or not.
 */
@property(nonatomic, assign, getter=isPadded) IBInspectable BOOL padded;

/**
 * The style of the panel to use.
 * @see BPKButtonStyle
 */
@property(nonatomic) BPKPanelStyle style;

/**
 * Create a `BPKPanel` with padded initially set.
 *
 * @param padded Whether the panel should have padding or not.
 */
- (instancetype)initWithPadded:(BOOL)padded NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKPanel` with a given frame.
 *
 * @param frame The initial frame of the card.
 * @return `BPKPanel` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKPanel` with a decoder (typically when creating from Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKPanel` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

- (instancetype)new NS_UNAVAILABLE;
@end
NS_ASSUME_NONNULL_END
