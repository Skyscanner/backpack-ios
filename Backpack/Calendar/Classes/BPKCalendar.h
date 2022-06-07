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

@class BPKCalendar;
@class BPKSimpleDate;
@class BPKCalendarConfiguration;
@class BPKCalendarSelectionConfiguration;

@protocol BPKCalendarPresenting;

NS_ASSUME_NONNULL_BEGIN

/**
 * Delegate for configuring and respodning to interactions in a calendar.
 */
@protocol BPKCalendarDelegate <NSObject>

/**
 * Called when a date selection changed.
 *
 * @param calendar The backpack calendar.
 * @param dateList List of selected dates.
 */
- (void)calendar:(BPKCalendar *)calendar didChangeDateSelection:(NSArray<BPKSimpleDate *> *)dateList;

@optional

/**
 * Called when the calendar was scrolled
 * @param calendar The backpack calendar.
 * @param contentOffset The content offset
 */
- (void)calendar:(BPKCalendar *)calendar didScroll:(CGPoint)contentOffset;

/**
 * Called when the calendar renders each cell.
 *
 * @param calendar The backpack calendar.
 * @param date The date to check for enabledness.
 * @return Whether the cell for the given date is enabled.
 */
- (BOOL)calendar:(BPKCalendar *)calendar isDateEnabled:(BPKSimpleDate *)date;

/**
 * Asks the delegate for cell data for a specific date.
 *
 * @param calendar The backpack calendar requesting the data.
 * @param date The date to provide the data for.
 * @return The cell data to use for this date.
 */
- (id _Nullable)calendar:(BPKCalendar *)calendar cellDataForDate:(BPKSimpleDate *)date;

/**
 * Called when a whole month is selected.
 *
 * @param calendar The backpack calendar.
 * @param dateList The selected dates that represet the whole month selected.
 */
- (void)calendar:(BPKCalendar *)calendar didSelectWholeMonth:(NSArray<BPKSimpleDate *> *)dateList;

@end

/**
 * `BPKCalendar` contains a `FSCalendar` configured with Skyscanner style properties.
 */
@interface BPKCalendar : UIView

/// :nodoc:
@property(nullable, nonatomic, strong) UIColor *dateSelectedContentColor UI_APPEARANCE_SELECTOR;

/// :nodoc:
@property(nullable, nonatomic, strong) UIColor *dateSelectedBackgroundColor UI_APPEARANCE_SELECTOR;

/**
 * Create a calendar with given minimum date and maximum date.
 *
 * @param minDate The minimum date that can be selected in the calendar.
 * @param maxDate The maximum date that can be selected in the calendar.
 * @param selectionConfiguration The configuration to use to handle selection logic.
 * @return A configured calendar.
 */
- (instancetype)initWithMinDate:(BPKSimpleDate *)minDate
                        maxDate:(BPKSimpleDate *)maxDate
         selectionConfiguration:(BPKCalendarSelectionConfiguration *)selectionConfiguration NS_DESIGNATED_INITIALIZER;

/**
 * Create a calendar with given minimum date and maximum date.
 *
 * @param minDate The minimum date that can be selected in the calendar.
 * @param maxDate The maximum date that can be selected in the calendar.
 * @param configuration The configuration to use. By default this will be `BPKCalendarTrafficLightConfiguration`
 * @param selectionConfiguration The configuration to use to handle selection logic.
 * @see BPKCalendarTrafficLightConfiguration
 * @param presenter The one responsible for the logic related to dates calculation.
 * @return A configured calendar.
 */
- (instancetype)initWithMinDate:(BPKSimpleDate *)minDate
                        maxDate:(BPKSimpleDate *)maxDate
                  configuration:(BPKCalendarConfiguration *)configuration
         selectionConfiguration:(BPKCalendarSelectionConfiguration *)selectionConfiguration
                      presenter:(NSObject<BPKCalendarPresenting> *)presenter;

/**
 * Create a calendar with given minimum date and maximum date.
 *
 * @param minDate The minimum date that can be selected in the calendar.
 * @param maxDate The maximum date that can be selected in the calendar.
 * @param configuration The configuration to use. By default this will be `BPKCalendarTrafficLightConfiguration`
 * @param selectionConfiguration The configuration to use to handle selection logic.
 * @see BPKCalendarTrafficLightConfiguration
 * @return A configured calendar.
 */
- (instancetype)initWithMinDate:(BPKSimpleDate *)minDate
                        maxDate:(BPKSimpleDate *)maxDate
                  configuration:(BPKCalendarConfiguration *)configuration
         selectionConfiguration:(BPKCalendarSelectionConfiguration *)selectionConfiguration;

/**
 * Create a calendar with given configuration
 *
 * @param configuration The configuration to use. By default this will be `BPKCalendarTrafficLightConfiguration`
 * @param selectionConfiguration The configuration to use to handle selection logic.
 * @see BPKCalendarTrafficLightConfiguration
 * @return A configured calendar.
 */
- (instancetype)initWithConfiguration:(BPKCalendarConfiguration *)configuration
               selectionConfiguration:(BPKCalendarSelectionConfiguration *)selectionConfiguration;

/// :nodoc:
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/// :nodoc:
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * The calendar configuration.
 */
@property(nonatomic, strong, nonnull, readonly) BPKCalendarConfiguration *configuration;

/**
 * The active calendar being used by the reciever.
 */
@property(nonatomic, strong, nonnull, readonly) NSCalendar *gregorian;

/**
 * Locale used for displaying name of days and months
 */
@property(copy, nonatomic) NSLocale *locale;

/**
 * Type of selection allowed
 */
@property(nonatomic, strong) BPKCalendarSelectionConfiguration *selectionConfiguration;

/**
 * List of selected dates
 */
@property(nonatomic, copy) NSArray<BPKSimpleDate *> *selectedDates;

/**
 * The earliest date that the user is allowed to select
 */
@property(nonatomic, strong) BPKSimpleDate *minDate;

/**
 * The latest date that the user is able to see
 */
@property(nonatomic, strong) BPKSimpleDate *maxDate;

/**
 * The underlying scrollView's content offset
 */
@property(nonatomic, assign) CGPoint contentOffset;

/**
 * The underlying scrollView's content inset
 */
@property(readonly) UIEdgeInsets contentInset;

/**
 * The underlying scrollView's content size
 */
@property(readonly) CGSize contentSize;

/**
 * The underlying scrollView's isDecelerating
 */
@property(readonly) BOOL isDecelerating;

/**
 * The underlying scrollView's isTracking
 */
@property(readonly) BOOL isTracking;

/**
 * The underlying scrollView's isDragging
 */
@property(readonly) BOOL isDragging;

/**
 * Whether selecting a whole month is allowed or not
 */
@property(readonly) BOOL allowsWholeMonthSelection;

/**
 * The title for the whole month button
 */
@property(readonly, nonatomic, strong) NSString *_Nullable wholeMonthTitle;

/**
 * The calendar's delegate
 */
@property(nonatomic, nullable, weak) id<BPKCalendarDelegate> delegate;

/**
 * Reloads all dates displayed in the receiver.
 */
- (void)reloadData;

/**
 * Refreshes the UI of every visible cell.
 */
- (void)refreshDateAppearance;

/**
 * Scrolls the month of the given date into view.
 * @param date The date to scroll into view
 */
- (void)scrollToDate:(BPKSimpleDate *)date;

/**
 * Selects the indicated whole month.
 * @param month The month to be selected.
 */
- (void)selectWholeMonth:(BPKSimpleDate *)month;

/**
 * Wheteher the whole month button is enabled for a given month.
 * @param month A date representing the month.
 * * @return `FALSE` if the month is previous to the `minDate`, `TRUE` otherwise.
 */
- (BOOL)isWholeMonthButtonEnabledForMonth:(BPKSimpleDate *)month;

@end
NS_ASSUME_NONNULL_END
