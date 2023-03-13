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
        navigate(title: "Labels") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Body"].tap()
            saveScreenshot(component: "text", scenario: "body", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Heading"].tap()
            saveScreenshot(component: "text", scenario: "heading", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Hero"].tap()
            saveScreenshot(component: "text", scenario: "hero", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Buttons") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Primary"].tap()
            saveScreenshot(component: "button", scenario: "primary", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Secondary"].tap()
            saveScreenshot(component: "button", scenario: "secondary", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Destructive"].tap()
            saveScreenshot(component: "button", scenario: "destructive", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Featured"].tap()
            saveScreenshot(component: "button", scenario: "featured", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Link"].tap()
            saveScreenshot(component: "button", scenario: "link", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Primary On Dark"].tap()
            saveScreenshot(component: "button", scenario: "primaryOnDark", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Primary On Light"].tap()
            saveScreenshot(component: "button", scenario: "primaryOnLight", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Switches") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "switch", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Cards") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Card"].tap()
            saveScreenshot(component: "card", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["DividedCard"].tap()
            saveScreenshot(component: "divided-card", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["CardWrapper"].tap()
            saveScreenshot(component: "card-wrapper", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Badges") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "badge", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        navigate(title: "Spinners") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "spinner", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        navigate(title: "Skeleton") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "skeleton", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        navigate(title: "Price") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "Price", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
    }
}
