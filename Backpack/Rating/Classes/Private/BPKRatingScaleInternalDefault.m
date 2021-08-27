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

#import "BPKRatingScaleInternalDefault.h"

const double BPK_RATING_THRESHOLD_MEDIUM = 0.6;
const double BPK_RATING_THRESHOLD_HIGH = 0.8;


@interface BPKRatingScaleInternalDefault()
@property(nonatomic, assign) double minValue;
@property(nonatomic, assign) double maxValue;
@end


@implementation BPKRatingScaleInternalDefault

- (instancetype)initWithMinValue:(double)minValue maxValue:(double)maxValue {
    self = [super init];

    if (self) {
        self.minValue = minValue;
        self.maxValue = maxValue;
    }

    return self;
}

+ (instancetype)make0to5scale {
    return [[BPKRatingScaleInternalDefault alloc] initWithMinValue:0.0 maxValue:5.0];
}

+ (instancetype)make0to10scale {
    return [[BPKRatingScaleInternalDefault alloc] initWithMinValue:0.0 maxValue:10.0];
}

// MARK: BPKRatingScaleInternal

- (BPKRatingRange)rangeFor:(double)value {
    double mediumThreshold = self.maxValue * BPK_RATING_THRESHOLD_MEDIUM;
    double highThreshold = self.maxValue * BPK_RATING_THRESHOLD_HIGH;

    if (value >= highThreshold) {
        return BPKRatingRangeHigh;
    } else if (value >= mediumThreshold) {
        return BPKRatingRangeMedium;
    } else {
        return BPKRatingRangeLow;
    }
}

- (double)clampRating:(double)value {
    return MAX(MIN(value, self.maxValue), self.minValue);
}

- (BOOL)isExtreme:(double)value {
    double clamped = [self clampRating:value];

    return fabs(self.maxValue - clamped) < 0.01 || fabs(self.minValue - clamped) < 0.01;
}

@end
