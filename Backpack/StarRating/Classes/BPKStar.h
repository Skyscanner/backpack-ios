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

#import <UIKit/UIKit.h>

/**
 * Enum values for specifying star state
 */
typedef NS_ENUM(NSInteger, BPKStarState) {
    BPKStarStateDefault,
    BPKStarStateHalf,
    BPKStarStateFull
};

/**
 * Enum values for specifying star size
 */
typedef NS_ENUM(NSUInteger, BPKStarSize) {
    BPKStarSizeSmall,
    BPKStarSizeLarge
};

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Star) @interface BPKStar : UIView

/**
 * State of the star, its default value is BPKStarStateDefault. Setting updates
 * the displayed star.
 * BPKStarStateDefault will render a star filled with starColor
 * BPKStarStateHalf will render a star filled with half starFilledColor and half starColor
 * BPKStarStateFull will render a star filled with starFilledColor
 *
 * @see BPKStarState
 */
@property (nonatomic) BPKStarState state;

/**
 * Size of the star, its default value is BPKStarSizeSmall. Setting updates
 * the displayed star.
 *
 * @see BPKStarSize
 */
@property(nonatomic) BPKStarSize size;

/**
 * Color of the star when it's filled, its default value is BPKColor.yellow500. Setting updates
 * the displayed star.
 */
@property (nullable, nonatomic, strong) UIColor* starFilledColor UI_APPEARANCE_SELECTOR;

/**
 * Creates a `BPKStar` with a given star size, CGRectZero frame and BPKStarStateDefault state.
 *
 * @param size of the stars being displayed on this view
 * @return `BPKStar` instance.
 *
 * @see BPKStarSize
 */
- (instancetype)initWithSize:(BPKStarSize)size NS_DESIGNATED_INITIALIZER;

/**
 * Creates a `BPKStar` with a decoder (typically when creating from Storyboards), BPKStarSizeSmall star size and BPKStarStateDefault state.
 *
 * @param aDecoder Decoder object to extract parameters from
 * @return `BPKStar` instance.
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKStar` with a given frame, BPKStarSizeSmall star size and BPKStarStateDefault state.
 *
 * @param frame The initial frame of the star.
 * @return `BPKStar` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
