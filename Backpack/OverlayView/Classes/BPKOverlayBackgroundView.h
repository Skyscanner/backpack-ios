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

#import "BPKOverlayViewOverlayTypes.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKOverlayBackgroundView` is a subclass of `UIView` which allows you to apply Skyscanner style tints to its content.
 */
IB_DESIGNABLE @interface BPKOverlayBackgroundView : UIView

/**
 * The kind of overlay to apply to the view. Default is Tint.
 */
@property(nonatomic, assign) IBInspectable BPKOverlayViewOverlayType overlayType;

/**
 * Create a `BPKOverlayBackgroundView` with a given frame.
 *
 * @param frame The initial frame of the card.
 * @return `BPKOverlayBackgroundView` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKOverlayBackgroundView` with a decoder (typically when creating from Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKOverlayBackgroundView` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKOverlayBackgroundView` with a corner style and overlay type.
 *
 * @param overlayType The overlay type to show in front of the background view.
 * @return `BPKOverlayBackgroundView` instance.
 */
- (nullable instancetype)initWithOverlayType:(BPKOverlayViewOverlayType)overlayType NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
