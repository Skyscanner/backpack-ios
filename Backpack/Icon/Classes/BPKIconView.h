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
#import <UIKit/UIKit.h>

#import "BPKIcon.h"
#import "BPKIconNames.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A `UIImageView` subclass that makes working with Backpack icons easier for cases
 * where a single icon is used and colour is controlled via `tintColor`. The icon is
 * always rendered using template rendering.
 */
@interface BPKIconView : UIImageView

/**
 * Initializes and returns a Backpack Icon View with the specific icon name and size.
 *
 * @param iconName The name of the Backpack icon to display in the view.
 * @param size The size the icon should be displayed at.
 * @return An initialized Backpack icon view
 */
- (instancetype)initWithIconName:(nullable BPKIconName)iconName size:(BPKIconSize)size;

/**
 * The name of the icon currently being displayed. Setting updates
 * the displayed icon.
 */
@property(nullable, nonatomic, copy) BPKIconName iconName;

/**
 * The size of the icon currently being displayed. Setting updates
 * the displayed icon.
 * @see BPKIconSize
 */
@property(nonatomic, assign) BPKIconSize size;

/**
 * If flipsForRightToLeft is set to YES then BPKIconView will render its icon
 * horizontally flipped when its UIUserInterfaceLayoutDirection is right to left.
 * Default value is NO.
 */
@property(nonatomic, assign) BOOL flipsForRightToLeft;

/// :nodoc:
- (instancetype)initWithImage:(nullable UIImage *)image __attribute__((unavailable("use `initWithIconName:size:` instead")));

/// :nodoc:
- (instancetype)initWithImage:(nullable UIImage *)image
             highlightedImage:(nullable UIImage *)highlightedImage
    __attribute__((unavailable("use a `UIImageView` and `BPKIcon`s `iconNamed:color:size:` instead.")));

/// :nodoc:
- (void)setImage:(nullable UIImage *)image
    __attribute__((unavailable("use `iconName` instead. If you need to set arbitrary images use `UIImageView`")));

@end

NS_ASSUME_NONNULL_END
