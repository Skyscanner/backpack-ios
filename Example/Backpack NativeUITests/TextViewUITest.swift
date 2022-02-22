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

class TextViewUITest: BackpackUITestCase {
    lazy var textView: XCUIElement = {
        return app.textViews["textView"]
    }()

    func navigateAndShow() {
        app.tables.staticTexts["Text views"].tap()
    }

    func testTapTextViewToEdit() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow()
        }

        XCTAssertTrue(textView.exists, "The text view should have been shown")
        XCTAssertFalse(textView.isSelected, "The text view should not be selected automatically")
        saveScreenshot(named: "Text view normal")

        guard let textViewValueBefore = textView.value as? String else {
            XCTAssertTrue(false, "Text view is not of expected type UITextView")
            return
        }

        XCTContext.runActivity(named: "Act") { _ in
            textView.tap()
            textView.typeText("Testing ")
        }

        guard let textViewValueAfter = textView.value as? String else {
            XCTAssertTrue(false, "Text view is not of expected type UITextView")
            return
        }

        XCTAssertTrue(
            textViewValueAfter.elementsEqual("Testing " + textViewValueBefore),
            "The text view should be updated after typing"
        )
    }
}
