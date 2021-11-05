/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import <Backpack/Icon.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Enum values for specifying chip style
 */
typedef NS_ENUM(NSUInteger, BPKChipStyle) {
    /**
     * Chip style with solid color background.
     */
    BPKChipStyleFilled = 0,

    /**
     * Chip style with 1pt outline and clear color background.
     */
    BPKChipStyleOutline = 1,
};

/**
 * `BPKChip` is a subclass of `UIControl` configured with Skyscanner style properties.
 */
IB_DESIGNABLE @interface BPKChip : UIControl

/**
 * The title to display inside the chip.
 */
@property(nonatomic, copy, nullable) NSString *title;

/**
 * Creates a `BPKChip` with the title given.
 *
 * @param title NSString to use as the title.
 */
- (instancetype)initWithTitle:(NSString *)title NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKChip` with a decoder (typically when creating from Storyboards)
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKChip` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKChip` with a given frame.
 *
 * @param frame The initial frame of the chip.
 * @return `BPKChip` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 * The primary color of the reciever. This is used to control the
 * selected background colour.
 *
 * @warning This is not intended to be used directly, it exists to support theming only.
 */
@property(nullable, nonatomic, strong) UIColor *primaryColor UI_APPEARANCE_SELECTOR;

/**
 * An optional custom background.
 */
@property(nullable, nonatomic) UIColor *backgroundTint;

/**
 * An optional icon
 */
@property(nullable, nonatomic, copy) BPKLargeIconName iconName;

/**
 * Style of the chip. Default is BPKChipStyleOutline.
 */
@property(nonatomic, assign) BPKChipStyle style;

@end

NS_ASSUME_NONNULL_END
