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

import SwiftUI

/// `BPKCalendar` is a SwiftUI view that represents a calendar.
///
/// This view is designed to be customizable and flexible. It allows you to specify the type of selection,
///     the calendar system, and the valid range of dates.
///
/// - Parameters:
///   - selectionType: The type of selection that the calendar should support. This can be single, range, or multiple.
///   - calendar: The calendar system that the calendar should use. This can be any calendar system supported by
///     the `Calendar` struct in Swift.
///   - validRange: The range of dates that the calendar should allow the user to select.
///     This is specified as a`ClosedRange<Date>`.
///   - initialMonthScroll: The initial scrolling to the month using `MonthScroll`
///   - calendarSelectionHandler: Optional date selection handler which handles a tapped date and returns new selection
///   - showFloatYearLabel: Set weather the floating year label should be displayed or not
///   - highlightedDates: It's an optional set of dates to put these dates in a circle to highlight them for users.
///   - dayAccessoryView: An additional optional view with extra information beneath the date
///
/// The `BPKCalendar` view also allows you to specify an accessory action. This is a closure that takes a string and
///     a date, and is called when the user interacts with an accessory in the calendar.
public struct BPKCalendar<DayAccessoryView: View>: View {
    let calendar: Calendar
    let selectionType: CalendarSelectionType
    let validRange: ClosedRange<Date>
    private var accessoryAction: ((Date) -> CalendarMonthAccessoryAction?)?
    private var onScrollToMonthAction: ((Date) -> Void)?
    private var scrollDebounceThreshold: Int
    private var initialMonthScroll: MonthScroll?
    private let monthHeaderDateFormatter: DateFormatter
    private let singleCalendarSelectionHandler: SingleCalendarSelectionHandler
    private let rangeCalendarSelectionHandler: RangeCalendarSelectionHandler
    private let showFloatYearLabel: Bool
    private let highlightedDates: Set<Date>?
    private let dayAccessoryView: (Date) -> DayAccessoryView
    @State private var currentlyShownMonth: Date
    
    public init(
        selectionType: CalendarSelectionType,
        calendar: Calendar,
        validRange: ClosedRange<Date>,
        initialMonthScroll: MonthScroll? = nil,
        scrollDebounceThreshold: Int = 200,
        singleCalendarSelectionHandler: SingleCalendarSelectionHandler? = nil,
        rangeCalendarSelectionHandler: RangeCalendarSelectionHandler? = nil,
        showFloatYearLabel: Bool = true,
        highlightedDates: Set<Date>? = nil,
        dayAccessoryView: @escaping (Date) -> DayAccessoryView = { _ in EmptyView()}
    ) {
        self.dayAccessoryView = dayAccessoryView
        _currentlyShownMonth = State(initialValue: validRange.lowerBound)
        self.validRange = validRange
        self.calendar = calendar
        self.selectionType = selectionType
        self.initialMonthScroll = initialMonthScroll
        self.scrollDebounceThreshold = scrollDebounceThreshold
        self.showFloatYearLabel = showFloatYearLabel
        self.highlightedDates = highlightedDates
        self.singleCalendarSelectionHandler = singleCalendarSelectionHandler ?? DefaultSingleCalendarSelectionHandler()
        self.rangeCalendarSelectionHandler = rangeCalendarSelectionHandler ?? DefaultRangeCalendarSelectionHandler()
        
        monthHeaderDateFormatter = DateFormatter()
        monthHeaderDateFormatter.timeZone = calendar.timeZone
        monthHeaderDateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "MMMM yyyy",
            options: 0,
            locale: Locale.current
        )
    }
    
    public var body: some View {
        GeometryReader { calendarProxy in
            VStack(spacing: BPKSpacing.none) {
                CalendarHeader(calendar: calendar)
                ZStack {
                    CalendarTypeContainerFactory(
                        selectionType: selectionType,
                        calendar: calendar,
                        singleCalendarSelectionHandler: singleCalendarSelectionHandler,
                        rangeCalendarSelectionHandler: rangeCalendarSelectionHandler,
                        validRange: validRange,
                        monthScroll: initialMonthScroll,
                        onScrollToMonth: { date in
                            onScrollToMonthAction?(date)
                        },
                        scrollDebounceThreshold: scrollDebounceThreshold,
                        calculator: InMemoryCacheCalendarGridCalculator(
                            decoratee: DefaultCalendarGridCalculator(calendar: calendar)
                        ),
                        parentProxy: calendarProxy,
                        highlightedDates: highlightedDates,
                        monthHeader: { monthHeader(monthDate: $0, calendarProxy: calendarProxy) },
                        dayAccessoryView: dayAccessoryView
                    )
                    if showFloatYearLabel {
                        yearBadge
                    }
                }
            }
        }
    }
    
    private func monthHeader(monthDate: Date, calendarProxy: GeometryProxy) -> some View {
        CalendarMonthHeader(
            monthDate: monthDate,
            dateFormatter: monthHeaderDateFormatter,
            calendar: calendar,
            validRange: validRange,
            accessoryAction: accessoryAction,
            currentlyShownMonth: $currentlyShownMonth,
            parentProxy: calendarProxy
        )
    }
    
    private var yearBadge: some View {
        VStack {
            CalendarBadge(
                currentlyShownMonth: currentlyShownMonth,
                calendar: calendar
            )
            .padding(.top, .base)
            Spacer()
        }
    }
    
    /// Sets the accessory action for the calendar to be applied to each month, based on the give month `Date`.
    public func monthAccessoryAction(_ action: ((Date) -> CalendarMonthAccessoryAction?)?) -> BPKCalendar {
        var result = self
        result.accessoryAction = action
        return result
    }
    
    /// Sets CTA call for when scrolling landed in the calendar,
    /// returning the first day of landed month inside the action.
    public func onScrollToMonthAction(_ action: @escaping ((Date) -> Void)) -> BPKCalendar {
        var result = self
        result.onScrollToMonthAction = action
        return result
    }
}

struct BPKCalendar_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let minValidDate = calendar.date(from: .init(year: 2023, month: 10, day: 12))!
        let maxValidDate = calendar.date(from: .init(year: 2025, month: 12, day: 2))!
        
        let minSelectedDate = calendar.date(from: .init(year: 2023, month: 11, day: 19))!
        let maxSelectedDate = calendar.date(from: .init(year: 2023, month: 11, day: 30))!
        
        return BPKCalendar(
            selectionType: .range(
                selection: .constant(.range(minSelectedDate...maxSelectedDate)),
                accessibilityConfigurations: .init(
                    startSelectionHint: "",
                    endSelectionHint: "",
                    startSelectionState: "",
                    endSelectionState: "",
                    betweenSelectionState: "",
                    startAndEndSelectionState: "",
                    returnDatePrompt: ""
                )
            ),
            calendar: calendar,
            validRange: minValidDate...maxValidDate,
            dayAccessoryView: { _ in
                BPKText("20", style: .caption)
            }
        )
        .monthAccessoryAction { _ in
            return CalendarMonthAccessoryAction(title: "Select whole month", action: .custom({ _ in }))
        }
    }
}
