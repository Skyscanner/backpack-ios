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

//
//  FSCalendarConstants.m
//  FSCalendar
//
//  Created by dingwenchao on 8/28/15.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//
//  https://github.com/WenchaoD
//

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
