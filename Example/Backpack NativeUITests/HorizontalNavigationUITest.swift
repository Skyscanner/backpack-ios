/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

class HorizontalNavigationUITest: BackpackUITestCase {
    lazy var flightsOption: XCUIElement = {
        return app.buttons["Flights"]
    }()

    lazy var hotelsOption: XCUIElement = {
        return app.buttons["Hotels"]
    }()

    func navigateAndShow() {
        app.tables.staticTexts["Horizontal navigation"].tap()
        app.tables.staticTexts["Default"].tap()
    }

    func testTapToNavigate() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow()
        }

        XCTContext.runActivity(named: "Act") { _ in
            hotelsOption.tap()
        }

        XCTAssertFalse(flightsOption.isSelected,
                       "The 'Flights' option should have been deselected when another option was tapped")
        XCTAssertTrue(hotelsOption.isSelected, "The 'Hotels' option should have been selected when tapped")
        saveScreenshot(named: "Hotels selected")
    }
}
