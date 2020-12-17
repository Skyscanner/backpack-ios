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

#import "BPKOverlayBackgroundView.h"
#import "BPKOverlayViewCornerStyles.h"
#import "BPKOverlayViewOverlayTypes.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKOverlayView` is a subclass of `UIView` which allows you to apply Skyscanner style tints to background content.
 */
IB_DESIGNABLE @interface BPKOverlayView : UIView

/**
 * The corner-style to apply to the card. Default is None.
 */
@property(nonatomic, assign) IBInspectable BPKOverlayViewCornerStyle cornerStyle;

/**
 * The kind of overlay to apply to the view. Default is Tint.
 */
@property(nonatomic, assign) IBInspectable BPKOverlayViewOverlayType overlayType;

/**
 * The view to display in front of the tint.
 */
@property(nonatomic, strong, readonly) UIView *foregroundView;

/**
 * The view to display behind the tint.
 */
@property(nonatomic, strong, readonly) BPKOverlayBackgroundView *backgroundView;

/**
 * Create a `BPKOverlayView` with a given frame.
 *
 * @param frame The initial frame of the card.
 * @return `BPKOverlayView` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKOverlayView` with a decoder (typically when creating from Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKOverlayView` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKOverlayView` with a corner style and overlay type.
 *
 * @param overlayType The overlay type to show in front of the background view.
 * @param cornerStyle The corner style to apply to the whole view.
 * @return `BPKOverlayView` instance.
 */
- (nullable instancetype)initWithOverlayType:(BPKOverlayViewOverlayType)overlayType
                                 cornerStyle:(BPKOverlayViewCornerStyle)cornerStyle NS_DESIGNATED_INITIALIZER;

/// :nodoc:
- (void)addSubview:(UIView *)view
    __attribute__((unavailable("`addSubview` cannot be used on BPKOverlayView. Use the `backgroundView` and "
                               "`foregroundView` properties to set content instead")));

@end

NS_ASSUME_NONNULL_END
