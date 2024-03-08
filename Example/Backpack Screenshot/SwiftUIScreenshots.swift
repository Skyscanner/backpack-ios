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

// swiftlint:disable type_body_length
// swiftlint:disable function_body_length
// swiftlint:disable file_length
class SwiftUIScreenshots: BackpackSnapshotTestCase {
    func createApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments.append("UITests")

        return app
    }
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
    }

    override func saveScreenshot(component componentName: String, scenario scenarioName: String,
                        userInterfaceStyle: UIUserInterfaceStyle) {
        super.saveScreenshot(component: "swiftui_\(componentName)", scenario: scenarioName, userInterfaceStyle: userInterfaceStyle)
    }

    @MainActor
    func testLightModeScreenshots() async {
        app = createApp()
        setupSnapshot(app)
        app.launch()
        await captureAllScreenshots()
    }

    @MainActor
    func testDarkModeScreenshots() async {
        app = createApp()
        app.launchArguments.append("FORCE_DARK_MODE")
        setupSnapshot(app)
        app.launch()
        await captureAllScreenshots(userInterfaceStyle: .dark)
    }
    
    @MainActor
    func captureAllScreenshots(userInterfaceStyle: UIUserInterfaceStyle = .light) async {
        await navigate(title: "Navigation bars") {
            switchTab(title: "SwiftUI")
            _ = app.buttons["Default"].waitForExistence(timeout: 1)
            app.buttons["Default"].tap()
            saveScreenshot(component: "navbar", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Back"].tap()
            
            _ = app.buttons["Transparent"].waitForExistence(timeout: 1)
            app.buttons["Transparent"].tap()
            saveScreenshot(component: "navbar", scenario: "transparent", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Back"].tap()
            
            _ = app.buttons["Surface Contrast"].waitForExistence(timeout: 1)
            app.buttons["Surface Contrast"].tap()
            saveScreenshot(component: "navbar", scenario: "surfaceContrast", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Close"].tap()
        }
    }
}
