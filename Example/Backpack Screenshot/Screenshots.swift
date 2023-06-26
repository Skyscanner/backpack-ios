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
class Screenshots: BackpackSnapshotTestCase {
    func createApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments.append("UITests")

        return app
    }

    override func setUp() {
        super.setUp()
        continueAfterFailure = true
    }

    func tapDialogScrimView () {
        let dialogScrimViewCoordinate: XCUICoordinate =
            app.otherElements["dialogScrimView"].coordinate(withNormalizedOffset: CGVector(dx: 10.0, dy: 10.0))
        dialogScrimViewCoordinate.tap()
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
        navigate(title: "Badges") {
            saveScreenshot(component: "badge", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Bar charts") {
            app.cells.element(boundBy: 3).tap()
            saveScreenshot(component: "bar-chart", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }


        navigate(title: "Bottom sheet") {
            app.tables.staticTexts["Bottom Sheet with a bottom section"].tap()
            saveScreenshot(component: "bottom-sheet", scenario: "with-bottom-section",
                           userInterfaceStyle: userInterfaceStyle)
            app.buttons["Dismiss"].tap()
        }


        navigate(title: "Buttons") {
            switchTab(title: "UIKit")
            app.tables.staticTexts["Primary"].tap()
            saveScreenshot(component: "button", scenario: "primary", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Secondary"].tap()
            saveScreenshot(component: "button", scenario: "secondary", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Secondary On Dark"].tap()
            saveScreenshot(component: "button", scenario: "secondaryOnDark", userInterfaceStyle: userInterfaceStyle)
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
            app.tables.staticTexts["Link On Dark"].tap()
            saveScreenshot(component: "button", scenario: "linkOnDark", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Primary On Dark"].tap()
            saveScreenshot(component: "button", scenario: "primaryOnDark", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Primary On Light"].tap()
            saveScreenshot(component: "button", scenario: "primaryOnLight", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Calendar") {
            app.tables.staticTexts["Default"].tap()
            app.swipeUp()
            app.cells.element(boundBy: 25).tap()
            saveScreenshot(component: "calendar", scenario: "single", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Range"].tap()
            app.cells.element(boundBy: 25).tap()
            app.cells.element(boundBy: 32).tap()
            saveScreenshot(component: "calendar", scenario: "range", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Multiple"].tap()
            app.cells.element(boundBy: 25).tap()
            app.cells.element(boundBy: 27).tap()
            app.cells.element(boundBy: 32).tap()
            saveScreenshot(component: "calendar", scenario: "multiple", userInterfaceStyle: userInterfaceStyle)
            app.swipeUp()
            app.swipeUp()
            app.swipeUp()
            app.swipeUp()
            app.swipeUp()
            saveScreenshot(component: "calendar", scenario: "pill", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Custom styles for specific dates"].tap()
            saveScreenshot(component: "calendar", scenario: "custom-style", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["With prices"].tap()
            saveScreenshot(component: "calendar", scenario: "with-prices", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Cards") {
            switchTab(title: "UIKit")
            app.tables.staticTexts["Default"].tap()
            saveScreenshot(component: "card", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Without padding"].tap()
            saveScreenshot(component: "card", scenario: "without-padding", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Selected"].tap()
            saveScreenshot(component: "card", scenario: "selected", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Corner style large"].tap()
            saveScreenshot(component: "card", scenario: "corner-style-large", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Background color"].tap()
            saveScreenshot(component: "card", scenario: "background-color", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["With divider"].tap()
            saveScreenshot(component: "card", scenario: "with-divider", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["With divider arranged vertically"].tap()
            saveScreenshot(component: "card", scenario: "with-divider-arranged-vertically",
                           userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["With divider without padding"].tap()
            saveScreenshot(component: "card", scenario: "with-divider-without-padding",
                           userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["With divider and corner style large"].tap()
            saveScreenshot(component: "card", scenario: "with-divider-and-corner-style-large",
                           userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["With solid divider with padding"].tap()
            saveScreenshot(component: "card", scenario: "with-solid-divider-with-padding",
                           userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["With solid divider without padding"].tap()
            saveScreenshot(component: "card", scenario: "with-solid-divider-without-padding",
                           userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Wrapper default"].tap()
            saveScreenshot(component: "card-wrapper", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            
            tapBackButton()
            app.tables.staticTexts["Wrapper with primary color"].tap()
            saveScreenshot(component: "card-wrapper", scenario: "with-primary-color", userInterfaceStyle: userInterfaceStyle)
            
            tapBackButton()
            app.tables.staticTexts["Wrapper not elevated"].tap()
            saveScreenshot(component: "card-wrapper", scenario: "not-elevated", userInterfaceStyle: userInterfaceStyle)
            
            tapBackButton()
            app.tables.staticTexts["Wrapper with corner style large"].tap()
            saveScreenshot(component: "card-wrapper", scenario: "with-corner-style-large", userInterfaceStyle: userInterfaceStyle)
            
            tapBackButton()
            app.tables.staticTexts["Wrapper with divided card"].tap()
            saveScreenshot(component: "card-wrapper", scenario: "with-divided-card", userInterfaceStyle: userInterfaceStyle)
            
            tapBackButton()
            app.tables.staticTexts["Wrapper with divided card not padded"].tap()
            saveScreenshot(component: "card-wrapper", scenario: "with-divided-card-not-padded", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Card Button") {
            saveScreenshot(component: "card-button", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Chips") {
            app.tables.staticTexts["Default"].tap()
            saveScreenshot(component: "chip", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["On Dark"].tap()
            saveScreenshot(component: "chip", scenario: "on-dark", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["On Image"].tap()
            saveScreenshot(component: "chip", scenario: "on-image", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Dialogs") {
            let showButtonText = "Show dialog"
            
            app.tables.staticTexts["Success"].tap()
            app.buttons[showButtonText].tap()
            saveScreenshot(component: "dialog", scenario: "success", userInterfaceStyle: userInterfaceStyle)
            tapDialogScrimView()
            tapBackButton()
            
            app.tables.staticTexts["Warning"].tap()
            app.buttons[showButtonText].tap()
            saveScreenshot(component: "dialog", scenario: "warning", userInterfaceStyle: userInterfaceStyle)
            tapDialogScrimView()
            tapBackButton()
            
            app.tables.staticTexts["Destructive"].tap()
            app.buttons[showButtonText].tap()
            saveScreenshot(component: "dialog", scenario: "destructive", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Delete"].tap()
            tapBackButton()
            
            app.tables.staticTexts["Flare"].tap()
            app.buttons[showButtonText].tap()
            saveScreenshot(component: "dialog", scenario: "flare", userInterfaceStyle: userInterfaceStyle)
            tapDialogScrimView()
            tapBackButton()
            
            app.tables.staticTexts["Image"].tap()
            app.buttons[showButtonText].tap()
            saveScreenshot(component: "dialog", scenario: "image", userInterfaceStyle: userInterfaceStyle)
            tapDialogScrimView()
            tapBackButton()
        }

        navigate(title: "Flare views") {
            app.tables.staticTexts["Default"].tap()
            saveScreenshot(component: "flare-view", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Background image"].tap()
            saveScreenshot(component: "flare-view", scenario: "background-image", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Flare at top"].tap()
            saveScreenshot(component: "flare-view", scenario: "flare-at-top", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Rounded"].tap()
            saveScreenshot(component: "flare-view", scenario: "rounded", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Horizontal navigation") {
            app.tables.staticTexts["Default"].tap()
            saveScreenshot(component: "horizontal-navigation", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Small"].tap()
            saveScreenshot(component: "horizontal-navigation", scenario: "small", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Without underline"].tap()
            saveScreenshot(component: "horizontal-navigation", scenario: "without-underline",
                           userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["With icons"].tap()
            saveScreenshot(component: "horizontal-navigation", scenario: "with-icons",
                           userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Small with icons"].tap()
            saveScreenshot(component: "horizontal-navigation", scenario: "small-with-icons",
                           userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Wide"].tap()
            saveScreenshot(component: "horizontal-navigation", scenario: "wide",
                           userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Alternate"].tap()
            saveScreenshot(component: "horizontal-navigation", scenario: "alternate",
                           userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Icons") {
            switchTab(title: "UIKit")
            saveScreenshot(component: "icon", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Labels") {
            switchTab(title: "UIKit")
            app.tables.staticTexts["Body"].tap()
            saveScreenshot(component: "label", scenario: "body", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Heading"].tap()
            saveScreenshot(component: "label", scenario: "heading", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Hero"].tap()
            saveScreenshot(component: "label", scenario: "hero", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Map") {
            app.tables.staticTexts["Default"].tap()
            app.otherElements["Manchester airport"].tap()
            app.otherElements["London"].tap()
            app.maps.otherElements["London"].tap()
            saveScreenshot(component: "map", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Navigation bars") {
            app.tables.staticTexts["Large - no back button"].tap()
            saveScreenshot(component: "navigation-bar", scenario: "large-simple",
                           userInterfaceStyle: userInterfaceStyle)
            app.buttons["NavigateBack"].tap()
            
            app.tables.staticTexts["Large - with back button"].tap()
            saveScreenshot(component: "navigation-bar", scenario: "large-back-button",
                           userInterfaceStyle: userInterfaceStyle)
            app.buttons["NavigateBack"].tap()
            
            app.tables.staticTexts["Collapsed - simple"].tap()
            saveScreenshot(component: "navigation-bar", scenario: "collapsed-simple",
                           userInterfaceStyle: userInterfaceStyle)
            app.buttons["NavigateBack"].tap()
            
            app.tables.staticTexts["Large - onImage"].tap()
            saveScreenshot(component: "navigation-bar", scenario: "large-onImage",
                           userInterfaceStyle: userInterfaceStyle)
            app.buttons["NavigateBack"].tap()
            
            app.tables.staticTexts["Collapsed - onImage"].tap()
            saveScreenshot(component: "navigation-bar", scenario: "collapsed-onImage",
                           userInterfaceStyle: userInterfaceStyle)
            app.buttons["NavigateBack"].tap()
        }
    }
}
