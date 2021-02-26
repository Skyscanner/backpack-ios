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

#import "BPKCalendarSelectionConfigurationRange.h"

@implementation BPKCalendarSelectionConfigurationRange

- (instancetype)init {
    return [super initWithRangeStyleSelection:YES allowMultipleSelection:YES];
}

- (BOOL)shouldClearSelectedDates:(NSArray<NSDate *> *)selectedDates whenSelectingDate:(NSDate *)date {
    NSDate *firstSelectedDate = selectedDates.count > 0 ? selectedDates[0] : nil;

    BOOL shouldClearDates = NO;
    if (selectedDates.count >= 2) {
        // Two dates are selected already and a new one has been tapped
        shouldClearDates = YES;
    } else if (selectedDates.count == 1 && firstSelectedDate != nil &&
               [date compare:firstSelectedDate] == NSOrderedAscending) {
        // One date is selected already, but it is after the date that has been tapped
        shouldClearDates = YES;
    }

    return shouldClearDates;
}

@end
