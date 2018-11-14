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

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(CalendarAppearance) @interface BPKCalendarAppearance : NSObject

/**
 * The font of the weekday text.
 */
@property (nonatomic) UIFont *weekdayFont;

/**
 * The font of the month text.
 */
@property (nonatomic) UIFont *headerTitleFont;

/**
 * The color of weekday text.
 */
@property (nonatomic) UIColor *weekdayTextColor;

/**
 * The color of month header text.
 */
@property (nonatomic) UIColor *headerTitleColor;

/**
 * The date format of the month header.
 */
@property (nonatomic) NSString *headerDateFormat;

/**
 * The alpha value of month label staying on the fringes.
 */
@property (nonatomic) CGFloat headerMinimumDissolvedAlpha;

/**
 * The day text color for unselected state.
 */
@property (nonatomic) UIColor *dayTextDefaultColor;

/**
 * The day text color for selected state.
 */
@property (nonatomic) UIColor *dayTextSelectionColor;

/**
 * The day text color for today in the calendar.
 */
@property (nonatomic) UIColor *dayTextTodayColor;

/**
 * The day text color for days out of current month.
 */
@property (nonatomic) UIColor *dayTextPlaceholderColor;

/**
 * The day text color for weekend.
 */
@property (nonatomic) UIColor *dayTextWeekendColor;

/**
 * The fill color of the shape for selected state.
 */
@property (nonatomic) UIColor *selectionColor;

/**
 * The fill color of the shape for today.
 */
@property (nonatomic) UIColor *todayColor;

/**
 * The fill color of the shape for today and selected state.
 */
@property (nonatomic) UIColor *todaySelectionColor;

/**
 * The border color of the shape for unselected state.
 */
@property (nonatomic) UIColor *borderDefaultColor;

/**
 * The border color of the shape for selected state.
 */
@property (nonatomic) UIColor *borderSelectionColor;

/**
 * The border radius, while 1 means a circle, 0 means a rectangle, and the middle value will give it a corner radius.
 */
@property (nonatomic) CGFloat borderRadius;

@end
