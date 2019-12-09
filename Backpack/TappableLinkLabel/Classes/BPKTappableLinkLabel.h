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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Backpack/Font.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * These constants represent the different styles available for BPKTappableLinkLabels
 */
typedef NS_SWIFT_NAME(TappableLinkLabelStyle) NS_ENUM(NSUInteger, BPKTappableLinkLabelStyle){

    /**
     * Blue links within dark-gray labels
     */
    BPKTappableLinkLabelStyleDefault,

    /**
     * White bold links within white labels. Suitable only for use on solid blue or dark backgrounds
     */
    BPKTappableLinkLabelStyleAlternate,
};

/**
 * `BPKTappableLinkLabel` is a subclass of `UIView` which uses the Skyscanner style for labels containing tappable text.
 */
NS_SWIFT_NAME(TappableLinkLabel) IB_DESIGNABLE @interface BPKTappableLinkLabel : UIView

@property(nullable, nonatomic, strong) UIColor *linkColor UI_APPEARANCE_SELECTOR;

/**
 * this determines the number of lines to draw and what to do when sizeToFit is called. default value is 1 (single
 * line). A value of 0 means no limit if the height of the text reaches the # of lines or the height of the view is less
 * than the # of lines allowed, the text will be truncated using the line break mode.
 */
@property(nonatomic) NSInteger numberOfLines;

/**
 * The technique to use for aligning the text.
 * Default is NSLineBreakByTruncatingTail used for single and multiple lines of text
 */
@property(nonatomic) NSTextAlignment textAlignment;

/**
 * The technique to use for wrapping and truncating the label’s text.
 * Default is NSLineBreakByTruncatingTail used for single and multiple lines of text.
 */
@property(nonatomic) NSLineBreakMode lineBreakMode;

/**
 * The font style used to display the text.
 * @see BPKFontStyle
 */
@property(nonatomic, readwrite) BPKFontStyle fontStyle;

/**
 * The style of tappable label to use
 * @see BPKTappableLabelStyle
 */
@property(nonatomic, readwrite) BPKTappableLinkLabelStyle style;

/**
 * The text displayed by the receiver. Setting this clears all configured tappable links.
 */
@property(nonatomic, copy, nullable) NSString *text;

/**
 * The size required to draw the the view with the current configuration.
 *
 * This method may return fractional sizes. When setting the size of your view,
 * use the [ceil](https://developer.apple.com/documentation/kernel/1557272-ceil?language=objc) function to fractional
 * values up to the nearest whole number.
 *
 * This methods delegates to
 * [size](https://developer.apple.com/documentation/foundation/nsattributedstring?language=objc) method of
 * `NSattributedString`.
 */
@property(nonatomic, readonly) CGSize size;

/**
 * The receiver's delegate. Used to communicate interactions with the receiver.
 */
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

/**
 * Add a tappable section to the label.
 *
 * @param components The Transit Information used to signify the event when the link is tapped.
 * @param range The range of characters in the TappableLinkLabel to apply the link to.
 */
- (instancetype)addLinkToTransitInformation:(NSDictionary *)components withRange:(NSRange)range;

@end
NS_ASSUME_NONNULL_END
