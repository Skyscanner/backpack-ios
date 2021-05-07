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

#import "BPKCardAccessibilityConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKCardAccessibilityConfigurationLink` will present the card to assistive technology as a link.
 * Should only be used when pressing the card opens a webpage.
 * This is not suitable for cards containing long, complex copy.
 */
@interface BPKCardAccessibilityConfigurationLink : BPKCardAccessibilityConfiguration

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

/// :nodoc:
- (instancetype)initWithAccessibilityLabel:(NSString *)accessibilityLabel isAccessibilityElememnt:(BOOL)isAccessibilityElement accessibilityTraits:(UIAccessibilityTraits)accessibilityTraits NS_UNAVAILABLE;

/**
 * Create a `BPKCardAccessibilityConfigurationLink` with the provided accessibilityLabel
 *
 * @param accessibilityLabel The label describing the control. Default is nil.
 */
- (instancetype)initWithAccessibilityLabel:(NSString *)accessibilityLabel;

@end

NS_ASSUME_NONNULL_END
