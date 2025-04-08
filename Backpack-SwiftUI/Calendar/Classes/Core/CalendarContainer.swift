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
import Combine

struct CalendarContainer<MonthContent: View>: View {
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    let parentProxy: GeometryProxy
    let monthScroll: MonthScroll?
    let onScrollToMonth: ((Date) -> Void)?
    @ViewBuilder let monthContent: (_ month: Date) -> MonthContent

    @State private var hasScrolledToItem = false
    @StateObject private var visibilityObserver: ItemVisibilityObserver

    init(
        calendar: Calendar,
        validRange: ClosedRange<Date>,
        parentProxy: GeometryProxy,
        monthScroll: MonthScroll?,
        onScrollToMonth: ((Date) -> Void)?,
        monthContent: @escaping (_ month: Date) -> MonthContent
    ) {
        _visibilityObserver = StateObject(wrappedValue: ItemVisibilityObserver(parentProxy: parentProxy))
        self.calendar = calendar
        self.validRange = validRange
        self.parentProxy = parentProxy
        self.monthScroll = monthScroll
        self.onScrollToMonth = onScrollToMonth
        self.monthContent = monthContent
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: BPKSpacing.none) {
                    ForEach(0...monthsToShow, id: \.self) { monthIndex in
                        let firstDayOfMonth = firstDayOf(monthIndex: monthIndex)
                        monthContent(firstDayOfMonth)
                            .if(monthScroll != nil, transform: { view in
                                view.id(scrollId(date: firstDayOfMonth))
                            })
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .preference(
                                            key: ItemVisibilityPreferenceKey.self,
                                            value: [monthIndex: geo.frame(in: .global)]
                                        )
                                }

                            )
                    }
                    .onAppear {
                        scrollIfNeeded(scrollProxy: proxy)
                    }
                }
                .onPreferenceChange(ItemVisibilityPreferenceKey.self) { preferences in
                    visibilityObserver.updatePreferences(preferences)
                }
                .onChange(of: visibilityObserver.visibleItems) { newVisibleItems in
                    updateOnScrollToMonthHandler(newVisibleItems: newVisibleItems)
                }
            }
        }
    }

    private func updateOnScrollToMonthHandler(newVisibleItems: [Int]? = nil) {
        guard let topMostVisibleMonthIndex = (newVisibleItems ?? visibilityObserver.visibleItems).sorted().first else {
            return
        }
        onScrollToMonth?(firstDayOf(monthIndex: topMostVisibleMonthIndex))
    }

    /// Generates a unique identifier for a given `Date` using the "yyyy-MM" format.
    /// - Example: For a date of December 25, 2024, this method returns `"2024-12"`.
    private func scrollId(date: Date) -> String? {
        return monthScroll?.formatter.string(from: date)
    }

    private func scrollIfNeeded(scrollProxy: ScrollViewProxy) {
        guard !hasScrolledToItem, let monthScroll else { return }
        hasScrolledToItem = true
        let scrollAction = {
            scrollProxy.scrollTo(
                monthScroll.scrollId,
                anchor: monthScroll.anchor
            )
        }

        monthScroll.animated ? withAnimation { scrollAction() } : scrollAction()
    }

    private var monthsToShow: Int {
        let firstMonthComponents = calendar.dateComponents([.year, .month], from: validRange.lowerBound)
        let firstMonth = calendar.date(from: firstMonthComponents)!
        let components = calendar.dateComponents([.year, .month], from: firstMonth, to: validRange.upperBound)
        return components.month! + components.year! * 12
    }

    private func firstDayOf(monthIndex: Int) -> Date {
        let month = calendar.date(
            byAdding: .init(month: monthIndex),
            to: validRange.lowerBound
        )!
        return calendar.date(
            from: calendar.dateComponents(
                [.year, .month],
                from: month
            )
        )!
    }
}

struct CalendarContainer_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 10, day: 30))!
        let end = calendar.date(from: .init(year: 2025, month: 12, day: 25))!
        let monthScroll = MonthScroll(monthToScroll: start)

        GeometryReader { proxy in
            CalendarContainer(
                calendar: calendar,
                validRange: start...end,
                parentProxy: proxy,
                monthScroll: monthScroll,
                onScrollToMonth: nil,
                monthContent: { monthNumber in
                    VStack {
                        BPKText("Calendar Grid \(monthNumber)")
                        Divider()
                    }
                }
            )
        }
    }
}
