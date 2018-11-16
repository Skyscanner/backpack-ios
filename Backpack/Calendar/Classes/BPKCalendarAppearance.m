//
//  BPKCalendarAppearance.m
//  Backpack
//
//  Created by Aron Szabados on 2018. 11. 16..
//

#import "BPKCalendarAppearance.h"

@implementation BPKCalendarAppearance

+(instancetype)fromFSCalendarAppearance:(FSCalendarAppearance *)appearance {
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
