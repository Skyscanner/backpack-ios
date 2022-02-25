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

#import "BPKCardConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKCardConfigurationButton` will present the card to assistive technology as a button.
 * Should only be used if the card has one behaviour when pressed.
 * This is not suitable for cards containing long, complex copy.
 */
@interface BPKCardConfigurationButton : BPKCardConfiguration

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

/// :nodoc:
- (instancetype)initWithAccessibilityLabel:(NSString *)accessibilityLabel
                    isAccessibilityElement:(BOOL)isAccessibilityElement
                       accessibilityTraits:(UIAccessibilityTraits)accessibilityTraits NS_UNAVAILABLE;

/**
 * Create a `BPKCardConfigurationButton` with the provided accessibilityLabel
 *
 * @param accessibilityLabel The label describing the control.
 */
- (instancetype)initWithAccessibilityLabel:(NSString *)accessibilityLabel;

@end

NS_ASSUME_NONNULL_END
