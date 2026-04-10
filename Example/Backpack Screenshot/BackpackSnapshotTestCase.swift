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

    @MainActor
    func navigate(title: String, _ closure: () async -> Void) async {
        if !(runOnly?.contains(title) ?? true) {
            return
        }

        let element = app.tables.staticTexts[title]

        // Wait for element to exist
        _ = element.waitForExistence(timeout: 2)

        // Scroll to make the element visible if it's not hittable
        if !element.isHittable {
            // First try to determine if we need to scroll up or down
            let elementY = element.frame.origin.y

            if elementY < 0 {
                // Element is above viewport, scroll down to reveal it (scroll content upward)
                for _ in 0..<10 {
                    app.swipeDown()
                    sleep(UInt32(0.2))
                    if element.isHittable { break }
                }
            } else {
                // Element is below viewport or not visible, scroll up
                for _ in 0..<5 {
                    app.swipeUp()
                    sleep(UInt32(0.2))
                    if element.isHittable { break }
                }
            }
        }

        element.tap()
        await closure()
        tapBackButton()
    }
    
    func switchTab(title: String) {
        let tabButton = app.tabBars.buttons[title]
        _ = tabButton.waitForExistence(timeout: 3)
        tabButton.tap()
        sleep(1) // Wait for tab content to load
    }
    
    func tapBackButton() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    @MainActor 
    func saveScreenshot(component componentName: String, scenario scenarioName: String,
                        userInterfaceStyle: UIUserInterfaceStyle) {
        let interfaceStyle = userInterfaceStyle == .dark ? "dm" : "lm"
        let outputName = "\(componentName)___\(scenarioName)_\(interfaceStyle)"
        snapshot(outputName)
    }
}
