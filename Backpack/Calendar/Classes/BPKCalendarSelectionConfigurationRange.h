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

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKCalendarSelectionConfigurationRange` is a subclass of `BPKCalendarSelectionConfiguration` designed to enable a user to select a range of dates, represented by a start date and end date.
 */
@interface BPKCalendarSelectionConfigurationRange : BPKCalendarSelectionConfiguration

/**
 * The hint provided to assistive technologies informing a user how to select the first date in the range.
 * This hint will be provided on any cell that can be selected as the first date.
 */
@property(readonly, nonatomic, copy) NSString *firstSelectionHint;

/**
 * The hint provided to assistive technologies informing a user how to select the second date in the range.
 * This hint will be provided on any cell that can be selected as the second date.
 */
@property(readonly, nonatomic, copy) NSString *secondSelectionHint;

/**
 * The label provided to assistive technologies informing a user that a date is selected as the first date in the range.
 */
@property(readonly, nonatomic, copy) NSString *firstSelectionState;

/**
 * The label provided to assistive technologies informing a user that a date is selected as the second date in the range.
 */
@property(readonly, nonatomic, copy) NSString *secondSelectionState;

/**
 * The label provided to assistive technologies informing a user that a date lies between the first and second selected dates.
 */
@property(readonly, nonatomic, copy) NSString *betweenSelectionState;

/**
 * The label provided to assistive technologies informing a user that a date is selected as both the first and second date in the range.
 */
@property(readonly, nonatomic, copy) NSString *firstAndSecondSelectionState;

/**
 * The prompt provided to assistive technologies informing a user that they should now select a second date.
 * This is prompted once the first date is selected
 */
@property(readonly, nonatomic, copy) NSString *returnDatePrompt;

- (instancetype)init __attribute__((unavailable("`init` cannot be used on BPKCalendarSelectionConfigurationRange. Use `initWithFirstSelectionHint:...:` instead")));

- (instancetype)initWithSelectionStyle:(BPKCalendarSelectionStyle)selectionStyle __attribute__((unavailable("`initWithSelectionStyle:` cannot be used on BPKCalendarSelectionConfigurationRange. Use `initWithFirstSelectionHint:...:` instead")));

/**
 * Create a multi-selection configuration with given accessibility strings.
 *
 * @param firstSelectionHint The hint provided to assistive technologies informing a user how to select the first date in the range.
 * @param secondSelectionHint The hint provided to assistive technologies informing a user how to select the second date in the range.
 * @param firstSelectionState The label provided to assistive technologies informing a user that a date is selected as the first date in the range.
 * @param secondSelectionState The label provided to assistive technologies informing a user that a date is selected as the second date in the range.
 * @param betweenSelectionState The label provided to assistive technologies informing a user that a date lies between the first and second selected dates.
 * @param firstAndSecondSelectionState The label provided to assistive technologies informing a user that a date is selected as both the first and second date in the range.
 * @param returnDatePrompt The prompt provided to assistive technologies informing a user that they should now select a second date.
 * @return A selection configuration.
 */
- (instancetype)initWithFirstSelectionHint:(NSString *)firstSelectionHint
                       secondSelectionHint:(NSString *)secondSelectionHint
                       firstSelectionState:(NSString *)firstSelectionState
                      secondSelectionState:(NSString *)secondSelectionState
                     betweenSelectionState:(NSString *)betweenSelectionState
              firstAndSecondSelectionState:(NSString *)firstAndSecondSelectionState
                          returnDatePrompt:(NSString *)returnDatePrompt;

@end

NS_ASSUME_NONNULL_END
