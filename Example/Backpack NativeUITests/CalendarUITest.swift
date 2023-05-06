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

final class CalendarUITest: BackpackUITestCase {
    private func goToPreselectedDatesCalendar(_ app: XCUIApplication) {
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Calendar"].tap()
        tablesQuery.staticTexts["With preselected dates"].tap()
    }
    
    func testCalendarWithStartDateSelectedCanSelectDifferentDate() {
        let app = XCUIApplication()
        goToPreselectedDatesCalendar(app)
        
        XCTAssertTrue(app.cells["Thursday, March 12, 2020, Selected as departure date"].isSelected)
        XCTAssertTrue(app.cells["Friday, March 20, 2020, Selected as return date"].isSelected)
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells["Tuesday, March 10, 2020"].staticTexts["10"].tap()
        collectionViewsQuery.cells["Tuesday, March 24, 2020"].staticTexts["24"].tap()
        
        XCTAssertTrue(app.cells["Tuesday, March 10, 2020, Selected as departure date"].isSelected)
        XCTAssertTrue(app.cells["Tuesday, March 24, 2020, Selected as return date"].isSelected)
        
        XCTAssertFalse(app.cells["Thursday, March 12, 2020, Between departure and return date"].isSelected)
        XCTAssertFalse(app.cells["Friday, March 20, 2020, Between departure and return date"].isSelected)
    }

    func testCanSelectDifferentDatesOnSingleSelectionCalendar() {
        let app = XCUIApplication()
        goToPreselectedDatesCalendar(app)
        
        app.buttons["Single"].tap()
        
        let collectionViewsQuery = app.collectionViews
        
        collectionViewsQuery.cells["Sunday, March 1, 2020"].staticTexts["1"].tap()
        XCTAssertTrue(app.cells["Sunday, March 1, 2020"].isSelected)
        XCTAssertFalse(app.cells["Wednesday, April 1, 2020"].isSelected)
        
        collectionViewsQuery.cells["Wednesday, April 1, 2020"].staticTexts["1"].tap()
        XCTAssertTrue(app.cells["Wednesday, April 1, 2020"].isSelected)
        XCTAssertFalse(app.cells["Sunday, March 1, 2020"].isSelected)
    }
    
    func testCanSelectMultipleDatesOnMultiSelectionCalendar() {
        let app = XCUIApplication()
        goToPreselectedDatesCalendar(app)
        
        app.buttons["Multiple"].tap()
        
        XCTAssertFalse(app.cells["Sunday, March 1, 2020"].isSelected)
        XCTAssertFalse(app.cells["Tuesday, March 3, 2020"].isSelected)
        XCTAssertFalse(app.cells["Monday, March 16, 2020"].isSelected)
        XCTAssertFalse(app.cells["Tuesday, March 10, 2020"].isSelected)
        XCTAssertFalse(app.cells["Friday, March 13, 2020"].isSelected)
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells["Sunday, March 1, 2020"].staticTexts["1"].tap()
        collectionViewsQuery.cells["Tuesday, March 3, 2020"].staticTexts["3"].tap()
        collectionViewsQuery.cells["Monday, March 16, 2020"].staticTexts["16"].tap()
        collectionViewsQuery.cells["Tuesday, March 10, 2020"].staticTexts["10"].tap()
        collectionViewsQuery.cells["Friday, March 13, 2020"].staticTexts["13"].tap()
        
        XCTAssertTrue(app.cells["Sunday, March 1, 2020"].isSelected)
        XCTAssertTrue(app.cells["Tuesday, March 3, 2020"].isSelected)
        XCTAssertTrue(app.cells["Monday, March 16, 2020"].isSelected)
        XCTAssertTrue(app.cells["Tuesday, March 10, 2020"].isSelected)
        XCTAssertTrue(app.cells["Friday, March 13, 2020"].isSelected)
        
        collectionViewsQuery.cells["Sunday, March 1, 2020"].staticTexts["1"].tap()
        collectionViewsQuery.cells["Tuesday, March 3, 2020"].staticTexts["3"].tap()
        collectionViewsQuery.cells["Monday, March 16, 2020"].staticTexts["16"].tap()
        collectionViewsQuery.cells["Tuesday, March 10, 2020"].staticTexts["10"].tap()
        collectionViewsQuery.cells["Friday, March 13, 2020"].staticTexts["13"].tap()
        
        XCTAssertFalse(app.cells["Sunday, March 1, 2020"].isSelected)
        XCTAssertFalse(app.cells["Tuesday, March 3, 2020"].isSelected)
        XCTAssertFalse(app.cells["Monday, March 16, 2020"].isSelected)
        XCTAssertFalse(app.cells["Tuesday, March 10, 2020"].isSelected)
        XCTAssertFalse(app.cells["Friday, March 13, 2020"].isSelected)
    }
    
    func testCanSelectWholeMonth() {
        let app = XCUIApplication()
        app.tables.staticTexts["Calendar"].tap()
        app.tables.staticTexts["With select whole month button"].tap()
        app.buttons["Range"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.buttons["Select whole month"].firstMatch.tap()
        
        XCTAssertTrue(app.cells["Saturday, February 1, 2020, Selected as departure date"].isSelected)
        XCTAssertTrue(app.cells["Saturday, February 29, 2020, Selected as return date"].isSelected)
    }
}
