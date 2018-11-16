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

#import "BPKCalendar.h"
#import "BPKCalendarHeaderCell.h"
#import "BPKCalendarStickyHeader.h"
#import "BPKCalendarAppearance.h"

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Spacing.h>
#import <FSCalendar/FSCalendar.h>
#import <FSCalendar/FSCalendarCollectionView.h>
#import <FSCalendar/FSCalendarDynamicHeader.h>
#import <FSCalendar/FSCalendarWeekdayView.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface FSCalendar (Private)

@property (weak, nonatomic) FSCalendarCollectionView *collectionView;

@end

@interface BPKCalendar () <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource>

@property (nonatomic) FSCalendar *calendarView;
@property (nonatomic) FSCalendarWeekdayView *calendarWeekdayView;

@end

@implementation BPKCalendar

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.calendarView = [[FSCalendar alloc] initWithFrame:CGRectZero];
    self.calendarView.translatesAutoresizingMaskIntoConstraints = NO;
    self.calendarView.scrollDirection = FSCalendarScrollDirectionVertical;
    self.calendarView.scrollEnabled = YES;
    self.calendarView.pagingEnabled = NO;
    self.calendarView.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendarView.delegate = self;
    self.calendarView.dataSource = self;
    
    NSDictionary<NSAttributedStringKey, id> *weekdayTextAttributes = [BPKFont attributesForFontStyle:BPKFontStyleTextSm];
    
    BPKCalendarAppearance *appearance = [BPKCalendarAppearance fromFSCalendarAppearance:self.calendarView.appearance];
    appearance.headerDateFormat = @"MMMM";
    appearance.headerTitleColor = [BPKColor gray900];
    appearance.separators = FSCalendarSeparatorNone;
    appearance.weekdayFont = weekdayTextAttributes[NSFontAttributeName];
    appearance.weekdayTextColor = weekdayTextAttributes[NSForegroundColorAttributeName];
    appearance.todayColor = [BPKColor gray100];
    appearance.titleTodayColor = [BPKColor gray900];
    appearance.titleDefaultColor = [BPKColor gray900];
    appearance.selectionColor = [BPKColor blue500];
    appearance.headerTitleFontStyle = BPKFontStyleTextLgEmphasized;
    
    Ivar ivar = class_getInstanceVariable(FSCalendar.class, "_appearance");
    object_setIvar(self.calendarView, ivar, appearance);
    
    // Register our Custom Header Class
    [self.calendarView.calendarHeaderView.collectionView registerClass:[BPKCalendarHeaderCell class] forCellWithReuseIdentifier:@"cell"];
    [self.calendarView.collectionView registerClass:[BPKCalendarStickyHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self addSubview:self.calendarView];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.calendarView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [self.calendarView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                              [self.calendarView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.calendarView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
                                              ]];
    
    _calendarWeekdayView = [[FSCalendarWeekdayView alloc] initWithFrame:CGRectZero];
    _calendarWeekdayView.translatesAutoresizingMaskIntoConstraints = NO;
    _calendarWeekdayView.calendar = _calendarView;
    _calendarWeekdayView.backgroundColor = [BPKColor white];
    [self addSubview:_calendarWeekdayView];
    
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectZero];
    bottomBorder.translatesAutoresizingMaskIntoConstraints = NO;
    bottomBorder.backgroundColor = [BPKColor gray100];
    [_calendarWeekdayView addSubview:bottomBorder];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [_calendarWeekdayView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [_calendarWeekdayView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [_calendarWeekdayView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                              [_calendarWeekdayView.heightAnchor constraintEqualToConstant:48]
                                              ]];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [bottomBorder.bottomAnchor constraintEqualToAnchor:_calendarWeekdayView.bottomAnchor],
                                              [bottomBorder.leadingAnchor constraintEqualToAnchor:_calendarWeekdayView.leadingAnchor],
                                              [bottomBorder.trailingAnchor constraintEqualToAnchor:_calendarWeekdayView.trailingAnchor],
                                              [bottomBorder.heightAnchor constraintEqualToConstant:1.0]
                                              ]];
}

#pragma mark - <FSCalendarDelegateAppearance>

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date {
    if([self isDateInToday:date]) {
        return [UIColor clearColor];
    }
    return appearance.borderDefaultColor;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date {
    if([self isDateInToday:date]) {
        return appearance.todayColor;
    }
    return appearance.borderDefaultColor;
}

#pragma mark - helpers

- (BOOL)isDateInToday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorian isDateInToday:date];
}

@end
