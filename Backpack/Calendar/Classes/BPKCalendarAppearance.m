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

#import "BPKCalendarAppearance.h"

@implementation BPKCalendarAppearance

+ (instancetype)fromFSCalendarAppearance:(FSCalendarAppearance *)appearance {
    BPKCalendarAppearance *instance = [[BPKCalendarAppearance alloc] init];
    
    instance.titleFont = appearance.titleFont;
    instance.subtitleFont = appearance.subtitleFont;
    instance.weekdayFont = appearance.weekdayFont;
    instance.headerTitleFont = appearance.headerTitleFont;
    instance.titleOffset = appearance.titleOffset;
    instance.subtitleOffset = appearance.subtitleOffset;
    instance.eventOffset = appearance.eventOffset;
    instance.imageOffset = appearance.imageOffset;
    instance.eventDefaultColor = appearance.eventDefaultColor;
    instance.eventSelectionColor = appearance.eventSelectionColor;
    instance.weekdayTextColor = appearance.weekdayTextColor;
    instance.headerTitleColor = appearance.headerTitleColor;
    instance.headerDateFormat = appearance.headerDateFormat;
    instance.headerMinimumDissolvedAlpha = appearance.headerMinimumDissolvedAlpha;
    instance.titleDefaultColor = appearance.titleDefaultColor;
    instance.titleSelectionColor = appearance.titleSelectionColor;
    instance.titleTodayColor = appearance.titleTodayColor;
    instance.titlePlaceholderColor = appearance.titlePlaceholderColor;
    instance.titleWeekendColor = appearance.titleWeekendColor;
    instance.subtitleDefaultColor = appearance.subtitleDefaultColor;
    instance.subtitleSelectionColor = appearance.subtitleSelectionColor;
    instance.subtitleTodayColor = appearance.subtitleTodayColor;
    instance.subtitlePlaceholderColor = appearance.subtitlePlaceholderColor;
    instance.subtitleWeekendColor = appearance.subtitleWeekendColor;
    instance.selectionColor = appearance.selectionColor;
    instance.todayColor = appearance.todayColor;
    instance.todaySelectionColor = appearance.todaySelectionColor;
    instance.borderDefaultColor = appearance.borderDefaultColor;
    instance.borderSelectionColor = appearance.borderSelectionColor;
    instance.borderRadius = appearance.borderRadius;
    instance.caseOptions = appearance.caseOptions;
    instance.separators = appearance.separators;
    
    return instance;
}

@end
