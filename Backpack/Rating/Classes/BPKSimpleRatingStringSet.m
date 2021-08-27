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

#import "BPKSimpleRatingStringSet.h"

@implementation BPKSimpleRatingStringSet

- (instancetype)initWithTitleText:(BPKRatingTextDefinition *)titleText
                     subtitleText:(nullable BPKRatingTextDefinition *)subtitleText
               accessibilityLabel:(BPKRatingAccessibilityLabel)accessibilityLabel {
    self = [super init];

    if (self) {
        self.titleText = titleText;
        self.subtitleText = subtitleText;
        self.accessibilityLabel = accessibilityLabel;
    }

    return self;
}

- (nonnull NSString *)rating:(BPKRating *)rating titleFor:(BPKRatingRange)range {
    return [self.titleText textFor:range];
}

- (nullable NSString *)rating:(BPKRating *)rating subtitleFor:(BPKRatingRange)range {
    // Relying on nil coalescing here
    return [self.subtitleText textFor:range];
}

- (nonnull NSString *)rating:(BPKRating *)rating
                      accessibilityLabelFor:(BPKRatingRange)range
                      value:(double)value {
    return self.accessibilityLabel(range, value);
}

@end
