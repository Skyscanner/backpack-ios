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

#import "BPKTappableLinkLabelDelegate.h"
#import <Backpack/Font.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKTappableLinkLabel` is a subclass of `UIView` which uses the Skyscanner style for labels containing tappable text.
 */
@class BPKFontMapping;
NS_SWIFT_NAME(TappableLinkLabel) IB_DESIGNABLE @interface BPKTappableLinkLabel : UIView

@property(nonatomic, strong) UIColor *linkColor UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic, strong) BPKFontMapping *fontMapping UI_APPEARANCE_SELECTOR;

@property(nonatomic, readwrite) BPKFontStyle fontStyle;
@property(nonatomic, copy, nullable) NSString *text;
@property(nonatomic, readonly) CGSize size;

@property(nonatomic, weak) id<BPKTappableLinkLabelDelegate> delegate;

/**
 * Create a `BPKTappableLinkLabel` with a specific BPKFont style.
 *
 * @param style Font style to be used by the label.
 * @see BPKFontStyle
 */
- (instancetype)initWithFontStyle:(BPKFontStyle)style NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKTappableLinkLabel` with a decoder (typically when creating from Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKTappableLinkLabel` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKTappableLinkLabel` with a given frame.
 *
 * @param frame The initial frame of the button.
 * @return `BPKTappableLinkLabel` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 * Add a tappable section to the label.
 *
 * @param url The URL to open when the link is tapped.
 * @param range The range of characters in the TappableLinkLabel to apply the link to.
 */
- (instancetype)addLinkToURL:(NSURL *)url withRange:(NSRange)range;

@end
NS_ASSUME_NONNULL_END
