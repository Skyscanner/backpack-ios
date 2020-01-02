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

/**
 * Enum values for specifying spinner size
 */
typedef NS_ENUM(NSUInteger, BPKSpinnerSize) {
    BPKSpinnerSizeDefault = 0,
    BPKSpinnerSizeSmall = 1,
};

/**
 * Enum values for specifying spinner style
 */
typedef NS_ENUM(NSUInteger, BPKSpinnerStyle) {
    BPKSpinnerStylePrimary = 0,
    BPKSpinnerStyleDark = 1,
    BPKSpinnerStyleLight = 2,
};

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKSpinner` is a subclass of `UIActivityIndicatorView` configured with Skyscanner style properties.
 */
NS_SWIFT_NAME(Spinner) IB_DESIGNABLE @interface BPKSpinner : UIActivityIndicatorView

/**
 * Style of the spinner
 * @see BPKSpinnerStyle
 */
@property(nonatomic) BPKSpinnerStyle style;

@property(nullable, nonatomic, strong) UIColor *primaryColor UI_APPEARANCE_SELECTOR;

/**
 * Size of the spinner
 * @see BPKSpinnerSize
 */
@property(nonatomic) BPKSpinnerSize size;

/**
 * Creates a `BPKSpinner` with a specific style and size.
 *
 * @param style Style to be used by the button.
 * @param size Size to be used by the button.
 * @return `BPKSpinner` instance.
 * @see BPKSpinnerSize
 */
- (instancetype)initWithStyle:(BPKSpinnerStyle)style size:(BPKSpinnerSize)size NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKSpinner` with a decoder (typically when creating from Storyboards)
 *
 * @param coder Decoder object to extract parameters from
 * @return `BPKSpinner` instance.
 */
- (instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKSpinner` with a given frame.
 *
 * @param frame The initial frame of the spinner.
 * @return `BPKSpinner` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style
    __attribute__((unavailable("use initWithStyle:size: instead")));

@end

NS_ASSUME_NONNULL_END
