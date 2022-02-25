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

@implementation BPKCardConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        _accessibilityLabel = nil;
        _isAccessibilityElement = NO;
        _accessibilityTraits = UIAccessibilityTraitNone;
    }
    return self;
}

- (instancetype)initWithAccessibilityLabel:(NSString *)accessibilityLabel
                    isAccessibilityElement:(BOOL)isAccessibilityElement
                       accessibilityTraits:(UIAccessibilityTraits)accessibilityTraits {
    self = [super init];

    if (self) {
        _accessibilityLabel = [accessibilityLabel copy];
        _isAccessibilityElement = isAccessibilityElement;
        _accessibilityTraits = accessibilityTraits;
    }

    return self;
}

@end

NS_ASSUME_NONNULL_END
