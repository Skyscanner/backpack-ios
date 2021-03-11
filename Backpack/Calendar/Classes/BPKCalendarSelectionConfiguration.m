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

#import "BPKCalendarSelectionConfiguration.h"

@implementation BPKCalendarSelectionConfiguration

- (instancetype)initWithSelectionStyle:(BPKCalendarSelectionStyle)selectionStyle {
    self = [super init];

    if (self) {
        _selectionStyle = selectionStyle;
    }

    return self;
}

- (BOOL)shouldClearSelectedDates:(NSArray<NSDate *> *)selectedDates whenSelectingDate:(NSDate *)date {
    NSAssert(false, @"BPKCalendarSelectionConfiguration shouldClearSelectedDates: should be overridden. The base class method should never be called.");
    return NO;
}

- (BOOL)isRangeStyleSelection {
    return self.selectionStyle == BPKCalendarSelectionStyleRange;
}

- (BOOL)allowsMultipleSelection {
    return self.selectionStyle == BPKCalendarSelectionStyleRange || self.selectionStyle == BPKCalendarSelectionStyleMultiple;
}

@end
