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

NS_ASSUME_NONNULL_BEGIN

@interface BPKCalendarSelectionConfiguration : NSObject

/**
 * Creates a `BPKCalendarSelectionConfiguration` with the specific classes.
 *
 * @param rangeStyleSelection Whether the selection configuration is a range style.
 * @param allowsMultipleSelection Whether the selection configuration allows multiple simultaneous selections.
 * @return `BPKCalendarSelectionConfiguration` instance.
 */
- (instancetype)initWithRangeStyleSelection:(BOOL)rangeStyleSelection allowMultipleSelection:(BOOL)allowsMultipleSelection;

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
