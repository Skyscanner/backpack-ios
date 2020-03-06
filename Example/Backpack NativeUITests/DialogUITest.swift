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

class DialogUITest: BackpackUITestCase {
    lazy var dialogScrimView: XCUIElement = {
        return app.otherElements["dialogScrimView"]
    }()

    lazy var dialogView: XCUIElement = {
        return app.otherElements["dialogView"]
    }()

    func navigateAndShow(story: String) {
        app.tables.staticTexts["Dialogs"].tap()
        app.tables.staticTexts[story].tap()

        app.buttons["Show"].tap()
    }

    func testTapScrimToDismiss() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow(story: "With call to action")
        }

        XCTAssertTrue(dialogScrimView.exists, "The scrim should have been shown")
        XCTAssertTrue(dialogView.exists, "The dialog view should have been shown")
        saveScreenshot(named: "Dialog Controller Normal")

        XCTContext.runActivity(named: "Act") { _ in
            let dialogScrimViewCoordinate: XCUICoordinate =
                dialogScrimView.coordinate(withNormalizedOffset: CGVector(dx: 10.0, dy: 10.0))
            dialogScrimViewCoordinate.tap()
        }

        saveScreenshot(named: "Dialog Controller Normal after scrim tapped")
        XCTAssertFalse(dialogScrimView.exists, "The dialog along with the scrim should have been removed")
        XCTAssertFalse(dialogView.exists, "The dialog along with the scrim should have been removed")
    }

    func testTapScrimDoesNotDismissButtonDoes() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow(story: "Delete confirmation")
        }
        XCTAssertTrue(dialogScrimView.exists, "The scrim should have been shown")
        XCTAssertTrue(dialogView.exists, "The dialog view should have been shown")
        saveScreenshot(named: "Dialog Controller Error")

        XCTContext.runActivity(named: "Act 1") { _ in
            dialogScrimView.tap()
        }

        saveScreenshot(named: "Dialog Controller Error after scrim tap")
        XCTAssertTrue(dialogScrimView.exists, "The scrim should not have been removed by tapping")
        XCTAssertTrue(dialogView.exists, "The dialog view shoudl not have been removed by tapping")

        XCTContext.runActivity(named: "Act 2") { _ in
            dialogView.buttons["Delete"].tap()
        }

        saveScreenshot(named: "Dialog Controller Error after delete tap")
        XCTAssertFalse(dialogScrimView.exists, "The scrim should not have been removed by tapping")
        XCTAssertFalse(dialogView.exists, "The dialog view shoudl not have been removed by tapping")

    }
}
