//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

import UIKit
import Backpack.Calendar
import Backpack.SimpleDate

class CalendarViewController: UIViewController, BPKCalendarDelegate {
    var maxEnabledDate: Bool = false
    var customStylesForDates = false
    var showPrices = false
    var alternativeBackgroundColor = false
    var preselectedDates = false
    var currentMaxEnabledDate: Date?
    var calendar = BPKCalendar()
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var lowPrice = BPKCalendarPriceLabelCellData(price: "£14", labelStyle: BPKCalendarPriceLabelStyle.positive)
    var mediumPrice = BPKCalendarPriceLabelCellData(price: "£28", labelStyle: BPKCalendarPriceLabelStyle.noData)
    var highPrice = BPKCalendarPriceLabelCellData(price: "£480", labelStyle: BPKCalendarPriceLabelStyle.negative)
    var noPrice = BPKCalendarPriceLabelCellData(price: "–", labelStyle: BPKCalendarPriceLabelStyle.noData)

    var singleSelectionConfiguration = BPKCalendarSelectionConfigurationSingle(
        selectionHint: "Double tap to select date"
    )
    var multipleSelectionConfiguration = BPKCalendarSelectionConfigurationMultiple(
        selectionHint: "Double tap to select date",
        deselectionHint: "Double tap to deselect date"
    )
    var rangeSelectionConfiguration = BPKCalendarSelectionConfigurationRange(
        firstSelectionHint: "Double tap to select departure date",
        secondSelectionHint: "Double tap to select return date",
        firstSelectionState: "Selected as departure date",
        secondSelectionState: "Selected as return date",
        betweenSelectionState: "Between departure and return date",
        firstAndSecondSelectionState: "Selected as both departure and return date",
        returnDatePrompt: "Now please select a return date"
    )

    override func viewDidLoad() {
        // I guess it shouldn't be possible to create a calendar without a selection config 🤔
        calendar.selectionConfiguration = singleSelectionConfiguration

        if showPrices {
            calendar = BPKCalendar(
                configuration: BPKCalendarPriceLabelConfiguration(),
                selectionConfiguration: singleSelectionConfiguration
            )
        }
        if preselectedDates {
            segmentedControl.selectedSegmentIndex = 1
            calendar.selectionConfiguration = rangeSelectionConfiguration

            let currentDate = BPKSimpleDate(date: Date(), for: calendar.gregorian)
            let selectedDate1 = BPKSimpleDate(year: currentDate.year, month: currentDate.month + 2, day: 12)
            let selectedDate2 = BPKSimpleDate(year: currentDate.year, month: currentDate.month + 2, day: 20)
            calendar.selectedDates = [selectedDate1, selectedDate2]
        }
        myView.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.leadingAnchor.constraint(equalTo: myView.leadingAnchor),
            calendar.topAnchor.constraint(equalTo: myView.topAnchor),
            myView.trailingAnchor.constraint(equalTo: calendar.trailingAnchor),
            myView.bottomAnchor.constraint(equalTo: calendar.bottomAnchor)
        ])
        calendar.minDate = BPKSimpleDate(date: Date(), for: calendar.gregorian)
        calendar.locale = Locale.current
        calendar.delegate = self
        if alternativeBackgroundColor {
            view.backgroundColor = BPKColor.backgroundSecondaryColor
            myView.backgroundColor = BPKColor.backgroundSecondaryColor
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { _ in self.calendar.reloadData() })
    }

    // Pragma mark: SegmentedControlDelegate

    @IBAction func valueChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            calendar.selectionConfiguration = singleSelectionConfiguration
        case 1:
            calendar.selectionConfiguration = rangeSelectionConfiguration
        case 2:
            calendar.selectionConfiguration = multipleSelectionConfiguration
        default:
            calendar.selectionConfiguration = singleSelectionConfiguration
        }
        calendar.reloadData()
    }

    // Pragma mark: CalendarDelegate

    func calendar(_ calendar: BPKCalendar, didChangeDateSelection dateList: [BPKSimpleDate]) {
        print("calendar:", calendar, "didChangeDateSelection:", dateList)

        if self.maxEnabledDate {
            if dateList.count == 0 {
                self.currentMaxEnabledDate = nil
            } else {
                let lastSelectedDate = dateList.first
                let newMaxDate = BPKSimpleDate(year: lastSelectedDate!.year,
                                               month: lastSelectedDate!.month + 1,
                                               day: lastSelectedDate!.day)
                self.currentMaxEnabledDate = newMaxDate.date(for: calendar.gregorian)
            }
        }
    }

    func calendar(_ calendar: BPKCalendar, didScroll contentOffset: CGPoint) {
        print("calendar:", calendar, "didScroll:", contentOffset, "isTracking:", calendar.isTracking)
    }

    // Disables dates that are > 1 month ahead of the selected date.
    func calendar(_ calendar: BPKCalendar, isDateEnabled date: BPKSimpleDate) -> Bool {
        let nativeDate = date.date(for: calendar.gregorian)
        if self.currentMaxEnabledDate == nil {
            return true
        }

        // If date > self.currentMaxEnabledDate, return false
        if nativeDate.compare(self.currentMaxEnabledDate!) == .orderedDescending {
            return false
        }
        return true
    }

    func calendar(_ calendar: BPKCalendar, cellDataFor date: BPKSimpleDate) -> Any? {
        if !customStylesForDates && !showPrices {
            return nil
        }
        let gregorian = calendar.gregorian
        let convertedDate = date.date(for: gregorian)
        let date1 = gregorian.startOfDay(for: Date())
        let date2 = gregorian.startOfDay(for: convertedDate)
        let components = gregorian.dateComponents([.day], from: date1, to: date2)
        guard let daysCount = components.day else { return nil }

        if daysCount == 2 || daysCount == 8 || daysCount == 12 || daysCount == 20 {
            return showPrices ? lowPrice : BPKCalendarTrafficLightCellData.positive
        }

        if daysCount == 4 || daysCount == 10 || daysCount == 15 || daysCount == 24 {
            return showPrices ? highPrice : BPKCalendarTrafficLightCellData.negative
        }

        if daysCount == 1 || daysCount == 3 || daysCount == 11 || daysCount == 22 {
            return showPrices ? mediumPrice : BPKCalendarTrafficLightCellData.neutral
        }

        return showPrices ? noPrice : BPKCalendarTrafficLightCellData.noData
    }
}
