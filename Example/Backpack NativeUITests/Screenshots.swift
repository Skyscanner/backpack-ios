/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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
@available(iOS 13.0, *)
class Screenshots: XCTestCase {

    var screenshotNameDelimiter = "_"

    lazy var app: XCUIApplication = {
        return XCUIApplication()
    }()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // UI tests must launch the application that they test.
        // Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state -
        //such as interface orientation - required for your tests before they run.
        // The setUp method is a good place to do this.
    }

    func saveScreenshot(component componentName: String, scenario scenarioName: String, delay: UInt32 = 1 ) {
        sleep(delay)
        let outputName = componentName + screenshotNameDelimiter + scenarioName +
            screenshotNameDelimiter + screenshotNameDelimiter
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = outputName
        add(attachment)
    }

    func tapBackButton() {
        XCUIApplication().navigationBars.buttons.element(boundBy: 0).tap()
    }

    func tapDialogScrimView () {
        let dialogScrimViewCoordinate: XCUICoordinate =
            app.otherElements["dialogScrimView"].coordinate(withNormalizedOffset: CGVector(dx: 10.0, dy: 10.0))
        dialogScrimViewCoordinate.tap()
    }

    func testTakeScreenshts() {
        app.tables.staticTexts["Badges"].tap()
        saveScreenshot(component: "Badge", scenario: "all")
        tapBackButton()

        app.tables.staticTexts["Bottom Sheet"].tap()
        app.tables.staticTexts["Bottom Sheet with a bottom section"].tap()
        saveScreenshot(component: "BottomSheet", scenario: "with-bottom-section")
        app.buttons["Dismiss"].tap()
        tapBackButton()

        app.tables.staticTexts["Buttons"].tap()
        app.tables.staticTexts["Primary"].tap()
        saveScreenshot(component: "Button", scenario: "primary")
        tapBackButton()
        app.tables.staticTexts["Secondary"].tap()
        saveScreenshot(component: "Button", scenario: "secondary")
        tapBackButton()
        app.tables.staticTexts["Destructive"].tap()
        saveScreenshot(component: "Button", scenario: "destructive")
        tapBackButton()
        app.tables.staticTexts["Featured"].tap()
        saveScreenshot(component: "Button", scenario: "featured")
        tapBackButton()
        app.tables.staticTexts["Link"].tap()
        saveScreenshot(component: "Button", scenario: "link")
        tapBackButton()
        app.tables.staticTexts["Outline"].tap()
        saveScreenshot(component: "Button", scenario: "outline")
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Calendar"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "Calendar", scenario: "single")
        app.buttons["Range"].tap()
        saveScreenshot(component: "Calendar", scenario: "range")
        app.buttons["Multiple"].tap()
        saveScreenshot(component: "Calendar", scenario: "multiple")
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Cards"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "Card", scenario: "default")
        tapBackButton()
        app.tables.staticTexts["Without padding"].tap()
        saveScreenshot(component: "Card", scenario: "without-padding")
        tapBackButton()
        app.tables.staticTexts["Selected"].tap()
        saveScreenshot(component: "Card", scenario: "selected")
        tapBackButton()
        app.tables.staticTexts["Corner style large"].tap()
        saveScreenshot(component: "Card", scenario: "corner-style-large")
        tapBackButton()
        app.tables.staticTexts["Background color"].tap()
        saveScreenshot(component: "Card", scenario: "background-color")
        tapBackButton()
        app.tables.staticTexts["With divider"].tap()
        saveScreenshot(component: "Card", scenario: "with-divider")
        tapBackButton()
        app.tables.staticTexts["With divider arranged vertically"].tap()
        saveScreenshot(component: "Card", scenario: "with-divider-arranged-vertically")
        tapBackButton()
        app.tables.staticTexts["With divider without padding"].tap()
        saveScreenshot(component: "Card", scenario: "with-divider-without-padding")
        tapBackButton()
        app.tables.staticTexts["With divider and corner style large"].tap()
        saveScreenshot(component: "Card", scenario: "with-divider-and-corner-style-large")
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Chips"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "Chip", scenario: "default")
        tapBackButton()
        app.tables.staticTexts["Without shadow"].tap()
        saveScreenshot(component: "Chip", scenario: "without-shadow")
        tapBackButton()
        app.tables.staticTexts["Background color unselected no shadow"].tap()
        saveScreenshot(component: "Chip", scenario: "background-color")
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Dialogs"].tap()
        app.tables.staticTexts["With call to action"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "Dialog", scenario: "with-cta")
        tapDialogScrimView()
        tapBackButton()
        app.tables.staticTexts["Warning"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "Dialog", scenario: "warning")
        tapDialogScrimView()
        tapBackButton()
        app.tables.staticTexts["With no title"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "Dialog", scenario: "no-title")
        tapDialogScrimView()
        tapBackButton()
        app.tables.staticTexts["Delete confirmation"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "Dialog", scenario: "delete-confirmation")
        app.buttons["Delete"].tap()
        tapBackButton()
        app.tables.staticTexts["Success"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "Dialog", scenario: "success")
        tapDialogScrimView()
        tapBackButton()
        app.tables.staticTexts["With no icon"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "Dialog", scenario: "no-icon")
        app.buttons["Got it"].tap()
        tapBackButton()
        app.tables.staticTexts["With no icon and no title"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "Dialog", scenario: "no-title-no-icon")
        app.buttons["Got it"].tap()
        tapBackButton()
        app.tables.staticTexts["In-app messaging"].tap()
        app.buttons["Show"].tap()
        saveScreenshot(component: "Dialog", scenario: "in-app-messaging")
        tapDialogScrimView()
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Flare views"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "FlareView", scenario: "default")
        tapBackButton()
        app.tables.staticTexts["Background image"].tap()
        saveScreenshot(component: "FlareView", scenario: "background-image")
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Horizontal navigation"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "Horizontal navigation", scenario: "default")
        tapBackButton()
        app.tables.staticTexts["Small"].tap()
        saveScreenshot(component: "Horizontal navigation", scenario: "small")
        tapBackButton()
        app.tables.staticTexts["Without underline"].tap()
        saveScreenshot(component: "Horizontal navigation", scenario: "without-underline")
        tapBackButton()
        app.tables.staticTexts["With icons"].tap()
        saveScreenshot(component: "Horizontal navigation", scenario: "with-icons")
        tapBackButton()
        app.tables.staticTexts["Small with icons"].tap()
        saveScreenshot(component: "Horizontal navigation", scenario: "small-with-icons")
        tapBackButton()
        app.tables.staticTexts["Wide"].tap()
        saveScreenshot(component: "Horizontal navigation", scenario: "wide")
        tapBackButton()
        app.tables.staticTexts["With scroll"].tap()
        saveScreenshot(component: "Horizontal navigation", scenario: "with-scroll")
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Icons"].tap()
        saveScreenshot(component: "Icon", scenario: "all")
        tapBackButton()

        app.tables.staticTexts["Labels"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "Label", scenario: "default")
        tapBackButton()
        app.tables.staticTexts["Emphasized"].tap()
        saveScreenshot(component: "Label", scenario: "emphasized")
        tapBackButton()
        app.tables.staticTexts["Heavy"].tap()
        saveScreenshot(component: "Label", scenario: "heavy")
        tapBackButton()
        app.tables.staticTexts["Multiple font styles"].tap()
        saveScreenshot(component: "Label", scenario: "multiple-font-styles")
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Navigation bars"].tap()
        app.tables.staticTexts["With buttons"].tap()
        saveScreenshot(component: "NavigationBar", scenario: "full-height")
        app.swipeUp()
        saveScreenshot(component: "NavigationBar", scenario: "collapsed")
        app.buttons["Back"].tap()
        tapBackButton()

        app.tables.staticTexts["Panels"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "Panel", scenario: "default")
        tapBackButton()
        app.tables.staticTexts["Without padding"].tap()
        saveScreenshot(component: "Panel", scenario: "without-padding")
        tapBackButton()
        app.tables.staticTexts["Elevated"].tap()
        saveScreenshot(component: "Panel", scenario: "elevated")
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Progress bar"].tap()
        app.buttons["Increase"].tap()
        app.buttons["Increase"].tap()
        saveScreenshot(component: "ProgressBar", scenario: "default")
        tapBackButton()

        app.tables.staticTexts["Rating"].tap()
        app.tables.staticTexts["Default"].tap()
        saveScreenshot(component: "Rating", scenario: "default")
        tapBackButton()
        app.tables.staticTexts["With subtitles"].tap()
        saveScreenshot(component: "Rating", scenario: "subtitles")
        tapBackButton()
        app.tables.staticTexts["Sizes"].tap()
        saveScreenshot(component: "Rating", scenario: "sizes")
        tapBackButton()
        app.tables.staticTexts["Vertical layout"].tap()
        saveScreenshot(component: "Rating", scenario: "vertical")
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Spinners"].tap()
        saveScreenshot(component: "Spinner", scenario: "all")
        tapBackButton()

        app.tables.staticTexts["Star ratings"].tap()
        app.tables.staticTexts["Docs"].tap()
        saveScreenshot(component: "StarRating", scenario: "docs")
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Switches"].tap()
        saveScreenshot(component: "Switch", scenario: "default")
        tapBackButton()

        app.tables.staticTexts["Tappable link labels"].tap()
        app.tables.staticTexts["Text with single link"].tap()
        saveScreenshot(component: "TappableLinkLabel", scenario: "single")
        tapBackButton()
        app.tables.staticTexts["Text with multiple links"].tap()
        saveScreenshot(component: "TappableLinkLabel", scenario: "multiple")
        tapBackButton()
        app.tables.staticTexts["Alternate style"].tap()
        saveScreenshot(component: "TappableLinkLabel", scenario: "alternate-style")
        tapBackButton()
        tapBackButton()

        app.tables.staticTexts["Text fields"].tap()
        saveScreenshot(component: "TextField", scenario: "default")
        tapBackButton()

        app.tables.staticTexts["Text views"].tap()
        saveScreenshot(component: "TextView", scenario: "default")
        tapBackButton()

        app.tables.staticTexts["Toasts"].tap()
        app.tables.staticTexts["Default toast"].tap()
        app.buttons["Show Toast"].tap()
        saveScreenshot(component: "Toast", scenario: "default")
        tapBackButton()
        tapBackButton()
    }
}
