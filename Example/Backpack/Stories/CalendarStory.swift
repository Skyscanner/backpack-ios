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

import Foundation

enum CalendarStory: String, StoryGroup {
    case `default` = "Default"
    case withMaxEnabledDate = "With max enabled date"
    case withCustomStyles = "Custom styles for specific dates"
    case withPrices = "With prices"
    case alternativeBackgroundColor = "With alternate background color"
    case preselectedDates = "With preselected dates"

    var title: String {
        self.rawValue
    }

    var presentableStory: Presentable {
        let storyboard = loadStoryboard(name: "Calendar")
        let presentable = storyboard("CalendarViewController")

        return presentable.enrich {
            guard let calendarVC = $0 as? CalendarViewController else { return }

            switch self {
            case .default:
                break
            case .withMaxEnabledDate:
                calendarVC.maxEnabledDate = true
            case .withCustomStyles:
                calendarVC.customStylesForDates = true
            case .withPrices:
                calendarVC.showPrices = true
            case .alternativeBackgroundColor:
                calendarVC.alternativeBackgroundColor = true
            case .preselectedDates:
                let startingDate = BPKSimpleDate(year: 2020, month: 1, day: 1)
                let selectedDate1 = BPKSimpleDate(year: startingDate.year, month: startingDate.month + 2, day: 12)
                let selectedDate2 = BPKSimpleDate(year: startingDate.year, month: startingDate.month + 2, day: 20)
                calendarVC.preselectedDates = (selectedDate1, selectedDate2)
                calendarVC.minDate = startingDate
            }
        }
    }
}
