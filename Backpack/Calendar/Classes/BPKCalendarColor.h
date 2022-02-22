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

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKCalendarColor` contains a number of pre-defined colours commonly used when presenting a calendar.
 */
@interface BPKCalendarColor : NSObject

/**
 * The normal calendar background color.
 */
@property(class, readonly) UIColor *normalColor;

/**
 * The colour that should be used for calendar labels when shown on a normal colored background.
 */
@property(class, readonly) UIColor *normalTitleColor;

/**
 * The positve calendar color.
 */
@property(class, readonly) UIColor *positiveColor;

/**
 * The colour that should be used for calendar labels when shown on a positive colored background.
 */
@property(class, readonly) UIColor *positiveTitleColor;

/**
 * The negative calendar color.
 */
@property(class, readonly) UIColor *negativeColor;

/**
 * The colour that should be used for calendar labels when shown on a negative colored background.
 */
@property(class, readonly) UIColor *negativeTitleColor;

/**
 * The no-data calendar color.
 */
@property(class, readonly) UIColor *noDataColor;

/**
 * The colour that should be used for calendar labels when shown on a no-data colored background.
 */
@property(class, readonly) UIColor *noDataTitleColor;

/**
 * The neutral calendar color.
 */
@property(class, readonly) UIColor *neutralColor;

/**
 * The colour that should be used for calendar labels when shown on a neutral colored background.
 */
@property(class, readonly) UIColor *neutralTitleColor;

@end

NS_ASSUME_NONNULL_END
