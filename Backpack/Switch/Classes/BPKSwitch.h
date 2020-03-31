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

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKSwitch` is a subclass of `UISwitch` configured with Skyscanner style properties.
 */
IB_DESIGNABLE @interface BPKSwitch : UISwitch

/**
 * Creates a `BPKSwitch` with a decoder (typically when creating from storyboards)
 *
 * @param coder Decoder object to extract parameters from
 * @return `BPKSwitch` instance.
 */
- (instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKSwitch` with a given frame.
 *
 * @param frame The initial frame of the switch.
 * @return `BPKSwitch` instance.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 * The primary color of the reciever. This is used to control the
 * `onTintColor`.
 *
 * @warning This is not intended to be used directly, it exists to support theming only.
 */
@property(nullable, nonatomic, strong) UIColor *primaryColor UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
