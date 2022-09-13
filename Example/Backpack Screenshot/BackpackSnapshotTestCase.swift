/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

class BackpackSnapshotTestCase: XCTestCase {
    var app: XCUIApplication!
    
    // To run only a subset of the screenshots
    // set the below property to a Set with the top level
    // titles of the components to screenshot.
    //
    // For Example: `Set(["Nudger"])` will only take the
    // Nudger screenshots.
    var runOnly: Set<String>?
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
    }
    
    func navigate(title: String, _ closure: () -> Void) {
        if !(runOnly?.contains(title) ?? true) {
            return
        }

        app.tables.staticTexts[title].tap()
        closure()
        tapBackButton()
    }
    
    func switchTab(title: String) {
        app.tabBars.buttons[title].tap()
    }
    
    func tapBackButton() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func saveScreenshot(component componentName: String, scenario scenarioName: String,
                        userInterfaceStyle: UIUserInterfaceStyle) {
        let interfaceStyle = userInterfaceStyle == .dark ? "dm" : "lm"
        let outputName = "\(componentName)___\(scenarioName)_\(interfaceStyle)"
        snapshot(outputName)
    }
}
