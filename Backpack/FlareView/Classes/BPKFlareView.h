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

#import "BPKFlarePosition.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A `BPKFlareView` is a subclass of UIView
 */
IB_DESIGNABLE @interface BPKFlareView : UIView

/**
 * Determines where the flare pointer will be displayed. By default it will point downwards at the bottom of the
 * FlareView.
 */
@property(nonatomic) BPKFlarePosition flarePosition;

/**
 * A view that can be used to show content in the background.
 * Note that some of this content may be clipped by the flare shape.
 */
@property(nonatomic) UIView *backgroundView;

/**
 * A view that can be used to show content in front of the background.
 * The content view will never be clipped by the flare shape.
 */
@property(nonatomic) UIView *contentView;

/**
 * The corner radius to apply to the corners of the view.
 * This does not affect the share of the flare itself.
 */
@property(nonatomic) CGFloat cornerRadius;

/// :nodoc:
@property(readonly, nonatomic) CGFloat flareHeight;

/**
 * Creates a `BPKFlareView` with a decoder (typically when creating from Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKFlareView` instance.
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKFlareView` with a given frame.
 *
 * @param frame The initial frame of the flareView.
 * @return `BPKFlareView` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end
NS_ASSUME_NONNULL_END
