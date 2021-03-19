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
 * `BPKCalendarSelectionConfigurationMultiple` is a subclass of `BPKCalendarSelectionConfiguration` designed to enable a user to select any number of individual dates.
 */
@interface BPKCalendarSelectionConfigurationMultiple : BPKCalendarSelectionConfiguration

/**
 * The hint provided to assistive technologies informing a user how to select a date.
 * This hint will be provided on any cell that is not selected.
 */
@property(readonly, nonatomic, copy)NSString *selectionHint;

/**
 * The hint provided to assistive technologies informing a user how to deselect a date.
 * This hint will be provided on any cell that is already selected.
 */
@property(readonly, nonatomic, copy)NSString *deselectionHint;

- (instancetype)init __attribute__((unavailable("`init` cannot be used on BPKCalendarSelectionConfigurationMultiple. Use `initWithSelectionHint:deselectionHint:` instead")));

/**
 * Create a multi-selection configuration with given accessibility strings.
 *
 * @param selectionHint The hint provided to assistive technologies informing a user how to select a date.
 * @param deselectionHint The hint provided to assistive technologies informing a user how to deselect a date.
 * @return A selection configuration.
 */
- (instancetype)initWithSelectionHint:(NSString *)selectionHint deselectionHint:(NSString *)deselectionHint;

@end

NS_ASSUME_NONNULL_END
