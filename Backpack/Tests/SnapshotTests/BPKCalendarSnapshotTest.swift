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

import XCTest
import Backpack
import SnapshotTesting

final class BPKCalendarSnapshotTest: XCTestCase, BPKCalendarDelegate {
    
    let date1 = Date(timeIntervalSince1970: 2175767888)
    let date2 = Date(timeIntervalSince1970: 2176026888)
    let date3 = Date(timeIntervalSince1970: 2177754888)
    let date4 = Date(timeIntervalSince1970: 2188122888)
    
    var isColoringDates: Bool!
    var isShowingPrices: Bool!
    
    var sut: BPKCalendar!
    var snapshotView: UIView!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        isRecording = false
    
        isColoringDates = false
        isShowingPrices = false
        
        sut = BPKCalendar()
        snapshotView = setupViews(calendar: sut)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        snapshotView = nil
        try? super.tearDownWithError()
    }
    
    func testCalendarWithoutSelection() {
        // Given
        sut.selectionConfiguration = BPKCalendarSelectionConfigurationSingle(selectionHint: "")
        sut.selectedDates = [BPKSimpleDate(date: date1, for: sut.gregorian)]
        sut.reloadData()
        
        // When
        sut.selectedDates = []
        sut.reloadData()
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testCalendarWithSingleSelection() {
        // Given
        sut.selectionConfiguration = BPKCalendarSelectionConfigurationSingle(selectionHint: "")
        
        // When
        sut.selectedDates = [BPKSimpleDate(date: date1, for: sut.gregorian)]
        sut.reloadData()
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testCalendarWithSingleSelectionAndCustomDisabledDates() {
        // Given
        sut.selectionConfiguration = BPKCalendarSelectionConfigurationSingle(selectionHint: "")
        sut.delegate = self
        
        // When
        sut.selectedDates = [BPKSimpleDate(date: date1, for: sut.gregorian)]
        sut.reloadData()
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testCalendarWithSelectedDateInFuture() {
        // Given
        sut.selectionConfiguration = BPKCalendarSelectionConfigurationSingle(selectionHint: "")
        
        // When
        sut.selectedDates = [BPKSimpleDate(date: date4, for: sut.gregorian)]
        sut.reloadData()
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testCalendarWithRangeSelection() {
        // Given
        sut.selectionConfiguration = BPKCalendarSelectionConfigurationRange(
            startSelectionHint: "",
            endSelectionHint: "",
            startSelectionState: "",
            endSelectionState: "",
            betweenSelectionState: "",
            startAndEndSelectionState: "",
            returnDatePrompt: ""
        )
        
        // When
        sut.selectedDates = [
            BPKSimpleDate(date: date1, for: sut.gregorian),
            BPKSimpleDate(date: date2, for: sut.gregorian)
        ]
        
        sut.reloadData()
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testCalendarWithLongRangeSelection() {
        // Given
        sut.selectionConfiguration = BPKCalendarSelectionConfigurationRange(
            startSelectionHint: "",
            endSelectionHint: "",
            startSelectionState: "",
            endSelectionState: "",
            betweenSelectionState: "",
            startAndEndSelectionState: "",
            returnDatePrompt: ""
        )
        
        // When
        sut.selectedDates = [
            BPKSimpleDate(date: date1, for: sut.gregorian),
            BPKSimpleDate(date: date3, for: sut.gregorian)
        ]
        
        sut.reloadData()
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testCalendarWithRangeSelectionWithTheme() {
        // Given
        sut.selectionConfiguration = BPKCalendarSelectionConfigurationRange(
            startSelectionHint: "",
            endSelectionHint: "",
            startSelectionState: "",
            endSelectionState: "",
            betweenSelectionState: "",
            startAndEndSelectionState: "",
            returnDatePrompt: ""
        )
        
        // When
        sut.selectedDates = [
            BPKSimpleDate(date: date1, for: sut.gregorian),
            BPKSimpleDate(date: date2, for: sut.gregorian)
        ]
        
        sut.dateSelectedContentColor = BPKColor.statusDangerFillColor
        sut.dateSelectedBackgroundColor = BPKColor.statusDangerFillColor
        
        sut.reloadData()
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testCalendarWithMultipleSelection() {
        // Given
        sut.selectionConfiguration = BPKCalendarSelectionConfigurationMultiple(selectionHint: "", deselectionHint: "")
        
        // When
        sut.selectedDates = [
            BPKSimpleDate(date: date1, for: sut.gregorian),
            BPKSimpleDate(date: date2, for: sut.gregorian)
        ]
        
        sut.reloadData()
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testCalendarWithCustomColorDates() {
        // Given
        sut.selectionConfiguration = BPKCalendarSelectionConfigurationSingle(selectionHint: "")
        isColoringDates = true
        sut.delegate = self
        
        // When
        sut.selectedDates = [BPKSimpleDate(date: date1, for: sut.gregorian)]
        sut.reloadData()
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testCalendarWithPriceLabels() {
        // Given
        let customCalendar = BPKCalendar(
            configuration: BPKCalendarPriceLabelConfiguration(),
            selectionConfiguration: BPKCalendarSelectionConfigurationSingle(selectionHint: "")
        )
        
        let customSnapshotView = setupViews(calendar: customCalendar)

        // When
        customCalendar.selectedDates = [BPKSimpleDate(date: date1, for: sut.gregorian)]
        isShowingPrices = true
        customCalendar.delegate = self
        customCalendar.reloadData()
        
        // Then
        assertSnapshot(customSnapshotView)
    }
    
    func testCalendarWithWholeMonthButton() {
        // Given
        sut.selectionConfiguration = BPKCalendarSelectionConfigurationRange(
            startSelectionHint: "",
            endSelectionHint: "",
            startSelectionState: "",
            endSelectionState: "",
            betweenSelectionState: "",
            startAndEndSelectionState: "",
            returnDatePrompt: "",
            andWholeMonthTitle: "Select whole month"
        )
        
        // When
        sut.selectWholeMonth(BPKSimpleDate(date: date1, for: sut.gregorian))
        sut.reloadData()
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    // MARK: Helpers
    private func setupViews(calendar: BPKCalendar) -> UIView {
        let snapshotView = UIView()
        snapshotView.backgroundColor = BPKColor.canvasColor
        
        [calendar, snapshotView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        snapshotView.addSubview(calendar)
        
        let screenSize = CGSize(width: 375, height: 667) // iPhone 8 screen dimensions
        NSLayoutConstraint.activate([
            snapshotView.widthAnchor.constraint(equalToConstant: screenSize.width),
            snapshotView.heightAnchor.constraint(equalToConstant: screenSize.height),
            
            calendar.leadingAnchor.constraint(equalTo: snapshotView.leadingAnchor),
            calendar.topAnchor.constraint(equalTo: snapshotView.topAnchor),
            calendar.trailingAnchor.constraint(equalTo: snapshotView.trailingAnchor),
            calendar.bottomAnchor.constraint(equalTo: snapshotView.bottomAnchor)
        ])
        
        snapshotView.layoutIfNeeded()
        
        return snapshotView
    }
    
    // MARK: Calendar delegate
    func calendar(_ calendar: BPKCalendar, didChangeDateSelection dateList: [BPKSimpleDate]) {
        // Empty on purpose.
    }
    
    func calendar(_ calendar: BPKCalendar, isDateEnabled date: BPKSimpleDate) -> Bool {
        if isColoringDates || isShowingPrices {
            return true
        }
        
        let nativeDate = date.date(for: sut.gregorian)
        
        if nativeDate.compare(date2) == .orderedDescending {
            return false
        }
        
        return true
    }
    
    func calendar(_ calendar: BPKCalendar, cellDataFor date: BPKSimpleDate) -> Any? {
        if !isColoringDates && !isShowingPrices {
            return nil
        }
        
        let calendar = sut.gregorian
        let convertedDate = date.date(for: calendar)
        
        let startDate = calendar.startOfDay(for: date1)
        let endDate = calendar.startOfDay(for: convertedDate)
        
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        
        guard let day = components.day else { return nil }
        
        if day == 15 {
            return nil
        }
        
        if day == 18 {
            return isShowingPrices
            ? BPKCalendarPriceLabelCellData(price: "-", labelStyle: .noData)
            : BPKCalendarTrafficLightCellData.normal
        }
        
        if day % 2 == 0 {
            return isShowingPrices
            ? BPKCalendarPriceLabelCellData(price: "458.100₫", labelStyle: .positive)
            : BPKCalendarTrafficLightCellData.positive
        } else if day % 3 == 0 {
            return isShowingPrices
            ? BPKCalendarPriceLabelCellData(price: "113.884.400₫", labelStyle: .noData)
            : BPKCalendarTrafficLightCellData.neutral
        } else {
            return isShowingPrices
            ? BPKCalendarPriceLabelCellData(price: "This should truncate", labelStyle: .negative)
            : BPKCalendarTrafficLightCellData.negative
        }
    }
}
