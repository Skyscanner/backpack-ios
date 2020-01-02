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

class ChipUITest: XCTestCase {
    lazy var app: XCUIApplication = {
        return XCUIApplication()
    }()

    lazy var afghanistanChip: XCUIElement = {
        return app.buttons["Afghanistan"]
    }()

    lazy var belgiumChip: XCUIElement = {
        return app.buttons["Belgium"]
    }()

    lazy var ethiopiaChip: XCUIElement = {
        return app.buttons["Ethiopia"]
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

    func navigateAndShow() {
        app.tables.staticTexts["Chips"].tap()
        app.tables.staticTexts["Default"].tap()
    }

    func testTapChipToSelect() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow()
        }

        XCTContext.runActivity(named: "Act") { _ in
            belgiumChip.tap()
        }

        XCTAssertTrue(belgiumChip.isSelected, "The chip should have been selected when tapped")
        saveScreenshot(named: "Chip selected")
    }

    func testDisabledChip() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow()
        }

        XCTAssertFalse(afghanistanChip.isEnabled, "The chip should not yet have been selected")
    }
}
