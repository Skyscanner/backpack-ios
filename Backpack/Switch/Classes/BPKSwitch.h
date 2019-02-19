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

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKSwitch` is a subclass of `UISwitch` configured with Skyscanner style properties.
 */
NS_SWIFT_NAME(Switch) IB_DESIGNABLE @interface BPKSwitch : UISwitch

+ (UIColor *) defaultOnTintColor;

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

@end

NS_ASSUME_NONNULL_END
