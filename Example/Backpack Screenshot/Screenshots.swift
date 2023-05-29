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
        }

        navigate(title: "Nudger") {
            saveScreenshot(component: "nudger", scenario: "default",
                           userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Overlay") {
            switchTab(title: "UIKit")
            app.tables.staticTexts["Solid"].tap()
            saveScreenshot(component: "overlay", scenario: "solid", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Top"].tap()
            saveScreenshot(component: "overlay", scenario: "top", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Bottom"].tap()
            saveScreenshot(component: "overlay", scenario: "bottom", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Left"].tap()
            saveScreenshot(component: "overlay", scenario: "left", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Right"].tap()
            saveScreenshot(component: "overlay", scenario: "right", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Vignette"].tap()
            saveScreenshot(component: "overlay", scenario: "vignette", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Panels") {
            app.tables.staticTexts["Default"].tap()
            saveScreenshot(component: "panel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Without padding"].tap()
            saveScreenshot(component: "panel", scenario: "without-padding", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Elevated"].tap()
            saveScreenshot(component: "panel", scenario: "elevated", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Progress bar") {
            app.buttons["Increase"].tap()
            app.buttons["Increase"].tap()
            saveScreenshot(component: "progress-bar", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Rating") {
            app.tables.staticTexts["BPKRating: title text"].tap()
            saveScreenshot(component: "rating", scenario: "with-title-text", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["BPKRating: titleView - BPKStarRating"].tap()
            saveScreenshot(component: "rating", scenario: "with-custom-title-view-star-rating", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["BPKRating: titleView - ImageView"].tap()
            saveScreenshot(component: "rating", scenario: "with-custom-title-view-image-view", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Snackbar") {
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
        }

        navigate(title: "Spinners") {
            saveScreenshot(component: "spinner", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        }
        
        navigate(title: "Star ratings") {
            app.tables.staticTexts["Docs"].tap()
            saveScreenshot(component: "star-rating", scenario: "docs", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Skeleton") {
            switchTab(title: "UIKit")
            saveScreenshot(component: "skeleton", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Switches") {
            switchTab(title: "UIKit")
            saveScreenshot(component: "switch", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Tab bar controller") {
            saveScreenshot(component: "tab-bar-controller", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Tappable link labels") {
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
        }

        navigate(title: "Text fields") {
            saveScreenshot(component: "text-field", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Text views") {
            saveScreenshot(component: "text-view", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Toasts") {
            app.tables.staticTexts["Docs"].tap()
            app.buttons["Show Toast"].tap()
            saveScreenshot(component: "toast", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Page indicators") {
            saveScreenshot(component: "page indicator", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Price") {
            app.tables.staticTexts["Small"].tap()
            saveScreenshot(component: "price", scenario: "small", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Large"].tap()
            saveScreenshot(component: "price", scenario: "large", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Floating notification") {
            app.buttons["With icon and action"].tap()
            saveScreenshot(component: "floating-notification", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
      
        navigate(title: "Flight Leg") {
            saveScreenshot(component: "flight-leg", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Carousel") {
            saveScreenshot(component: "carousel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
    }
}
