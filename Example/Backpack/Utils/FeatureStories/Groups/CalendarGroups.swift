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

@MainActor
struct CalendarGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        enrich: @escaping (CalendarViewController) -> Void
    ) -> CellDataSource {
        PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Calendar", on: "CalendarViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    private func presentableCalendar<Content: View>(
        _ title: String,
        view: Content
    ) -> CellDataSource {
        PresentableCellDataSource.custom(
            title: title,
            customController: { ContentUIHostingController(view) },
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Default") { _ in },
                presentable("With max enabled date") { $0.maxEnabledDate = true },
                presentable("Custom styles for specific dates") { $0.customStylesForDates = true },
                presentable("With prices") { $0.showPrices = true },
                presentable("With alternate background color") { $0.alternativeBackgroundColor = true },
                presentable("With preselected dates") { vController in
                    let startingDate = BPKSimpleDate(year: 2020, month: 1, day: 1)
                    vController.preselectedDates = (
                        BPKSimpleDate(year: startingDate.year, month: startingDate.month + 2, day: 12),
                        BPKSimpleDate(year: startingDate.year, month: startingDate.month + 2, day: 20)
                    )
                    vController.minDate = startingDate
                }
            ]
        ).groups()
    }
    
    func swiftUIGroups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentableCalendar("Range Selection", view: CalendarExampleRangeView(showAccessoryViews: false)),
                presentableCalendar("Single Selection", view: CalendarExampleSingleView()),
                presentableCalendar("With Accessory Views", view: CalendarExampleRangeView(showAccessoryViews: true)),
                presentableCalendar(
                    "With No Float Year Labelst",
                    view: CalendarExampleRangeView(showAccessoryViews: false, showFloatYearLabel: false)
                ),
                presentableCalendar(
                    "Single Selection with highlighted dates",
                    view: CalendarExampleSingleView(includeHighlightedDates: true)
                ),
                presentableCalendar(
                    "With Initial Month Scrolling",
                    view: CalendarExampleRangeView(showAccessoryViews: false, makeInitialMonthScroll: true)
                ),
                presentableCalendar(
                    "With Initial Month Scrolling and animation",
                    view: CalendarExampleSingleView(makeInitialMonthScrollWithAnimation: true)
                ),
                presentableCalendar(
                    "Dynamic Selection",
                    view: CalendarExampleDynamicView()
                )
            ]
        ).groups()
    }
}
