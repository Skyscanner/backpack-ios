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

/*
 * Copyright (c) 2013-2016 FSCalendar (https://github.com/WenchaoD/FSCalendar)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "FSCalendarConstants.h"

@class FSCalendar;

typedef NS_ENUM(NSInteger, FSCalendarCellState) {
    FSCalendarCellStateNormal = 0,
    FSCalendarCellStateSelected = 1,
    FSCalendarCellStatePlaceholder = 1 << 1,
    FSCalendarCellStateDisabled = 1 << 2,
    FSCalendarCellStateToday = 1 << 3,
    FSCalendarCellStateWeekend = 1 << 4,
    FSCalendarCellStateTodaySelected = FSCalendarCellStateToday | FSCalendarCellStateSelected
};

typedef NS_ENUM(NSUInteger, FSCalendarSeparators) { FSCalendarSeparatorNone = 0, FSCalendarSeparatorInterRows = 1 };

typedef NS_OPTIONS(NSUInteger, FSCalendarCaseOptions) {
    FSCalendarCaseOptionsHeaderUsesDefaultCase = 0,
    FSCalendarCaseOptionsHeaderUsesUpperCase = 1 << 0,
    FSCalendarCaseOptionsHeaderUsesCapitalized = 1 << 1,

    FSCalendarCaseOptionsWeekdayUsesDefaultCase = 0 << 4,
    FSCalendarCaseOptionsWeekdayUsesUpperCase = 1 << 4,
    FSCalendarCaseOptionsWeekdayUsesSingleUpperCase = 2 << 4,
};

/**
 * FSCalendarAppearance determines the fonts and colors of components in the calendar.
 *
 * @see FSCalendarDelegateAppearance
 */
@interface FSCalendarAppearance : NSObject

/**
 * The font of the day text.
 */
@property(strong, nonatomic) UIFont *titleFont;

/**
 * The font of the subtitle text.
 */
@property(strong, nonatomic) UIFont *subtitleFont;

/**
 * The font of the weekday text.
 */
@property(strong, nonatomic) UIFont *weekdayFont;

/**
 * The font of the month text.
 */
@property(strong, nonatomic) UIFont *headerTitleFont;

/**
 * The offset of the month header from default position.
 */
@property(assign, nonatomic) CGPoint headerTitleOffset;

/**
 * The offset of the day text from default position.
 */
@property(assign, nonatomic) CGPoint titleOffset;

/**
 * The offset of the day text from default position.
 */
@property(assign, nonatomic) CGPoint subtitleOffset;

/**
 * The offset of the event dots from default position.
 */
@property(assign, nonatomic) CGPoint eventOffset;

/**
 * The offset of the image from default position.
 */
@property(assign, nonatomic) CGPoint imageOffset;

/**
 * The color of event dots.
 */
@property(strong, nonatomic) UIColor *eventDefaultColor;

/**
 * The color of event dots.
 */
@property(strong, nonatomic) UIColor *eventSelectionColor;

/**
 * The color of weekday text.
 */
@property(strong, nonatomic) UIColor *weekdayTextColor;

/**
 * The color of month header text.
 */
@property(strong, nonatomic) UIColor *headerTitleColor;

/**
 * The color oh month header separator
 */
@property(strong, nonatomic) UIColor *headerSeparatorColor;

/**
 * The date format of the month header.
 */
@property(strong, nonatomic) NSString *headerDateFormat;

/**
 * The text alignment of the month header.
 */
@property(assign, nonatomic) NSTextAlignment headerTitleAlignment;

/**
 * The alpha value of month label staying on the fringes.
 */
@property(assign, nonatomic) CGFloat headerMinimumDissolvedAlpha;

/**
 * The day text color for unselected state.
 */
@property(strong, nonatomic) UIColor *titleDefaultColor;

/**
 * The day text color for selected state.
 */
@property(strong, nonatomic) UIColor *titleSelectionColor;

/**
 * The day text color for today in the calendar.
 */
@property(strong, nonatomic) UIColor *titleTodayColor;

/**
 * The day text color for days out of current month.
 */
@property(strong, nonatomic) UIColor *titlePlaceholderColor;

/**
 * The day text color for weekend.
 */
@property(strong, nonatomic) UIColor *titleWeekendColor;

/**
 * The subtitle text color for unselected state.
 */
@property(strong, nonatomic) UIColor *subtitleDefaultColor;

/**
 * The subtitle text color for selected state.
 */
@property(strong, nonatomic) UIColor *subtitleSelectionColor;

/**
 * The subtitle text color for today in the calendar.
 */
@property(strong, nonatomic) UIColor *subtitleTodayColor;

/**
 * The subtitle text color for days out of current month.
 */
@property(strong, nonatomic) UIColor *subtitlePlaceholderColor;

/**
 * The subtitle text color for weekend.
 */
@property(strong, nonatomic) UIColor *subtitleWeekendColor;

/**
 * The fill color of the shape for selected state.
 */
@property(strong, nonatomic) UIColor *selectionColor;

/**
 * The fill color of the shape for today.
 */
@property(strong, nonatomic) UIColor *todayColor;

/**
 * The fill color of the shape for today and selected state.
 */
@property(strong, nonatomic) UIColor *todaySelectionColor;

/**
 * The border color of the shape for unselected state.
 */
@property(strong, nonatomic) UIColor *borderDefaultColor;

/**
 * The border color of the shape for selected state.
 */
@property(strong, nonatomic) UIColor *borderSelectionColor;

/**
 * The border radius, while 1 means a circle, 0 means a rectangle, and the middle value will give it a corner radius.
 */
@property(assign, nonatomic) CGFloat borderRadius;

/**
 * The case options manage the case of month label and weekday symbols.
 *
 * @see FSCalendarCaseOptions
 */
@property(assign, nonatomic) FSCalendarCaseOptions caseOptions;

/**
 * The line integrations for calendar.
 *
 */
@property(assign, nonatomic) FSCalendarSeparators separators;

#if TARGET_INTERFACE_BUILDER

// For preview only
@property(assign, nonatomic) BOOL fakeSubtitles;
@property(assign, nonatomic) BOOL fakeEventDots;
@property(assign, nonatomic) NSInteger fakedSelectedDay;

#endif

@end
