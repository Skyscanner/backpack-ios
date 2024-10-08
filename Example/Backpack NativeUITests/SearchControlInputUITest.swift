//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
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

class SearchControlInputUITest: BackpackUITestCase {

    @MainActor func navigateAndShow() {
        app.tables.staticTexts["Search Control Input"].tap()
    }

    @MainActor func testWhenSerchControlInputIsClicked() {
        XCTContext.runActivity(named: "Navigate") { _ in
            navigateAndShow()
        }
        
        let searchControlInput = app.buttons["search_control_input_origin"]
        
        XCTAssertTrue(searchControlInput.exists, "The search control input should have been shown")
        
        XCTAssertEqual(searchControlInput.value as? String, "")
        
        searchControlInput.tap()
        
        XCTAssertEqual(searchControlInput.value as? String, "Paris")
    }
}
