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

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import <FSCalendar/FSCalendar.h>
#import <FSCalendar/FSCalendarCollectionView.h>
#import <FSCalendar/FSCalendarDynamicHeader.h>
#import <FSCalendar/FSCalendarExtensions.h>
#import <FSCalendar/FSCalendarWeekdayView.h>

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Font.h>
#import <Backpack/SimpleDate.h>
#import <Backpack/Spacing.h>

#import "BPKCalendarAppearance.h"
#import "BPKCalendarCell.h"
#import "BPKCalendarCellSpacing.h"
#import "BPKCalendarConfiguration.h"
#import "BPKCalendarHeaderCell.h"
#import "BPKCalendarSelectionConfiguration.h"
#import "BPKCalendarStickyHeader.h"
#import "BPKCalendarTrafficLightConfiguration.h"
#import "BPKCalendarYearPill.h"

NS_ASSUME_NONNULL_BEGIN

// This is kept around only to support the React Native calendar implementation
@protocol BPKCalendarDelegateExtendedForRN <BPKCalendarDelegate>
@optional
/**
 * Asks the delegate for a fill color for the specific date.
 *
 * @param calendar The backpack calendar.
 * @param date The date to provide fill-color for.
 * @return The fill/background colour for the given date.
 * @note This method is not called if the delegate implements `calendar:cellStyleForDate:` unless it returns
 * the custom cell style for a date.
 * @deprecated Use `calendar:cellStyleForDate:` instead.
 */
- (UIColor *)DONT_USE_calendar:(BPKCalendar *)calendar fillColorForDate:(NSDate *)date __deprecated_msg("Use `calendar:cellStyleForDate:` instead.");

/**
 * Asks the delegate for a title color for the specific date.
 *
 * @param calendar The backpack calendar.
 * @param date The date to provide title-color for.
 * @return The title colour for the given date.
 * @note This method is not called if the delegate implements `calendar:cellStyleForDate:` unless it returns
 * the custom cell style for a date.
 * @deprecated Use `calendar:cellStyleForDate:` instead.
 */
- (UIColor *)DONT_USE_calendar:(BPKCalendar *)calendar titleColorForDate:(NSDate *)date __deprecated_msg("Use `calendar:cellStyleForDate:` instead.");
@end

#pragma mark - FSCalendar Extensions
@interface FSCalendar ()

@property(weak, nonatomic) FSCalendarCollectionView *collectionView;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

#pragma mark - BPKCalendar

@interface BPKCalendar () <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource, UICollectionViewDelegate>

@property(nonatomic, strong, nonnull) UIView *calendarWrapperView;
@property(nonatomic, strong, nonnull) FSCalendar *calendarView;
@property(nonatomic, strong, nonnull) FSCalendarWeekdayView *calendarWeekdayView;
@property(nonatomic, strong, nonnull) BPKCalendarYearPill *yearPill;
@property(nonatomic, strong, nonnull) BPKCalendarAppearance *appearance;
@property(nonatomic, strong, nonnull) UIView *bottomBorder;
@property(nonatomic, strong, nonnull) NSCalendar *gregorian;
@property(nonatomic, strong, nonnull) NSDateFormatter *dateFormatter;
@property(readonly) NSArray<NSDate *> *sortedSelectedDates;

@property BOOL sameDayRange;

@end

@implementation BPKCalendar

NSString *const CellReuseId = @"cell";
NSString *const HeaderReuseId = @"header";
NSString *const HeaderDateFormat = @"MMMM";
CGFloat const BPKCalendarDefaultCellHeight = 44;

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    BPKAssertMainThread();
    if (_configuration == nil) {
        _configuration = [BPKCalendarTrafficLightConfiguration new];
    }

    self = [super initWithCoder:coder];
    if (self) {
        // FSCalendar does this internally, but we declare in or public interface that
        // `minDate` and `maxDate` is `nonnull` so we need to ensure **it is not** `nil`.
        self.minDate = [[BPKSimpleDate alloc] initWithYear:1970 month:1 day:1];
        self.maxDate = [[BPKSimpleDate alloc] initWithYear:2099 month:12 day:31];
        [self setup];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    if (_configuration == nil) {
        _configuration = [BPKCalendarTrafficLightConfiguration new];
    }

    self = [super initWithFrame:frame];
    if (self) {
        // FSCalendar does this internally, but we declare in or public interface that
        // `minDate` and `maxDate` is `nonnull` so we need to ensure **it is not** `nil`.
        self.minDate = [[BPKSimpleDate alloc] initWithYear:1970 month:1 day:1];
        self.maxDate = [[BPKSimpleDate alloc] initWithYear:2099 month:12 day:31];
        [self setup];
    }

    return self;
}

- (instancetype)initWithMinDate:(BPKSimpleDate *)minDate
                        maxDate:(BPKSimpleDate *)maxDate
                  configuration:(BPKCalendarConfiguration *)configuration
         selectionConfiguration:(BPKCalendarSelectionConfiguration *)selectionConfiguration {
    _configuration = configuration;

    return [self initWithMinDate:minDate maxDate:maxDate selectionConfiguration:selectionConfiguration];
}

- (instancetype)initWithMinDate:(BPKSimpleDate *)minDate
                        maxDate:(BPKSimpleDate *)maxDate
         selectionConfiguration:(BPKCalendarSelectionConfiguration *)selectionConfiguration {
    BPKAssertMainThread();
    if (_configuration == nil) {
        _configuration = [BPKCalendarTrafficLightConfiguration new];
    }

    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.selectionConfiguration = selectionConfiguration;
        self.minDate = minDate;
        self.maxDate = maxDate;
        [self setup];
    }

    return self;
}

- (instancetype)initWithConfiguration:(BPKCalendarConfiguration *)configuration
               selectionConfiguration:(BPKCalendarSelectionConfiguration *)selectionConfiguration {
    _configuration = configuration;

    self = [self initWithFrame:CGRectZero];

    if (self) {
        self.selectionConfiguration = selectionConfiguration;
        [self setup];
    }

    return self;
}

- (void)applySubviewClipsToBoundsHack {
    // FSCalendar has an internal hierarchy of views in which the collectionView is rendered.
    // We need to ensure all of these have `clipsToBounds` set to `NO` to ensure the selection range can extend beyond the collectionView.
    self.calendarView.subviews[0].clipsToBounds = NO;
    self.calendarView.subviews[0].subviews[0].clipsToBounds = NO;
}

- (void)setup {
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.locale = self.locale;
    self.dateFormatter.dateStyle = NSDateFormatterLongStyle;

    // We use a wrapper view here to prevent the calendar cells being rendered over the week days
    self.calendarWrapperView = [UIView new];
    self.calendarView = [[FSCalendar alloc] initWithFrame:CGRectZero];
    self.calendarView.clipsToBounds = NO;
    self.calendarView.collectionView.clipsToBounds = NO;
    self.calendarWrapperView.clipsToBounds = YES;
    [self applySubviewClipsToBoundsHack];
    if (self.configuration.rowHeight == nil) {
        self.calendarView.rowHeight = BPKCalendarCellSpacing.defaultCellHeight;
    } else {
        self.calendarView.rowHeight = [self.configuration.rowHeight floatValue];
    }
    self.calendarView.scrollDirection = FSCalendarScrollDirectionVertical;
    self.calendarView.scrollEnabled = YES;
    self.calendarView.pagingEnabled = NO;
    self.calendarView.allowsMultipleSelection = self.selectionConfiguration.allowsMultipleSelection;
    self.calendarView.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendarView.delegate = self;
    self.calendarView.dataSource = self;
    self.calendarView.collectionView.delegate = self;

    NSDictionary<NSAttributedStringKey, id> *weekdayTextAttributes = [BPKFont attributesForFontStyle:BPKFontStyleTextFootnote];

    BPKCalendarAppearance *appearance = [BPKCalendarAppearance fromFSCalendarAppearance:self.calendarView.appearance];
    appearance.headerDateFormat = HeaderDateFormat;
    appearance.headerTitleColor = BPKColor.textPrimaryColor;
    appearance.separators = FSCalendarSeparatorNone;
    appearance.weekdayFont = weekdayTextAttributes[NSFontAttributeName];
    appearance.todayColor = BPKColor.clear;
    appearance.weekdayTextColor = [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint02 darkVariant:BPKColor.white];
    appearance.titleDefaultColor = BPKColor.textPrimaryColor;
    appearance.selectionColor = self.currentDateSelectedBackgroundColor;
    appearance.titleSelectionColor = self.currentDateSelectedContentColor;
    appearance.headerTitleFontStyle = BPKFontStyleTextHeading4;

    _appearance = appearance;

    Ivar ivar = class_getInstanceVariable(FSCalendar.class, "_appearance");
    object_setIvar(self.calendarView, ivar, self.appearance);

    [self.calendarView registerClass:self.configuration.cellClass forCellReuseIdentifier:CellReuseId];
    [self.calendarView.calendarHeaderView.collectionView registerClass:[BPKCalendarHeaderCell class] forCellWithReuseIdentifier:CellReuseId];

    [self.calendarView.collectionView registerClass:[BPKCalendarStickyHeader class]
                         forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                withReuseIdentifier:HeaderReuseId];

    [self addSubview:self.calendarWrapperView];
    [self.calendarWrapperView addSubview:self.calendarView];

    self.calendarWeekdayView = [[FSCalendarWeekdayView alloc] initWithFrame:CGRectZero];
    self.calendarWeekdayView.calendar = self.calendarView;
    [self addSubview:self.calendarWeekdayView];

    self.bottomBorder = [[UIView alloc] initWithFrame:CGRectZero];
    self.bottomBorder.backgroundColor = BPKColor.lineColor;
    [self addSubview:self.bottomBorder];

    self.yearPill = [[BPKCalendarYearPill alloc] initWithFrame:CGRectZero];
    self.yearPill.hidden = YES;
    [self addSubview:self.yearPill];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // NOTE: This class uses manual layout rather than Auto Layout because it needs to be usable as a Native UI
    // Component from React Native. DON'T attempt to convert it to Auto Layout

    CGRect bounds = self.bounds;
    CGFloat width = CGRectGetWidth(bounds);
    CGFloat height = CGRectGetHeight(bounds);
    CGFloat calendarWidth = CGRectGetWidth(self.calendarView.frame);
    CGFloat weekdayViewHeight = 6 * BPKSpacingMd;
    CGFloat calendarViewHeight = height - weekdayViewHeight;

    self.calendarWrapperView.frame = CGRectMake(0, weekdayViewHeight, width, calendarViewHeight);
    self.calendarView.frame = CGRectMake(BPKSpacingBase, 0, width - 2 * BPKSpacingBase, calendarViewHeight);

    self.calendarWeekdayView.frame = CGRectMake(BPKSpacingBase, 0, width - 2 * BPKSpacingBase, weekdayViewHeight);
    self.bottomBorder.frame = CGRectMake(0.0, weekdayViewHeight - 1, width, 1.0);

    CGFloat yearPillWidth = CGRectGetWidth(self.yearPill.bounds);
    CGFloat yearPillHeight = CGRectGetHeight(self.yearPill.bounds);
    self.yearPill.frame =
        CGRectMake(width / 2.0 - yearPillWidth / 2.0, CGRectGetHeight(self.calendarWeekdayView.frame) + BPKSpacingLg, yearPillWidth, yearPillHeight);

    if (fabs(calendarWidth - CGRectGetWidth(self.calendarView.frame)) > 0.1) {
        [self.calendarView.collectionViewLayout invalidateLayout];
    }
}

#pragma mark - property getters/setters

- (NSLocale *)locale {
    // This will be nonnull as `FSCalendar` set it
    // to `currentLocale` by default.
    return self.calendarView.locale;
}

- (void)setLocale:(NSLocale *)locale {
    BPKAssertMainThread();
    self.gregorian.locale = locale;
    self.dateFormatter.locale = locale;
    self.calendarView.locale = locale;
    self.calendarView.firstWeekday = [[locale objectForKey:NSLocaleCalendar] firstWeekday];
    [self.calendarWeekdayView configureAppearance];
}

- (void)setSelectionConfiguration:(BPKCalendarSelectionConfiguration *)selectionConfiguration {
    BPKAssertMainThread();
    if (_selectionConfiguration != selectionConfiguration) {
        _selectionConfiguration = selectionConfiguration;
        self.calendarView.allowsMultipleSelection = selectionConfiguration.allowsMultipleSelection;
        for (NSDate *date in self.calendarView.selectedDates) {
            [self.calendarView deselectDate:date];
        }
    }
}

- (void)setContentOffset:(CGPoint)contentOffset {
    self.calendarView.collectionView.contentOffset = contentOffset;
}

- (NSArray<BPKSimpleDate *> *)selectedDates {
    if (self.sameDayRange) {
        // Prevent crashing if we somehow get here and there are no selected dates
        // We should fix this properly by ensuring that sameDayRange is never true when there are 0 selected dates.
        // To fix in BPK-4370
        if (self.calendarView.selectedDates.count == 0) {
            return @[];
        }
        NSArray<NSDate *> *dates = [self.calendarView.selectedDates arrayByAddingObject:self.calendarView.selectedDates.firstObject];
        return [BPKSimpleDate simpleDatesFromDates:dates forCalendar:self.gregorian];
    }

    return [BPKSimpleDate simpleDatesFromDates:self.calendarView.selectedDates forCalendar:self.gregorian];
}

- (NSSet<BPKSimpleDate *> *)createDateSet:(NSArray<NSDate *> *)dates {
    NSMutableSet<BPKSimpleDate *> *set = [[NSMutableSet alloc] initWithCapacity:dates.count];

    for (NSDate *date in dates) {
        BPKSimpleDate *simpleDate = [[BPKSimpleDate alloc] initWithDate:date forCalendar:self.gregorian];

        [set addObject:simpleDate];
    }

    return [set copy];
}

- (void)setSelectedDates:(NSArray<BPKSimpleDate *> *)selectedDates {
    BPKAssertMainThread();
    NSSet<BPKSimpleDate *> *previouslySelectedDates = [self createDateSet:self.calendarView.selectedDates];
    NSSet<BPKSimpleDate *> *newSelectedDates = [NSSet setWithArray:selectedDates];

    for (BPKSimpleDate *date in newSelectedDates) {
        if (![previouslySelectedDates containsObject:date]) {
            [self.calendarView selectDate:[date dateForCalendar:self.gregorian]];
        }
    }

    NSMutableSet *toDeselect = [previouslySelectedDates mutableCopy];
    [toDeselect minusSet:newSelectedDates];

    for (BPKSimpleDate *date in toDeselect) {
        [self.calendarView deselectDate:[date dateForCalendar:self.gregorian]];
    }

    self.sameDayRange = selectedDates.count == 2 && [selectedDates.firstObject isEqual:selectedDates.lastObject];
}

#pragma mark - public methods

- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    if (self.selectedDates.count > 0) {
        [self scrollToDate:self.selectedDates.firstObject];
    }
}

- (void)reloadCalendarData {
    [self.calendarView reloadData];
}

- (void)reloadData {
    [self invalidateVisibleCells];
}

- (void)refreshDateAppearance {
    [self invalidateVisibleCellsIfNeeded];
}

- (void)scrollToDate:(BPKSimpleDate *)date {
    // Scrolling to date only works if this is enabled.
    // See https://github.com/WenchaoD/FSCalendar/issues/875#issuecomment-360024984
    self.calendarView.pagingEnabled = YES;
    NSDate *dateToScrollIntoView = [date dateForCalendar:self.gregorian];
    [self.calendarView selectDate:dateToScrollIntoView scrollToDate:dateToScrollIntoView];
    self.calendarView.pagingEnabled = NO;
}

#pragma mark - <FSCalendarDataSource>

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    BPKCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:CellReuseId forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    return [self.minDate dateForCalendar:self.gregorian];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return [self.maxDate dateForCalendar:self.gregorian];
}

- (void)setDateSelectedBackgroundColor:(UIColor *_Nullable)dateSelectedBackgroundColor {
    if (dateSelectedBackgroundColor != _dateSelectedBackgroundColor) {
        _dateSelectedBackgroundColor = dateSelectedBackgroundColor;
        self.appearance.selectionColor = self.currentDateSelectedBackgroundColor;
        [self.calendarView.collectionView reloadData];
    }
}

- (void)setDateSelectedContentColor:(UIColor *_Nullable)dateSelectedContentColor {
    if (dateSelectedContentColor != _dateSelectedContentColor) {
        _dateSelectedContentColor = dateSelectedContentColor;
        self.appearance.titleSelectionColor = self.currentDateSelectedContentColor;
        [self.calendarView.collectionView reloadData];
    }
}

#pragma mark - <FSCalendarDelegate>

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    BOOL enabled = [self isDateEnabled:date];

    if (!enabled) {
        return NO;
    }

    BOOL shouldClearDates = self.selectionConfiguration.allowsMultipleSelection &&
                            [self.selectionConfiguration shouldClearSelectedDates:self.sortedSelectedDates whenSelectingDate:date];

    if (shouldClearDates) {
        for (NSDate *date in calendar.selectedDates) {
            [calendar deselectDate:date];
        }
    }

    if (self.sameDayRange) {
        self.sameDayRange = NO;
    }

    return YES;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    if (self.sameDayRange || !self.selectionConfiguration.isRangeStyleSelection) {
        self.sameDayRange = NO;
        return YES;
    } else {
        self.sameDayRange = calendar.selectedDates.count < 2;
        for (NSDate *actualDate in calendar.selectedDates) {
            if (![date isEqualToDate:actualDate]) {
                [calendar deselectDate:actualDate];
            }
        }
        [self calendar:self.calendarView didSelectDate:date atMonthPosition:monthPosition];
        return NO;
    }
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    [self configureVisibleCells];
    [self.delegate calendar:self didChangeDateSelection:self.selectedDates];

    [self invalidateVisibleCellsIfNeeded];

    NSString *accessibilityInstruction = [self.selectionConfiguration accessibilityInstructionHavingSelectedDates:self.sortedSelectedDates];
    if (accessibilityInstruction != nil) {
        UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, accessibilityInstruction);
    }
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    [self configureVisibleCells];
    [self.delegate calendar:self didChangeDateSelection:self.selectedDates];

    [self invalidateVisibleCellsIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar
    willDisplayCell:(FSCalendarCell *)cell
            forDate:(NSDate *)date
    atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSDateComponents *components = [self.calendarView.gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:date];
    NSDateComponents *todayComponents = [self.calendarView.gregorian components:NSCalendarUnitYear fromDate:NSDate.date];
    BOOL isDateOutsideCurrentYear = components.year != todayComponents.year;
    BOOL notJanuaryOrDecember = components.month != 1 && components.month != 12;

    if (monthPosition == FSCalendarMonthPositionCurrent && isDateOutsideCurrentYear && notJanuaryOrDecember) {
        self.yearPill.hidden = NO;
        self.yearPill.year = [NSNumber numberWithInteger:components.year];
    } else if (notJanuaryOrDecember) {
        self.yearPill.hidden = YES;
    }

    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

#pragma mark - <FSCalendarDelegateAppearance>

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date {
    if ([self isDateEnabled:date]) {
        if ([self.delegate respondsToSelector:@selector(DONT_USE_calendar:fillColorForDate:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            return [(id<BPKCalendarDelegateExtendedForRN>)self.delegate DONT_USE_calendar:self fillColorForDate:date];
#pragma clang diagnostic pop
        }

        if ([self isDateInToday:date]) {
            return [UIColor clearColor];
        }
    }

    return appearance.borderDefaultColor;
}

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(nonnull NSDate *)date {
    if ([self isDateEnabled:date]) {
        if ([self.delegate respondsToSelector:@selector(DONT_USE_calendar:titleColorForDate:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            return [(id<BPKCalendarDelegateExtendedForRN>)self.delegate DONT_USE_calendar:self titleColorForDate:date];
#pragma clang diagnostic pop
        }

        return self.appearance.titleDefaultColor;
    }

    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint04 darkVariant:BPKColor.skyGrayTint03];
}

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date {
    if ([self isDateInToday:date]) {
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

- (CGPoint)contentOffset {
    return self.calendarView.collectionView.contentOffset;
}

- (UIEdgeInsets)contentInset {
    return self.calendarView.collectionView.contentInset;
}

- (CGSize)contentSize {
    return self.calendarView.collectionView.contentSize;
}

- (BOOL)isDecelerating {
    return self.calendarView.collectionView.isDecelerating;
}

- (BOOL)isDragging {
    return self.calendarView.collectionView.isDragging;
}

- (BOOL)isTracking {
    return self.calendarView.collectionView.isTracking;
}

- (void)configureVisibleCells {
    [self.calendarView.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
      NSDate *date = [self.calendarView dateForCell:obj];
      FSCalendarMonthPosition position = [self.calendarView monthPositionForCell:obj];
      [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCellWithCellData:(BPKCalendarCell *)cell forDate:(NSDate *)date {
    if ([self isDateEnabled:date]) {
        if ([self.delegate respondsToSelector:@selector(calendar:cellDataForDate:)]) {
            BPKSimpleDate *simpleDate = [[BPKSimpleDate alloc] initWithDate:date forCalendar:self.gregorian];

            id cellData = [self.delegate calendar:self cellDataForDate:simpleDate];

            if (cellData != nil) {
                NSAssert([cell isKindOfClass:self.configuration.cellClass], @"Expected cell to have class %@ but instead had class %@",
                         self.configuration.cellClass, cell.class);
                NSAssert([cellData isKindOfClass:self.configuration.cellDataClass], @"Expected cell data to have class %@",
                         self.configuration.cellDataClass);
                if ([cell isKindOfClass:self.configuration.cellClass] && [cellData isKindOfClass:self.configuration.cellDataClass]) {
                    [cell configureWithData:cellData];
                }
            }
        }
    }
}

- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSArray<NSDate *> *sortedSelectedDates = self.sortedSelectedDates;

    BPKCalendarCell *calendarCell = (BPKCalendarCell *)cell;
    [self configureCellWithCellData:calendarCell forDate:date];

    // Configure selection layer
    if (monthPosition == FSCalendarMonthPositionCurrent) {
        SelectionType selectionType = SelectionTypeNone;
        RowType rowType = RowTypeMiddle;

        if (!self.sameDayRange && sortedSelectedDates.count > 1 && self.selectionConfiguration.isRangeStyleSelection) {
            NSDate *minDate = [sortedSelectedDates firstObject];
            NSDate *maxDate = [sortedSelectedDates lastObject];
            BOOL dateInsideRange = [BPKCalendar date:date isBetweenDate:minDate andDate:maxDate];
            if (dateInsideRange) {
                BOOL isMinDate = [date isEqualToDate:minDate];
                BOOL isMaxDate = [date isEqualToDate:maxDate];
                NSCalendar *gregorian = self.calendarView.gregorian;
                NSDate *firstWeekday = [gregorian fs_firstDayOfWeek:date];
                NSDate *lastWeekday = [gregorian fs_lastDayOfWeek:date];
                NSDate *firstDayOfMonth = [gregorian fs_firstDayOfMonth:date];
                NSDate *lastDayOfMonth = [gregorian fs_lastDayOfMonth:date];
                BOOL isRowStart = [gregorian isDate:date inSameDayAsDate:firstWeekday] || [gregorian isDate:date inSameDayAsDate:firstDayOfMonth];
                BOOL isRowEnd = [gregorian isDate:date inSameDayAsDate:lastWeekday] || [gregorian isDate:date inSameDayAsDate:lastDayOfMonth];

                if (isRowStart && isRowEnd) {
                    rowType = RowTypeBoth;
                } else if (isRowStart) {
                    rowType = RowTypeStart;
                } else if (isRowEnd) {
                    rowType = RowTypeEnd;
                }

                if (isMinDate) {
                    selectionType = SelectionTypeLeadingBorder;
                } else if (isMaxDate) {
                    selectionType = SelectionTypeTrailingBorder;
                } else {
                    selectionType = SelectionTypeMiddle;
                }
            }
        } else if ([sortedSelectedDates containsObject:date]) {
            selectionType = self.sameDayRange ? SelectionTypeSameDay : SelectionTypeSingle;
        }

        calendarCell.selectionType = selectionType;
        calendarCell.rowType = rowType;
        NSString *baseAccessibilityLabel = [calendarCell defaultAccessibilityLabelForDate:date formatter:self.dateFormatter];
        calendarCell.accessibilityLabel = [self.selectionConfiguration accessibilityLabelForDate:date
                                                                                   selectedDates:sortedSelectedDates
                                                                                       baseLabel:baseAccessibilityLabel];
        calendarCell.accessibilityHint = [self.selectionConfiguration accessibilityHintForDate:date selectedDates:sortedSelectedDates];

        if ([self isDateEnabled:date]) {
            calendarCell.isAccessibilityElement = YES;
            calendarCell.accessibilityElementsHidden = NO;
        } else {
            // Hides the element from screen-readers to save swiping forever!
            // Not this only takes effect after the cells have been invalidated.
            calendarCell.isAccessibilityElement = NO;
            calendarCell.accessibilityElementsHidden = YES;
        }

        calendarCell.accessibilityTraits = UIAccessibilityTraitButton;
        if (selectionType == SelectionTypeSingle || selectionType == SelectionTypeSameDay || selectionType == SelectionTypeLeadingBorder ||
            selectionType == SelectionTypeTrailingBorder) {
            calendarCell.accessibilityTraits = calendarCell.accessibilityTraits | UIAccessibilityTraitSelected;
        }
    }
}

#pragma mark - helpers

/*
 * This method returns the currently selected dates sorted from earliest to latest.
 * If the same day is selected twice, it will also populate the resulting list twice so that
 * it represents both selections.
 */
- (NSArray<NSDate *> *)sortedSelectedDates {
    NSArray<NSDate *> *selectedDates = [self.calendarView.selectedDates sortedArrayUsingComparator:^NSComparisonResult(NSDate *a, NSDate *b) {
      return [a compare:b];
    }];

    if (self.sameDayRange && selectedDates.count > 0) {
        return @[selectedDates[0], selectedDates[0]];
    }

    return selectedDates;
}

- (void)invalidateVisibleCellsIfNeeded {
    // If the consumer is dynamically disabling dates, we will need to invalidate all cells to ensure that the change is
    // visually reflected.
    if ([self.delegate respondsToSelector:@selector(calendar:isDateEnabled:)]) {
        [self invalidateVisibleCells];
    }
}

- (void)invalidateVisibleCells {
    // This works, but it prevents the selection animation from working 😞
    NSArray<NSIndexPath *> *indexPathsForVisibleItems = [self.calendarView.collectionView indexPathsForVisibleItems];
    [self.calendarView.collectionView reloadItemsAtIndexPaths:indexPathsForVisibleItems];
}

- (BOOL)isDateEnabled:(NSDate *)date {
    NSDate *minDate = [self.minDate dateForCalendar:self.gregorian];
    NSDate *maxDate = [self.maxDate dateForCalendar:self.gregorian];

    BOOL dateFallsBetweenMinAndMaxDates = [BPKCalendar date:date isBetweenDate:minDate andDate:maxDate];

    // If the date is outside min and max dates, then it should definitely be disabled.
    if (!dateFallsBetweenMinAndMaxDates) {
        return false;
    }

    // If the consumer has implemented `isDateEnabled` then we should respect that
    if ([self.delegate respondsToSelector:@selector(calendar:isDateEnabled:)]) {
        BPKSimpleDate *simpleDate = [[BPKSimpleDate alloc] initWithDate:date forCalendar:self.gregorian];
        return [self.delegate calendar:self isDateEnabled:simpleDate];
    }

    // Gonna return true, because in the words of Sia, I'm still here...
    return true;
}

- (BOOL)isDateInToday:(NSDate *)date {
    return [self.calendarView.gregorian isDateInToday:date];
}

+ (BOOL)date:(NSDate *)date isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate {
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

- (id)forwardingTargetForSelector:(SEL)selector {
    if ([self.calendarView respondsToSelector:selector]) {
        return self.calendarView;
    }
    return [super forwardingTargetForSelector:selector];
}

#pragma mark - Getters

- (UIColor *)currentDateSelectedBackgroundColor {
    return self.dateSelectedBackgroundColor != nil ? self.dateSelectedBackgroundColor : BPKColor.primaryColor;
}

- (UIColor *)currentDateSelectedContentColor {
    return self.dateSelectedContentColor != nil
               ? self.dateSelectedContentColor
               : [BPKColor dynamicColorWithLightVariant:BPKColor.textPrimaryDarkColor darkVariant:BPKColor.textPrimaryLightColor];
}

@end
NS_ASSUME_NONNULL_END
