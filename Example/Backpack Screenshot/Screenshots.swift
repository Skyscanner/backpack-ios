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

    @MainActor
    func testLightModeScreenshots() async {
       app = createApp()
        app.launchArguments.append("FORCE_LIGHT_MODE")
       setupSnapshot(app)
       app.launch()

       // Wait for app to be fully ready
       _ = app.wait(for: .runningForeground, timeout: 5)
       sleep(2) // Extra wait for UI to settle

       await captureAllScreenshots()
    }

    @MainActor
    func testDarkModeScreenshots() async {
       app = createApp()
       app.launchArguments.append("FORCE_DARK_MODE")
       setupSnapshot(app)
       app.launch()

       _ = app.wait(for: .runningForeground, timeout: 5)
       sleep(3) // Extra wait for dark mode rendering to settle

       await captureAllScreenshots(userInterfaceStyle: .dark)
    }

    @MainActor
    func captureAllScreenshots(userInterfaceStyle: UIUserInterfaceStyle = .light) async {
        await navigate(title: "Badges") {
            saveScreenshot(component: "badge", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Bar charts") {
            app.cells.element(boundBy: 3).tap()
            saveScreenshot(component: "bar-chart", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }


        await navigate(title: "Bottom sheet") {
            switchTab(title: "UIKit")
            sleep(1)

            // Tap the "Bottom Sheet with a bottom section" cell (index 1)
            app.tables.cells.element(boundBy: 1).tap()

            let dismissButton = app.buttons["Dismiss"]
            _ = dismissButton.waitForExistence(timeout: 5)
            saveScreenshot(component: "bottom-sheet", scenario: "with-bottom-section",
                           userInterfaceStyle: userInterfaceStyle)
            dismissButton.tap()
        }


        await navigate(title: "Buttons") {
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

        await navigate(title: "Cards") {
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
        }

        await navigate(title: "Card Button") {
            saveScreenshot(component: "card-button", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Chips") {
            switchTab(title: "UIKit")
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
        
        // MARK: Gets stuck after dismissing the dialog, adding extra tap back.
        await navigate(title: "Dialogs") {
            switchTab(title: "UIKit")
            // Wait for the table to be visible after tab switch
            _ = app.tables.firstMatch.waitForExistence(timeout: 2)

            let showButtonText = "Show dialog"

            app.tables.staticTexts["Success"].tap()
            app.buttons[showButtonText].tap()
            saveScreenshot(component: "dialog", scenario: "success", userInterfaceStyle: userInterfaceStyle)
            tapDialogScrimView()
            tapBackButton()

            // Check if we need another back tap to get to the list
            // In Xcode we need double tap, in fastlane script single tap is enough
            Thread.sleep(forTimeInterval: 0.3)
            let warningElement = app.tables.staticTexts["Warning"]
            if !warningElement.exists {
                // Not on the list yet, tap back again
                tapBackButton()
                _ = warningElement.waitForExistence(timeout: 2)
            }

            // Scroll to Warning if needed
            if !warningElement.isHittable {
                app.swipeUp()
                Thread.sleep(forTimeInterval: 0.2)
            }
            warningElement.tap()
            app.buttons[showButtonText].tap()
            saveScreenshot(component: "dialog", scenario: "warning", userInterfaceStyle: userInterfaceStyle)
            tapDialogScrimView()
            tapBackButton()

            // Check if we need another back tap to get to the list
            Thread.sleep(forTimeInterval: 0.3)
            let destructiveElement = app.tables.staticTexts["Destructive"]
            if !destructiveElement.exists {
                tapBackButton()
                _ = destructiveElement.waitForExistence(timeout: 2)
            }

            // Scroll to Destructive if needed
            if !destructiveElement.isHittable {
                app.swipeUp()
                Thread.sleep(forTimeInterval: 0.2)
            }
            destructiveElement.tap()
            app.buttons[showButtonText].tap()
            saveScreenshot(component: "dialog", scenario: "destructive", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Delete"].tap()
            tapBackButton()

            app.tables.staticTexts["Flare"].tap()
            app.buttons[showButtonText].tap()
            saveScreenshot(component: "dialog", scenario: "flare", userInterfaceStyle: userInterfaceStyle)
            tapDialogScrimView()
            tapBackButton()

            // Check if we need another back tap to get to the list
            Thread.sleep(forTimeInterval: 0.3)
            let imageElement = app.tables.staticTexts["Image"]
            if !imageElement.exists {
                tapBackButton()
                _ = imageElement.waitForExistence(timeout: 2)
            }

            // Scroll to Image if needed
            if !imageElement.isHittable {
                app.swipeUp()
                Thread.sleep(forTimeInterval: 0.2)
            }
            imageElement.tap()
            app.buttons[showButtonText].tap()
            saveScreenshot(component: "dialog", scenario: "image", userInterfaceStyle: userInterfaceStyle)
            tapDialogScrimView()
            tapBackButton()
            // Intentionally NOT calling tapBackButton() again here
            // The navigate() function will call it once more at the end to get back to main list
            Thread.sleep(forTimeInterval: 0.5)
        }

        // MARK: UIKit tests crash the app
//        await navigate(title: "Flare views") {
//            app.tables.staticTexts["Default"].tap()
//            saveScreenshot(component: "flare-view", scenario: "default", userInterfaceStyle: userInterfaceStyle)
//            tapBackButton()
//            app.tables.staticTexts["Background image"].tap()
//            saveScreenshot(component: "flare-view", scenario: "background-image", userInterfaceStyle: userInterfaceStyle)
//            tapBackButton()
//            app.tables.staticTexts["Flare at top"].tap()
//            saveScreenshot(component: "flare-view", scenario: "flare-at-top", userInterfaceStyle: userInterfaceStyle)
//            tapBackButton()
//            app.tables.staticTexts["Rounded"].tap()
//            saveScreenshot(component: "flare-view", scenario: "rounded", userInterfaceStyle: userInterfaceStyle)
//            tapBackButton()
//        }
//
        await navigate(title: "Horizontal navigation") {
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

        await navigate(title: "Icons") {
            switchTab(title: "UIKit")
            saveScreenshot(component: "icon", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Labels") {
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
        
        await navigate(title: "Links") {
            switchTab(title: "UIKit")
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

        await navigate(title: "Text fields") {
            saveScreenshot(component: "text-field", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Text views") {
            saveScreenshot(component: "text-view", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Map") {
            app.tables.staticTexts["Default"].tap()
            app.otherElements["Manchester airport"].tap()
            app.maps.otherElements["London"].firstMatch.tap()
            saveScreenshot(component: "map", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        await navigate(title: "Navigation bars") {
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

        await navigate(title: "Nudger") {
            saveScreenshot(component: "nudger", scenario: "default",
                           userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Overlay") {
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
        await navigate(title: "Progress bar") {
            app.buttons["Increase"].tap()
            app.buttons["Increase"].tap()
            saveScreenshot(component: "progress-bar", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Rating") {
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
        await navigate(title: "Spinners") {
            // Wait for the view to load
            sleep(1)
            saveScreenshot(component: "spinner", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        }
        
        // MARK: Crashes the app
//        await navigate(title: "Star ratings") {
//            app.tables.staticTexts["Docs"].tap()
//            saveScreenshot(component: "star-rating", scenario: "docs", userInterfaceStyle: userInterfaceStyle)
//            tapBackButton()
//        }
        
        await navigate(title: "Skeleton") {
            switchTab(title: "UIKit")
            // Wait for tab content to load
            _ = app.tables.firstMatch.waitForExistence(timeout: 2)
            sleep(1)
            saveScreenshot(component: "skeleton", scenario: "all", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Switches") {
            switchTab(title: "UIKit")
            // Wait for tab content to load
            _ = app.tables.firstMatch.waitForExistence(timeout: 2)
            sleep(1)
            saveScreenshot(component: "switch", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Tab bar controller") {
            // Wait for the view to load
            sleep(1)
            saveScreenshot(component: "tab-bar-controller", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Toasts") {
            app.tables.staticTexts["Docs"].tap()
            app.buttons["Show Toast"].tap()
            saveScreenshot(component: "toast", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            // Wait for toast to disappear before trying to tap back
            sleep(3)
            tapBackButton()
        }
        
        await navigate(title: "Page indicators") {
            saveScreenshot(component: "page-indicator", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Price") {
            app.tables.staticTexts["ExtraSmall"].tap()
            saveScreenshot(component: "price", scenario: "extraSmall", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Small"].tap()
            saveScreenshot(component: "price", scenario: "small", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Large"].tap()
            saveScreenshot(component: "price", scenario: "large", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Floating notification") {
            app.buttons["With icon and action"].tap()
            saveScreenshot(component: "floating-notification", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
      
        await navigate(title: "Flight Leg") {
            saveScreenshot(component: "flight-leg", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Carousel") {
            saveScreenshot(component: "carousel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Carousel Card") {
            saveScreenshot(component: "carousel-card", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Card Carousel") {
            saveScreenshot(component: "card-carousel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
    }
}
