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

class DialogUITest: XCTestCase {
    lazy var app: XCUIApplication = {
        return XCUIApplication()
    }()

    lazy var dialogScrimView: XCUIElement = {
        return app.otherElements["dialogScrimView"]
    }()

    lazy var dialogView: XCUIElement = {
        return app.otherElements["dialogView"]
    }()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test.
        // Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state -
        //such as interface orientation - required for your tests before they run.
        // The setUp method is a good place to do this.
    }

    func saveScreenshot(named name: String) {
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        add(attachment)
    }

    func navigateAndShow(story: String) {
        app.tables.staticTexts["Dialogs"].tap()
        app.tables.staticTexts[story].tap()

        app.buttons["Show"].tap()
    }

    func testTapScrimToDismiss() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow(story: "Normal")
        }

        XCTAssertTrue(dialogScrimView.exists, "The scrim should have been shown")
        XCTAssertTrue(dialogView.exists, "The dialog view should have been shown")
        saveScreenshot(named: "Dialog Controller Normal")

        XCTContext.runActivity(named: "Act") { _ in
            dialogScrimView.tap()
        }

        saveScreenshot(named: "Dialog Controller Normal after scrim tapped")
        XCTAssertFalse(dialogScrimView.exists, "The dialog along with the scrim should have been removed")
        XCTAssertFalse(dialogView.exists, "The dialog along with the scrim should have been removed")
    }

    func testTapScrimDoesNotDismissButtonDoes() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow(story: "Delete")
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
