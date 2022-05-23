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
class SwiftUIScreenshots: XCTestCase {
    
    var app: XCUIApplication!

    // To run only a subset of the screenshots
    // set the below property to a Set with the top level
    // titles of the components to screenshot.
    //
    // For Example: `Set(["Nudger"])` will only take the
    // Nudger screenshots.
    var runOnly: Set<String>?

    func createApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments.append("UITests")

        return app
    }

    override func setUp() {
        super.setUp()
        continueAfterFailure = true
    }

    func saveScreenshot(component componentName: String, scenario scenarioName: String,
                        userInterfaceStyle: UIUserInterfaceStyle) {
        let interfaceStyle = userInterfaceStyle == .dark ? "dm" : "lm"
        let outputName = "swiftui_\(componentName)___\(scenarioName)_\(interfaceStyle)"
        snapshot(outputName)
    }
    
    func navigate(title: String, _ closure: () -> Void) {
        if !(runOnly?.contains(title) ?? true) {
            return
        }

        app.tables.staticTexts[title].tap()
        closure()
        tapBackButton()
    }
    
    func tapBackButton() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
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
            app.tables.staticTexts["SwiftUI"].tap()
            
            app.tables.staticTexts["Default"].tap()
            saveScreenshot(component: "text", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Multiple font styles"].tap()
            saveScreenshot(component: "text", scenario: "multiple-font-styles", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            tapBackButton()
        }
        
        navigate(title: "Buttons") {
            app.tables.staticTexts["SwiftUI"].tap()
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
            tapBackButton()
        }
        
        navigate(title: "Switches") {
            navigate(title: "SwiftUI") {
                saveScreenshot(component: "switch", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            }
        }

        navigate(title: "Cards") {
            app.tables.staticTexts["SwiftUI"].tap()
            saveScreenshot(component: "card", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
    }
}
