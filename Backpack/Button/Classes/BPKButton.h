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
#import <Backpack/BPKFont.h>

typedef NS_ENUM(NSUInteger, BPKButtonSize) {
    BPKButtonSizeDefault = 0,
    BPKButtonSizeLarge = 1,
};

typedef NS_ENUM(NSUInteger, BPKButtonStyle) {
    BPKButtonStylePrimary = 0,
    BPKButtonStyleSecondary = 1,
    BPKButtonStyleDestructive = 2,
    BPKButtonStyleFeatured = 3,
};

typedef NS_ENUM(NSUInteger, BPKButtonImagePosition) {
    BPKButtonImagePositionRight = 0,
    BPKButtonImagePositionLeft = 1,
};

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKButton` is a subclass of `UIButton` configured with Skyscanner style properties.
 */
IB_DESIGNABLE @interface BPKButton: UIButton

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame: is not available, use initWithSize:style:")));
- (instancetype)init __attribute__((unavailable("init not available, use initWithSize:style:")));
+ (instancetype)new __attribute__((unavailable("new not available, use alloc + initWithSize:style:")));

/**
 * Create a `BPKButton` with a specific size and style.
 * 
 * @param size Size to be used by the button.
 * @param style Style of the button.
 */
- (instancetype)initWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style NS_DESIGNATED_INITIALIZER;


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

IBInspectable @property(nonatomic) BPKButtonSize size;
IBInspectable @property(nonatomic) BPKButtonStyle stlye;
IBInspectable @property(nonatomic) BPKButtonImagePosition imagePosition;
@end
NS_ASSUME_NONNULL_END
