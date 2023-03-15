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
    
    func testLightModeScreenshots() {
        app = createApp()
        setupSnapshot(app)
        app.launch()
        captureAllScreenshots()
    }

    func testDarkModeScreenshots() {
        app = createApp()
        app.launchArguments.append("FORCE_DARK_MODE")
        setupSnapshot(app)
        app.launch()
        captureAllScreenshots(userInterfaceStyle: .dark)
    }
    
    func captureAllScreenshots(userInterfaceStyle: UIUserInterfaceStyle = .light) {
        
        navigate(title: "Overlay") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Solid"].tap()
            saveScreenshot(component: "overlay", scenario: "solid", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Top"].tap()
            saveScreenshot(component: "overlay", scenario: "top", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Bottom"].tap()
            saveScreenshot(component: "overlay", scenario: "bottom", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Leading"].tap()
            saveScreenshot(component: "overlay", scenario: "leading", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Trailing"].tap()
            saveScreenshot(component: "overlay", scenario: "trailing", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Vignette"].tap()
            saveScreenshot(component: "overlay", scenario: "vignette", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
    }
}
