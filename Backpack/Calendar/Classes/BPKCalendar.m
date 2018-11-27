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
#import "BPKCalendarCell.h"
#import "BPKCalendarHeaderCell.h"
#import "BPKCalendarStickyHeader.h"
#import "BPKCalendarAppearance.h"
#import "BPKCalendarYearPill.h"

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Spacing.h>
#import <FSCalendar/FSCalendar.h>
#import <FSCalendar/FSCalendarCollectionView.h>
#import <FSCalendar/FSCalendarDynamicHeader.h>
#import <FSCalendar/FSCalendarExtensions.h>
#import <FSCalendar/FSCalendarWeekdayView.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface FSCalendar (Private)

@property (weak, nonatomic) FSCalendarCollectionView *collectionView;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface BPKCalendar () <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource, UICollectionViewDelegate>

@property (nonatomic) FSCalendar *calendarView;
@property (nonatomic) FSCalendarWeekdayView *calendarWeekdayView;
@property (nonatomic) BPKCalendarYearPill *yearPill;

@end

@implementation BPKCalendar

NSString * const CellReuseId = @"cell";
NSString * const HeaderReuseId = @"header";
NSString * const HeaderDateFormat = @"MMMM";

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
    self.calendarView.allowsMultipleSelection = self.selectionType != BPKCalendarSelectionSingle;
    self.calendarView.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendarView.delegate = self;
    self.calendarView.dataSource = self;
    self.calendarView.collectionView.delegate = self;
    
    NSDictionary<NSAttributedStringKey, id> *weekdayTextAttributes = [BPKFont attributesForFontStyle:BPKFontStyleTextSm];
    
    BPKCalendarAppearance *appearance = [BPKCalendarAppearance fromFSCalendarAppearance:self.calendarView.appearance];
    appearance.headerDateFormat = HeaderDateFormat;
    appearance.headerTitleColor = [BPKColor gray900];
    appearance.separators = FSCalendarSeparatorNone;
    appearance.weekdayFont = weekdayTextAttributes[NSFontAttributeName];
    appearance.weekdayTextColor = [BPKColor gray500];
    appearance.todayColor = [BPKColor gray100];
    appearance.titleTodayColor = [BPKColor gray900];
    appearance.titleDefaultColor = [BPKColor gray900];
    appearance.selectionColor = [BPKColor blue500];
    appearance.headerTitleFontStyle = BPKFontStyleTextLgEmphasized;
    
    Ivar ivar = class_getInstanceVariable(FSCalendar.class, "_appearance");
    object_setIvar(self.calendarView, ivar, appearance);
    
    [self.calendarView registerClass:[BPKCalendarCell class] forCellReuseIdentifier:CellReuseId];
    [self.calendarView.calendarHeaderView.collectionView registerClass:[BPKCalendarHeaderCell class] forCellWithReuseIdentifier:CellReuseId];
    [self.calendarView.collectionView registerClass:[BPKCalendarStickyHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderReuseId];
    
    [self addSubview:self.calendarView];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.calendarView.topAnchor constraintEqualToAnchor:self.topAnchor constant:6*BPKSpacingMd],
                                              [self.calendarView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                              [self.calendarView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:BPKSpacingBase],
                                              [self.calendarView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-BPKSpacingBase]
                                              ]];
    
    self.calendarWeekdayView = [[FSCalendarWeekdayView alloc] initWithFrame:CGRectZero];
    self.calendarWeekdayView.translatesAutoresizingMaskIntoConstraints = NO;
    self.calendarWeekdayView.calendar = self.calendarView;
    self.calendarWeekdayView.backgroundColor = [BPKColor white];
    [self addSubview:self.calendarWeekdayView];
    
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectZero];
    bottomBorder.translatesAutoresizingMaskIntoConstraints = NO;
    bottomBorder.backgroundColor = [BPKColor gray100];
    [self.calendarWeekdayView addSubview:bottomBorder];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.calendarWeekdayView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [self.calendarWeekdayView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.calendarWeekdayView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                              [self.calendarWeekdayView.heightAnchor constraintEqualToConstant:6*BPKSpacingMd]
                                              ]];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [bottomBorder.bottomAnchor constraintEqualToAnchor:self.calendarWeekdayView.bottomAnchor],
                                              [bottomBorder.leadingAnchor constraintEqualToAnchor:self.calendarWeekdayView.leadingAnchor],
                                              [bottomBorder.trailingAnchor constraintEqualToAnchor:self.calendarWeekdayView.trailingAnchor],
                                              [bottomBorder.heightAnchor constraintEqualToConstant:1.0]
                                              ]];
    
    self.yearPill = [[BPKCalendarYearPill alloc] initWithFrame:CGRectZero];
    self.yearPill.hidden = YES;
    [self addSubview:self.yearPill];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.yearPill.topAnchor constraintEqualToAnchor:self.calendarWeekdayView.bottomAnchor constant:BPKSpacingLg],
                                              [self.yearPill.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
                                              ]];
}

#pragma mark - property getters/setters

- (NSLocale *)locale {
    return self.calendarView.locale;
}

- (void)setLocale:(NSLocale *)locale {
    self.calendarView.locale = locale;
    self.calendarView.firstWeekday = [[locale objectForKey:NSLocaleCalendar] firstWeekday];
    [self.calendarWeekdayView configureAppearance];
}

- (void)setSelectionType:(BPKCalendarSelection)selectionType {
    _selectionType = selectionType;
    self.calendarView.allowsMultipleSelection = _selectionType != BPKCalendarSelectionSingle;
    for (NSDate *date in self.calendarView.selectedDates) {
        [self.calendarView deselectDate:date];
    }
}

- (NSArray<NSDate *> *)selectedDates {
    return self.calendarView.selectedDates;
}

- (void)setSelectedDates:(NSArray<NSDate *> *)selectedDates {
    for (NSDate *date in self.calendarView.selectedDates) {
        [self.calendarView deselectDate:date];
    }
    
    for (NSDate *date in selectedDates) {
        [self.calendarView selectDate:date];
    }
}

#pragma mark - public methods

- (void)reloadData {
    [self.calendarView reloadData];
}

#pragma mark - <FSCalendarDataSource>

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    BPKCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:CellReuseId forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    return self.minDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return self.maxDate;
}

#pragma mark - <FSCalendarDelegate>

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    if (self.selectionType == BPKCalendarSelectionRange) {
        if (calendar.selectedDates.count >= 2) {
            [calendar deselectDate:calendar.selectedDates.lastObject];
        }
        
        for (NSDate *selectedDate in calendar.selectedDates) {
            if ([date compare:selectedDate] == NSOrderedAscending) {
                [calendar deselectDate:selectedDate];
            }
        }
    }
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    [self configureVisibleCells];
    [self.delegate calendar:self didChangeDateSelection:calendar.selectedDates];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    [self configureVisibleCells];
    [self.delegate calendar:self didChangeDateSelection:calendar.selectedDates];
}

- (void)calendar:(FSCalendar *)calendar
 willDisplayCell:(FSCalendarCell *)cell
         forDate:(NSDate *)date
 atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSDateComponents *components = [self.calendarView.gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    NSDateComponents *todayComponents = [self.calendarView.gregorian components:NSCalendarUnitYear fromDate:NSDate.date];
    BOOL isDateOutsideCurrentYear = components.year != todayComponents.year;
    BOOL notJanuaryOrDecember = components.month != 1 && components.month != 12;
    
    if (monthPosition == FSCalendarMonthPositionCurrent
        && isDateOutsideCurrentYear
        && notJanuaryOrDecember) {
        self.yearPill.hidden = NO;
        self.yearPill.year = [NSNumber numberWithInteger:components.year];
    } else if (notJanuaryOrDecember) {
        self.yearPill.hidden = YES;
    }
    
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
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

#pragma mark - <UICollectionViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(calendar:didScroll:)]) {
        [self.delegate calendar:self didScroll:scrollView.contentOffset];
    }
    [self.calendarView scrollViewDidScroll:scrollView];
}

#pragma mark - private

- (void)configureVisibleCells {
    [self.calendarView.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendarView dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendarView monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSArray<NSDate *> *selectedDates = [self.calendarView.selectedDates sortedArrayUsingComparator:^NSComparisonResult(NSDate *a, NSDate *b) {
        return [a compare:b];
    }];
    BPKCalendarCell *calendarCell = (BPKCalendarCell *)cell;
    
    // Configure selection layer
    if (monthPosition == FSCalendarMonthPositionCurrent) {
        SelectionType selectionType = SelectionTypeNone;
        RowType rowType = RowTypeMiddle;
        
        if (selectedDates.count > 1 && self.selectionType == BPKCalendarSelectionRange) {
            NSDate *minDate = [selectedDates firstObject];
            NSDate *maxDate = [selectedDates lastObject];
            BOOL dateInsideRange = [BPKCalendar date:date isBetweenDate:minDate andDate:maxDate];
            if (dateInsideRange) {
                BOOL isMinDate = [date isEqualToDate:minDate];
                BOOL isMaxDate = [date isEqualToDate:maxDate];
                NSCalendar *gregorian = self.calendarView.gregorian;
                NSDate *firstWeekday = [gregorian fs_firstDayOfWeek:date];
                NSDate *lastWeekday = [gregorian fs_lastDayOfWeek:date];
                NSDate *firstDayOfMonth = [gregorian fs_firstDayOfMonth:date];
                NSDate *lastDayOfMonth = [gregorian fs_lastDayOfMonth:date];
                BOOL isRowStart = [gregorian isDate:date inSameDayAsDate:firstWeekday]
                || [gregorian isDate:date inSameDayAsDate:firstDayOfMonth];
                BOOL isRowEnd = [gregorian isDate:date inSameDayAsDate:lastWeekday]
                || [gregorian isDate:date inSameDayAsDate:lastDayOfMonth];
                
                if (isRowStart && isRowEnd) {
                    rowType = RowTypeBoth;
                } else if (isRowStart) {
                    rowType = RowTypeStart;
                } else if (isRowEnd) {
                    rowType = RowTypeEnd;
                }
                
                if (isMinDate) {
                    selectionType = SelectionTypeLeftBorder;
                } else if (isMaxDate) {
                    selectionType = SelectionTypeRightBorder;
                } else {
                    selectionType = SelectionTypeMiddle;
                }
            }
        } else if ([selectedDates containsObject:date]) {
            selectionType = SelectionTypeSingle;
        }
        
        calendarCell.selectionType = selectionType;
        calendarCell.rowType = rowType;
    }
}

#pragma mark - helpers

- (BOOL)isDateInToday:(NSDate *)date {
    return [self.calendarView.gregorian isDateInToday:date];
}

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
        return NO;
    
    return YES;
}

#pragma mark -

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [self.calendarView respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)selector
{
    if ([self.calendarView respondsToSelector:selector]) {
        return self.calendarView;
    }
    return [super forwardingTargetForSelector:selector];
}

@end
