//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019 Skyscanner Ltd. All rights reserved.
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

class ToastUITest: BackpackUITestCase {
    lazy var toastView: XCUIElement = {
        return app.otherElements["toastView"]
    }()

    func navigateAndShow() {
        app.tables.staticTexts["Toasts"].tap()
        app.tables.staticTexts["Default toast"].tap()
        app.buttons["Show Toast"].tap()
    }

    func testTapShowButtonToShowToast() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow()
        }

        XCTAssertTrue(toastView.exists, "The toast should have been shown")
    }

    func testTapShowButtonAndWaitToHideToast() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow()
        }

        sleep(1)
        XCTAssertFalse(toastView.exists, "The toast shoud not be visible")
    }
}
