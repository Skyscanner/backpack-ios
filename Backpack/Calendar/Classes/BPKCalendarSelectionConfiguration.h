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

/**
 * Enum values for specifying calendar selection style
 */
typedef NS_ENUM(NSUInteger, BPKCalendarSelectionStyle) {
    /**
     * Select a single date in the calendar.
     */
    BPKCalendarSelectionStyleSingle = 0,

    /**
     * Select a range in the calendar by selecting a start and then an end date.
     */
    BPKCalendarSelectionStyleRange = 1,

    /**
     * Select multiple individual dates.
     */
    BPKCalendarSelectionStyleMultiple = 2,
};

NS_ASSUME_NONNULL_BEGIN

/*
 * Defines how interaction with the calendar should behave.
 */
@interface BPKCalendarSelectionConfiguration : NSObject

/**
 * Creates a `BPKCalendarSelectionConfiguration` with the specific classes.
 *
 * @param selectionStyle The selection style of the config.
 * @return `BPKCalendarSelectionConfiguration` instance.
 */
- (instancetype)initWithSelectionStyle:(BPKCalendarSelectionStyle)selectionStyle;

/**
 * The pre-defined selection style of the calendar.
 */
@property(readonly)BPKCalendarSelectionStyle selectionStyle;

/**
 * Whether the selection configuration is a range style (ie start date and end date with 0 or more dates between).
 */
@property(readonly)BOOL isRangeStyleSelection;

/**
 * Whether the selection configuration allows multiple dates to be selected simultaneously.
 */
@property(readonly)BOOL allowsMultipleSelection;

-(BOOL)shouldClearSelectedDates:(NSArray<NSDate *> *)selectedDates whenSelectingDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
