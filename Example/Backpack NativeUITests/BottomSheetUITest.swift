//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2020 Skyscanner Ltd. All rights reserved.
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

class BottomSheetUITest: BackpackUITestCase {
    func testBottomSheetPresentingBottomSheet() {
        XCTContext.runActivity(named: "Navigate") { _ in
            let tablesQuery = app.tables
            tablesQuery.staticTexts["Bottom Sheet"].tap()
            tablesQuery.staticTexts["Bottom Sheet presenting Bottom Sheet"].tap()
            app.buttons["Next step"].tap()
        }

        XCTContext.runActivity(named: "Second Bottom Sheet") { _ in
            let sheet = app.otherElements.matching(identifier: "SheetPresentingSheet.SecondSheet.view").firstMatch
            _ = sheet.waitForExistence(timeout: 10)
        }
    }
}
