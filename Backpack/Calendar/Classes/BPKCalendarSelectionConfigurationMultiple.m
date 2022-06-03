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

#import "BPKCalendarSelectionConfigurationMultiple.h"

@implementation BPKCalendarSelectionConfigurationMultiple

- (instancetype)initWithSelectionHint:(NSString *)selectionHint deselectionHint:(NSString *)deselectionHint {
    return [self initWithSelectionHint:selectionHint deselectionHint:deselectionHint andWholeMonthTitle:nil];
}

- (instancetype)initWithSelectionHint:(NSString *)selectionHint
                      deselectionHint:(NSString *)deselectionHint
                   andWholeMonthTitle:(NSString *_Nullable) wholeMonthTitle {
    self = [super initWithSelectionStyle:BPKCalendarSelectionStyleMultiple
                      andWholeMonthTitle:wholeMonthTitle];

    if (self) {
        _selectionHint = [selectionHint copy];
        _deselectionHint = [deselectionHint copy];
    }

    return self;
}

- (BOOL)shouldClearSelectedDates:(NSArray<NSDate *> *)selectedDates whenSelectingDate:(NSDate *)date {
    return NO;
}

- (NSString *_Nullable)accessibilityHintForDate:(NSDate *)date selectedDates:(NSArray<NSDate *> *)selectedDates {
    for (NSDate *selectedDate in selectedDates) {
        if ([date isEqual:selectedDate]) {
            return self.deselectionHint;
        }
    }

    return self.selectionHint;
}

@end
