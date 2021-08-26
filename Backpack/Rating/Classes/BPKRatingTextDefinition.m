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

#import "BPKRatingTextDefinition.h"

NS_ASSUME_NONNULL_BEGIN
@implementation BPKRatingTextDefinition

- (instancetype)initWithHighRatingText:(NSString *)highRatingText
                      mediumRatingText:(NSString *)mediumRatingText
                         lowRatingText:(NSString *)lowRatingText {
    self = [super init];

    if (self) {
        self.highRatingText = highRatingText;
        self.mediumRatingText = mediumRatingText;
        self.lowRatingText = lowRatingText;
    }

    return self;
}

- (NSString *)textFor:(BPKRatingRange)range {
    switch (range) {
        case BPKRatingRangeLow:
            return self.lowRatingText;
        case BPKRatingRangeMedium:
            return self.mediumRatingText;
        case BPKRatingRangeHigh:
            return self.highRatingText;
        default:
            NSAssert(NO, @"[BPKRatingTextDefinition textFor:] doesn't handle all ranges");

            return self.mediumRatingText;
    }
}

@end
NS_ASSUME_NONNULL_END
