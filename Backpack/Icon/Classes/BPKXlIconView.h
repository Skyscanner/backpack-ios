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
#import <UIKit/UIKit.h>

#import "BPKIconView.h"
#import "BPKXlIconNames.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A `UIImageView` subclass that renders a Backpack extra-large icon.
 * Convenient for setting the icon `tintColor` as the icon is
 * always rendered using template rendering.
 */
@interface BPKXlIconView : BPKIconView

/**
 * Initializes and returns a extra-large Backpack Icon View with the specific icon name.
 *
 * @param iconName The name of the extra-large Backpack icon to display in the view.
 * @return An initialized Backpack icon view
 */
- (instancetype)initWithIconName:(nullable BPKXlIconName)iconName;

@end

NS_ASSUME_NONNULL_END
