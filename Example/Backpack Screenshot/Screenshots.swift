/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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
@available(iOS 13.0, *)
class Screenshots: XCTestCase {

    var app: XCUIApplication = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        continueAfterFailure = true
    }

    func saveScreenshot(component componentName: String, scenario scenarioName: String,
                        userInterfaceStyle: UIUserInterfaceStyle) {
        let interfaceStyle = userInterfaceStyle == .dark ? "dm" : "lm"
        let outputName = "\(componentName)___\(scenarioName)_\(interfaceStyle)"
        snapshot(outputName)
    }

    func tapBackButton() {
        XCUIApplication().navigationBars.buttons.element(boundBy: 0).tap()
    }

    func tapDialogScrimView () {
        let dialogScrimViewCoordinate: XCUICoordinate =
            app.otherElements["dialogScrimView"].coordinate(withNormalizedOffset: CGVector(dx: 10.0, dy: 10.0))
        dialogScrimViewCoordinate.tap()
    }

    func testLightModeScreenshots() {
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        captureAllScreenshots()
    }

    func testDarkModeScreenshots() {
        app = XCUIApplication()
        app.launchArguments.append("FORCE_DARK_MODE")
        setupSnapshot(app)
        app.launch()
        captureAllScreenshots(userInterfaceStyle: .dark)
    }

    func captureAllScreenshots(userInterfaceStyle: UIUserInterfaceStyle = .light) {
        app.tables.staticTexts["Badges"].tap()
        saveScreenshot(component: "badge", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()

        app.tables.staticTexts["Bar charts"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "bar-chart", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        app.cells.element(boundBy: 3).tap()
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Bottom Sheet"].tap()
        app.tables.staticTexts["Bottom Sheet with a bottom section"].tap()
        saveScreenshot(component: "bottom-sheet", scenario: "with-bottom-section",
                       userInterfaceStyle: userInterfaceStyle)
        app.buttons["Dismiss"].tap()
        tapBackButton()

        app.tables.staticTexts["Buttons"].tap()
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
        app.tables.staticTexts["Outline"].tap()
        saveScreenshot(component: "button", scenario: "outline", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Calendar"].tap()
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
        tapBackButton()

        app.tables.staticTexts["Cards"].tap()
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
        tapBackButton()

        app.tables.staticTexts["Chips"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "chip", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["With icons"].tap()
        saveScreenshot(component: "chip", scenario: "with-icons", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Filled"].tap()
        saveScreenshot(component: "chip", scenario: "filled", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Filled with background color"].tap()
        saveScreenshot(component: "chip", scenario: "filled-background-color", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Dialogs"].tap()
        app.tables.staticTexts["With call to action"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "dialog", scenario: "with-cta", userInterfaceStyle: userInterfaceStyle)
        tapDialogScrimView()
        tapBackButton()
        app.tables.staticTexts["Warning"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "dialog", scenario: "warning", userInterfaceStyle: userInterfaceStyle)
        tapDialogScrimView()
        tapBackButton()
        app.tables.staticTexts["With no title"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "dialog", scenario: "no-title", userInterfaceStyle: userInterfaceStyle)
        tapDialogScrimView()
        tapBackButton()
        app.tables.staticTexts["Delete confirmation"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "dialog", scenario: "delete-confirmation", userInterfaceStyle: userInterfaceStyle)
        app.buttons["Delete"].tap()
        tapBackButton()
        app.tables.staticTexts["Success"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "dialog", scenario: "success", userInterfaceStyle: userInterfaceStyle)
        tapDialogScrimView()
        tapBackButton()
        app.tables.staticTexts["With no icon"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "dialog", scenario: "no-icon", userInterfaceStyle: userInterfaceStyle)
        app.buttons["Got it"].tap()
        tapBackButton()
        app.tables.staticTexts["With no icon and no title"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "dialog", scenario: "no-title-no-icon", userInterfaceStyle: userInterfaceStyle)
        app.buttons["Got it"].tap()
        tapBackButton()
        app.tables.staticTexts["In-app messaging"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "dialog", scenario: "in-app-messaging", userInterfaceStyle: userInterfaceStyle)
        tapDialogScrimView()
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Flare views"].tap()
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
        tapBackButton()

        app.tables.staticTexts["Horizontal navigation"].tap()
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
        app.tables.staticTexts["With notification"].tap()
        saveScreenshot(component: "horizontal-navigation", scenario: "notification",
                       userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["With badge"].tap()
        saveScreenshot(component: "horizontal-navigation", scenario: "badge",
                       userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Icons"].tap()
        saveScreenshot(component: "icon", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()

        app.tables.staticTexts["Labels"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "label", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Emphasized"].tap()
        saveScreenshot(component: "label", scenario: "emphasized", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Heavy"].tap()
        saveScreenshot(component: "label", scenario: "heavy", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Multiple font styles"].tap()
        saveScreenshot(component: "label", scenario: "multiple-font-styles", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Navigation bars"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "navigation-bar", scenario: "full-height",
                       userInterfaceStyle: userInterfaceStyle)
        app.swipeUp()
        saveScreenshot(component: "navigation-bar", scenario: "collapsed",
                       userInterfaceStyle: userInterfaceStyle)
        app.buttons["NavigateBack"].tap()
        app.tables.staticTexts["With buttons"].tap()
        saveScreenshot(component: "navigation-bar", scenario: "full-height-with-buttons",
                       userInterfaceStyle: userInterfaceStyle)
        app.swipeUp()
        saveScreenshot(component: "navigation-bar", scenario: "collapsed-with-buttons",
                       userInterfaceStyle: userInterfaceStyle)
        app.buttons["NavigateBack"].tap()
        tapBackButton()

        app.tables.staticTexts["Overlay views"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "overlay-view", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Overlay type none"].tap()
        saveScreenshot(component: "overlay-view", scenario: "overlay-type-none", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Corner style large"].tap()
        saveScreenshot(component: "overlay-view", scenario: "corner-style-large", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Foreground content"].tap()
        saveScreenshot(component: "overlay-view", scenario: "foreground-content", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Panels"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "panel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Without padding"].tap()
        saveScreenshot(component: "panel", scenario: "without-padding", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Elevated"].tap()
        saveScreenshot(component: "panel", scenario: "elevated", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Progress bar"].tap()
        app.buttons["Increase"].tap()
        app.buttons["Increase"].tap()
        saveScreenshot(component: "progress-bar", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()

        app.tables.staticTexts["Rating"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "rating", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["With subtitles"].tap()
        saveScreenshot(component: "rating", scenario: "subtitles", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Sizes"].tap()
        saveScreenshot(component: "rating", scenario: "sizes", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Vertical layout"].tap()
        saveScreenshot(component: "rating", scenario: "vertical", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Pill layout with subtitles"].tap()
        saveScreenshot(component: "rating", scenario: "pill", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Snackbar"].tap()
        app.tables.staticTexts["With text"].tap()
        saveScreenshot(component: "snack-bar", scenario: "with-text", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["With text and button"].tap()
        saveScreenshot(component: "snack-bar", scenario: "with-text-and-button",
                       userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["With text and icon only button"].tap()
        saveScreenshot(component: "snack-bar", scenario: "with-text-and-icon-only-button",
                       userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Spinners"].tap()
        saveScreenshot(component: "spinner", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()

        app.tables.staticTexts["Star ratings"].tap()
        app.tables.staticTexts["Docs"].tap()
        saveScreenshot(component: "star-rating", scenario: "docs", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Switches"].tap()
        saveScreenshot(component: "switch", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()

        app.tables.staticTexts["Tab bar controller"].tap()
        saveScreenshot(component: "tab-bar-controller", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()

        app.tables.staticTexts["Tappable link labels"].tap()
        app.tables.staticTexts["Text with single link"].tap()
        saveScreenshot(component: "tappable-link-label", scenario: "single", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Text with multiple links"].tap()
        saveScreenshot(component: "tappable-link-label", scenario: "multiple", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Alternate style"].tap()
        saveScreenshot(component: "tappable-link-label", scenario: "alternate-style",
                       userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        app.tables.staticTexts["Link with custom color"].tap()
        saveScreenshot(component: "tappable-link-label", scenario: "custom-color",
                       userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Text fields"].tap()
        saveScreenshot(component: "text-field", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()

        app.tables.staticTexts["Text views"].tap()
        saveScreenshot(component: "text-view", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()

        app.tables.staticTexts["Toasts"].tap()
        app.tables.staticTexts["Default toast"].tap()
        app.buttons["Show Toast"].tap()
        saveScreenshot(component: "toast", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        tapBackButton()
        tapBackButton()
    }
}
