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

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKCardAccessibilityConfiguration` is a subclass of `NSObject` with properties to determine how assistive technology should interact with a BPKCard.
 */
@interface BPKCardAccessibilityConfiguration : NSObject

/**
 * The label describing the control. Default is nil.
 */
@property(nonatomic, strong, readonly) NSString *accessibilityLabel;

/**
 * Whether the control should be an accessibilityElement. Default is NO.
 */
@property(nonatomic, readonly) BOOL isAccessibilityElement;

/**
 * The accessibilityTraits to apply. Default is UIAccessibilityTraitNone.
 */
@property(nonatomic, readonly) UIAccessibilityTraits accessibilityTraits;

/**
 * Create a `BPKCardAccessiibilityConfiguration` with the provided properties.
 *
 * @param accessibilityLabel The label describing the control. Default is nil.
 * @param isAccessibilityElement Whether the control should be an accessibilityElement. Default is NO.
 * @param accessibilityTraits The accessibilityTraits to apply. Default is UIAccessibilityTraitNone.
 */
- (instancetype)initWithAccessibilityLabel:(NSString *)accessibilityLabel isAccessibilityElememnt:(BOOL)isAccessibilityElement accessibilityTraits:(UIAccessibilityTraits)accessibilityTraits;

@end

NS_ASSUME_NONNULL_END
