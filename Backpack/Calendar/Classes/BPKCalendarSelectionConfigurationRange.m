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


- (instancetype)initWithStartSelectionHint:(NSString *)startSelectionHint
                          endSelectionHint:(NSString *)endSelectionHint
                       startSelectionState:(NSString *)startSelectionState
                         endSelectionState:(NSString *)endSelectionState
                     betweenSelectionState:(NSString *)betweenSelectionState
                 startAndEndSelectionState:(NSString *)startAndEndSelectionState
                          returnDatePrompt:(NSString *)returnDatePrompt {
    self = [super initWithSelectionStyle:BPKCalendarSelectionStyleRange];

    if (self) {
        _startSelectionHint = [startSelectionHint copy];
        _endSelectionHint = [endSelectionHint copy];
        _startSelectionState = [startSelectionState copy];
        _endSelectionState = [endSelectionState copy];
        _betweenSelectionState = [betweenSelectionState copy];
        _startAndEndSelectionState = [startAndEndSelectionState copy];
        _returnDatePrompt = [returnDatePrompt copy];
    }

    return self;
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

- (NSString *)accessibilityHintForDate:(NSDate *)date selectedDates:(NSArray<NSDate *> *)selectedDates {
    if (selectedDates.count == 0 || [self shouldClearSelectedDates:selectedDates whenSelectingDate:date]) {
        return self.startSelectionHint;
    }

    return self.endSelectionHint;
}

- (NSString *)accessibilityLabelForDate:(NSDate *)date selectedDates:(NSArray<NSDate *> *)selectedDates baseLabel:(NSString *)baseLabel {
    NSString *state = nil;
    if (selectedDates.count >= 2) {
        if ([selectedDates[0] isEqualToDate:date] && [selectedDates[1] isEqualToDate:date]) {
            state = self.startAndEndSelectionState;
        } else if ([selectedDates[0] isEqualToDate:date]) {
            state = self.startSelectionState;
        } else if ([selectedDates[1] isEqualToDate:date]) {
            state = self.endSelectionState;
        } else if ([selectedDates[0] compare:date] == NSOrderedAscending && [selectedDates[1] compare:date] == NSOrderedDescending) {
            state = self.betweenSelectionState;
        }
    } else if (selectedDates.count >= 1) {
        if ([selectedDates[0] isEqualToDate:date]) {
            state = self.startSelectionState;
        }
    }

    if (state != nil) {
        return [NSString stringWithFormat:@"%@, %@", baseLabel, state];
    }

    return baseLabel;
}

- (NSString *)accessibilityInstructionHavingSelectedDates:(NSArray<NSDate *> *)selectedDates {
    if (selectedDates.count == 1) {
        return self.returnDatePrompt;
    }

    return nil;
}

@end
