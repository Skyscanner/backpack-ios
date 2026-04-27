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

@MainActor
class BackpackSnapshotTestCase: XCTestCase {
    var app: XCUIApplication!

    // To run only a subset of the screenshots
    // set the below property to a Set with the top level
    // titles of the components to screenshot.
    //
    // For Example: `Set(["Nudger"])` will only take the
    // Nudger screenshots.
    var runOnly: Set<String>?

    // MARK: - Timing Constants
    enum TestTiming {
        static let shortWait: UInt64 = 300_000_000      // 0.3s
        static let standardWait: UInt64 = 500_000_000   // 0.5s
        static let tabSwitchWait: UInt64 = 1_000_000_000 // 1s
        static let viewLoadWait: UInt64 = 2_000_000_000  // 2s
        static let darkModeWait: UInt64 = 3_000_000_000  // 3s
        static let scrollDelay: UInt64 = 200_000_000     // 0.2s
    }

    enum TestTimeout {
        static let standard: TimeInterval = 3
        static let long: TimeInterval = 5
    }

    enum ScrollAttempts {
        static let standard = 10
        static let reset = 3
    }

    override func setUp() {
        super.setUp()
        continueAfterFailure = true
    }

    // MARK: - Navigation Helpers

    @MainActor
    func navigate(title: String, _ closure: () async -> Void) async {
        if !(runOnly?.contains(title) ?? true) {
            return
        }

        let element = app.tables.staticTexts[title]

        // Wait for element to exist
        _ = element.waitForExistence(timeout: TestTimeout.standard)

        // Scroll to make the element visible if it's not hittable
        if !element.isHittable {
            let elementY = element.frame.origin.y

            if elementY < 0 {
                // Element is above viewport, scroll down to reveal it
                for _ in 0..<ScrollAttempts.standard {
                    app.swipeDown()
                    try? await Task.sleep(nanoseconds: TestTiming.scrollDelay)
                    if element.isHittable { break }
                }
            } else {
                // Element is below viewport, scroll up
                for _ in 0..<ScrollAttempts.standard {
                    app.swipeUp()
                    try? await Task.sleep(nanoseconds: TestTiming.scrollDelay)
                    if element.isHittable { break }
                }
            }
        }

        element.tap()
        await closure()
        tapBackButton()
    }

    func switchTab(title: String) async {
        let tabButton = app.tabBars.buttons[title]
        _ = tabButton.waitForExistence(timeout: TestTimeout.standard)
        tabButton.tap()
        try? await Task.sleep(nanoseconds: TestTiming.tabSwitchWait)
    }

    func tapBackButton() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }

    // MARK: - Element Interaction Helpers

    private func waitForTable() async -> Bool {
        let table = app.tables.firstMatch
        return table.waitForExistence(timeout: TestTimeout.standard)
    }

    private func ensureElementExists(_ element: XCUIElement, named name: String) async -> Bool {
        // First attempt with longer timeout
        if element.waitForExistence(timeout: TestTimeout.long) {
            return true
        }

        // Try scrolling down to reset view
        for _ in 0..<ScrollAttempts.reset {
            app.swipeDown()
            try? await Task.sleep(nanoseconds: TestTiming.shortWait)
            if element.waitForExistence(timeout: 1) {
                return true
            }
        }

        return element.exists
    }

    private func scrollIntoView(_ element: XCUIElement, named name: String) async -> Bool {
        guard !element.isHittable else { return true }

        let elementY = element.frame.origin.y
        let scrollDirection = elementY < 0 ? ScrollDirection.down : .up

        for _ in 0..<ScrollAttempts.standard {
            scrollDirection == .down ? app.swipeDown() : app.swipeUp()
            try? await Task.sleep(nanoseconds: TestTiming.scrollDelay)
            if element.isHittable { return true }
        }

        return element.isHittable
    }

    private enum ScrollDirection {
        case up, down
    }

    // MARK: - Screenshot Helpers

    @MainActor
    func saveScreenshot(component componentName: String, scenario scenarioName: String,
                        userInterfaceStyle: UIUserInterfaceStyle) {
        let interfaceStyle = userInterfaceStyle == .dark ? "dm" : "lm"
        let outputName = "\(componentName)___\(scenarioName)_\(interfaceStyle)"
        snapshot(outputName)
    }

    // MARK: - Common Wait Patterns

    func waitForStability(duration: UInt64 = TestTiming.standardWait) async {
        try? await Task.sleep(nanoseconds: duration)
    }
}
