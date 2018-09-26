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
 * Enum values for specifying button size
 */
typedef NS_ENUM(NSUInteger, BPKButtonSize) {
    BPKButtonSizeDefault = 0,
    BPKButtonSizeLarge = 1,
};

/**
 * Enum values for specifying button style
 */
typedef NS_ENUM(NSUInteger, BPKButtonStyle) {
    BPKButtonStylePrimary = 0,
    BPKButtonStyleSecondary = 1,
    BPKButtonStyleDestructive = 2,
    BPKButtonStyleFeatured = 3,
    BPKButtonStyleLink = 4,
};

/**
 * The position of the `imageView` with respect to the `titleLabel`
 * in the button.
 */
typedef NS_ENUM(NSUInteger, BPKButtonImagePosition) {
    /**
     * The image positioned on the leading side of the label.
     */
    BPKButtonImagePositionLeading = 0,

    /**
     * The image positioned on the trailing side of the label.
     */
    BPKButtonImagePositionTrailing = 1,
};

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKButton` is a subclass of `UIButton` configured with Skyscanner style properties.
 */
NS_SWIFT_NAME(Button) IB_DESIGNABLE @interface BPKButton: UIButton

- (void)setTitle:(NSString *_Nullable)title forState:(UIControlState)state __attribute__((unavailable("use setTitle: instead")));
- (void)setImage:(UIImage *_Nullable)image forState:(UIControlState)state __attribute__((unavailable("use setImage: instead")));

- (void)setTitle:(NSString *_Nullable)title;
- (void)setImage:(UIImage *_Nullable)image;
/**
 * Creates a `BPKButton` with a specific size and style.
 *
 * @param size Size to be used by the button.
 * @param style Style of the button.
 * @return `BPKButton` instance.
 * @see BPKButtonSize
 * @see BPKButtonStyle
 */
- (instancetype)initWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKButton` with a decoder (typically when creating form Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKButton` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKButton` with a given frame.
 *
 * @param frame The initial frame of the button.
 * @return `BPKButton` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;


/**
 * Size of the button
 *
 * @see BPKButtonSize
 */
@property(nonatomic) BPKButtonSize size;

/**
 * Style of the button
 *
 * @see BPKButtonStyle
 */
@property(nonatomic) BPKButtonStyle style;

/**
 * Position of the image in the button. This has
 * no effect for icon only buttons.
 *
 * @see BPKButtonImagePosition
 */
@property(nonatomic) BPKButtonImagePosition imagePosition;

@end

NS_ASSUME_NONNULL_END
