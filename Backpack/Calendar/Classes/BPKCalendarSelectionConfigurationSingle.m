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

#import "BPKCalendarSelectionConfigurationSingle.h"

@implementation BPKCalendarSelectionConfigurationSingle

- (instancetype)initWithSelectionHint:(NSString *)selectionHint {
    self = [super initWithSelectionStyle:BPKCalendarSelectionStyleSingle];

    if (self) {
        _selectionHint = selectionHint;
    }

    return self;
}

- (BOOL)shouldClearSelectedDates:(NSArray<NSDate *> *)selectedDates whenSelectingDate:(NSDate *)date {
    return YES;
}

- (NSString *_Nullable)accessibilityHintForDate:(NSDate *)date selectedDates:(NSArray<NSDate *> *)selectedDates {
    for (NSDate *selectedDate in selectedDates) {
        if ([date isEqual:selectedDate]) {
            return nil;
        }
    }

    return self.selectionHint;
}

@end
