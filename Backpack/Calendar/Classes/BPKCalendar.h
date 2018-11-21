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

@class BPKCalendar;

/**
 * Enum values for specifying calendar selection type
 */
typedef NS_ENUM(NSUInteger, BPKCalendarSelection) {
    BPKCalendarSelectionSingle = 0,
    BPKCalendarSelectionRange = 1,
    BPKCalendarSelectionMultiple = 2,
};

NS_SWIFT_NAME(CalendarDelegate) @protocol BPKCalendarDelegate

/**
 * Called when a date selection changed.
 *
 * @param calendar The backpack calendar.
 * @param dateList List of selected dates.
 */
- (void)calendar:(BPKCalendar *)calendar didChangeDateSelection:(NSArray<NSDate *> *)dateList;

@end

NS_SWIFT_NAME(Calendar) @interface BPKCalendar : UIView

/**
 * Locale used for displaying name of days and months
 */
@property (copy, nonatomic) NSLocale *locale;

/**
 * Type of selection allowed
 */
@property (nonatomic) BPKCalendarSelection selectionType;

/**
 * List of selected dates
 */
@property (nonatomic) NSArray<NSDate *> *selectedDates;

/**
 * The earliest date that the user is allowed to select
 */
@property (nonatomic) NSDate *minDate;

/**
 * The latest date that the user is allowed to select
 */
@property (nonatomic) NSDate *maxDate;

- (void)reloadData;

@end
