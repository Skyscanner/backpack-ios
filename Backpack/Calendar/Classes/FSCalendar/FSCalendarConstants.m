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

CGFloat const FSCalendarStandardHeaderHeight = 40;
CGFloat const FSCalendarStandardWeekdayHeight = 25;
CGFloat const FSCalendarStandardMonthlyPageHeight = 300.0;
CGFloat const FSCalendarStandardWeeklyPageHeight = 108 + 1 / 3.0;
CGFloat const FSCalendarStandardCellDiameter = 100 / 3.0;
CGFloat const FSCalendarStandardSeparatorThickness = 0.5;
CGFloat const FSCalendarAutomaticDimension = -1;
CGFloat const FSCalendarDefaultBounceAnimationDuration = 0.15;
CGFloat const FSCalendarStandardRowHeight = 38;
CGFloat const FSCalendarStandardTitleTextSize = 13.5;
CGFloat const FSCalendarStandardSubtitleTextSize = 10;
CGFloat const FSCalendarStandardWeekdayTextSize = 14;
CGFloat const FSCalendarStandardHeaderTextSize = 16.5;
CGFloat const FSCalendarMaximumEventDotDiameter = 4.8;

NSInteger const FSCalendarDefaultHourComponent = 0;
NSInteger const FSCalendarMaximumNumberOfEvents = 3;

NSString *const FSCalendarDefaultCellReuseIdentifier = @"_FSCalendarDefaultCellReuseIdentifier";
NSString *const FSCalendarBlankCellReuseIdentifier = @"_FSCalendarBlankCellReuseIdentifier";
NSString *const FSCalendarInvalidArgumentsExceptionName = @"Invalid argument exception";

CGPoint const CGPointInfinity = {.x = CGFLOAT_MAX, .y = CGFLOAT_MAX};

CGSize const CGSizeAutomatic = {.width = FSCalendarAutomaticDimension, .height = FSCalendarAutomaticDimension};
