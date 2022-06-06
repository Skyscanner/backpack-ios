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

class CalendarUITest: BackpackUITestCase {
    private func goToPreselectedDatesCalendar(_ app: XCUIApplication) {
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Calendar"].tap()
        tablesQuery.staticTexts["With preselected dates"].tap()
    }
    
    func testCalendarWithStartDateSelectedCanSelectDifferentDate() {
        let app = XCUIApplication()
        goToPreselectedDatesCalendar(app)
        
        XCTAssertTrue(app.cells["March 12, 2020, Selected as departure date"].isSelected)
        XCTAssertTrue(app.cells["March 20, 2020, Selected as return date"].isSelected)
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells["March 10, 2020"].staticTexts["10"].tap()
        collectionViewsQuery.cells["March 24, 2020"].staticTexts["24"].tap()
        
        XCTAssertTrue(app.cells["March 10, 2020, Selected as departure date"].isSelected)
        XCTAssertTrue(app.cells["March 24, 2020, Selected as return date"].isSelected)
        
        XCTAssertFalse(app.cells["March 12, 2020, Between departure and return date"].isSelected)
        XCTAssertFalse(app.cells["March 20, 2020, Between departure and return date"].isSelected)
    }

    func testCanSelectDifferentDatesOnSingleSelectionCalendar() {
        let app = XCUIApplication()
        goToPreselectedDatesCalendar(app)
        
        app.buttons["Single"].tap()
        
        let collectionViewsQuery = app.collectionViews
        
        collectionViewsQuery.cells["March 1, 2020"].staticTexts["1"].tap()
        XCTAssertTrue(app.cells["March 1, 2020"].isSelected)
        XCTAssertFalse(app.cells["April 1, 2020"].isSelected)
        
        collectionViewsQuery.cells["April 1, 2020"].staticTexts["1"].tap()
        XCTAssertTrue(app.cells["April 1, 2020"].isSelected)
        XCTAssertFalse(app.cells["March 1, 2020"].isSelected)
    }
    
    func testCanSelectMultipleDatesOnMultiSelectionCalendar() {
        let app = XCUIApplication()
        goToPreselectedDatesCalendar(app)
        
        app.buttons["Multiple"].tap()
        
        XCTAssertFalse(app.cells["March 1, 2020"].isSelected)
        XCTAssertFalse(app.cells["March 3, 2020"].isSelected)
        XCTAssertFalse(app.cells["March 16, 2020"].isSelected)
        XCTAssertFalse(app.cells["March 10, 2020"].isSelected)
        XCTAssertFalse(app.cells["March 13, 2020"].isSelected)
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells["March 1, 2020"].staticTexts["1"].tap()
        collectionViewsQuery.cells["March 3, 2020"].staticTexts["3"].tap()
        collectionViewsQuery.cells["March 16, 2020"].staticTexts["16"].tap()
        collectionViewsQuery.cells["March 10, 2020"].staticTexts["10"].tap()
        collectionViewsQuery.cells["March 13, 2020"].staticTexts["13"].tap()
        
        XCTAssertTrue(app.cells["March 1, 2020"].isSelected)
        XCTAssertTrue(app.cells["March 3, 2020"].isSelected)
        XCTAssertTrue(app.cells["March 16, 2020"].isSelected)
        XCTAssertTrue(app.cells["March 10, 2020"].isSelected)
        XCTAssertTrue(app.cells["March 13, 2020"].isSelected)
        
        collectionViewsQuery.cells["March 1, 2020"].staticTexts["1"].tap()
        collectionViewsQuery.cells["March 3, 2020"].staticTexts["3"].tap()
        collectionViewsQuery.cells["March 16, 2020"].staticTexts["16"].tap()
        collectionViewsQuery.cells["March 10, 2020"].staticTexts["10"].tap()
        collectionViewsQuery.cells["March 13, 2020"].staticTexts["13"].tap()
        
        XCTAssertFalse(app.cells["March 1, 2020"].isSelected)
        XCTAssertFalse(app.cells["March 3, 2020"].isSelected)
        XCTAssertFalse(app.cells["March 16, 2020"].isSelected)
        XCTAssertFalse(app.cells["March 10, 2020"].isSelected)
        XCTAssertFalse(app.cells["March 13, 2020"].isSelected)
    }
    
    func testCanSelectWholeMonth() {
        // Calculate the next month to avoid trying to select past dates
        let calendar = Calendar.current
        let currentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth)!
        var components = calendar.dateComponents([.year, .month, .day], from: nextMonth)
        components.day = 15
        let halfMonth = calendar.date(from: components)!
        let lastDay = calendar.date(byAdding: .init(month: 1, day: -1), to: nextMonth)!
        
        let app = XCUIApplication()
        app.tables.staticTexts["Calendar"].tap()
        app.tables.staticTexts["With select whole month button"].tap()
        app.buttons["Range"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.buttons[accessiblityLabelForWholeMonthButton(nextMonth)].tap()
        
        XCTAssertTrue(app.cells[accessibilityLabelForCell(halfMonth)].isSelected)
        XCTAssertTrue(app.cells[accessibilityLabelForCell(lastDay)].isSelected)
    }
    
    private func accessiblityLabelForWholeMonthButton(_ month: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMMM, yyyy"
        return "Select whole month \(formatter.string(from: month))"
    }
    
    private func accessibilityLabelForCell(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
}
