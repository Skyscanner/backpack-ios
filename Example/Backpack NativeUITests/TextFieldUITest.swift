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

class TextFieldUITest: XCTestCase {
    lazy var app: XCUIApplication = {
        return XCUIApplication()
    }()

    lazy var textField: XCUIElement = {
        return app.textFields["textField"]
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
        app.tables.staticTexts["Text fields"].tap()
    }

    func testTapTextFieldToEdit() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow()
        }

        XCTAssertTrue(textField.exists, "The text field should have been shown")
        XCTAssertFalse(textField.isSelected, "The text field should not be selected automatically")
        saveScreenshot(named: "Text field normal")

        guard let textFieldValueBefore = textField.value as? String else {
            XCTAssertTrue(false, "Text field is not of expected type UITextField")
            return
        }

        XCTContext.runActivity(named: "Act") { _ in
            textField.tap()
            textField.typeText(" Testing")
        }

        guard let textFieldValueAfter = textField.value as? String else {
            XCTAssertTrue(false, "Text field is not of expected type UITextField")
            return
        }

        XCTAssertTrue(textFieldValueAfter.elementsEqual(textFieldValueBefore + " Testing"),
                      "The text field should be updated after typing")
    }
}
