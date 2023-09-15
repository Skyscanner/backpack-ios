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

        navigate(title: "Rating") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["BPKRating: title text"].tap()
            saveScreenshot(component: "rating", scenario: "with-title-text", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["BPKRating: titleView image"].tap()
            saveScreenshot(component: "rating", scenario: "with-custom-title-view-image", userInterfaceStyle: userInterfaceStyle)
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
        
        navigate(title: "Text fields") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "text-field", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Bottom sheet") {
            switchTab(title: "SwiftUI")
            app.buttons["Show closable bottom sheet"].tap()
            saveScreenshot(component: "bottom-sheet", scenario: "closable", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Action"].tap()
            
            app.buttons["Show large bottom sheet"].tap()
            saveScreenshot(component: "bottom-sheet", scenario: "large", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Action"].tap()

            app.buttons["Show medium bottom sheet"].tap()
            saveScreenshot(component: "bottom-sheet", scenario: "medium", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Action"].tap()
            
            app.buttons["Show fit content bottom sheet"].tap()
            saveScreenshot(component: "bottom-sheet", scenario: "content-fit", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Action"].tap()
        }
        
        navigate(title: "Price") {
            switchTab(title: "SwiftUI")
            
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
        
        navigate(title: "Chips") {
            switchTab(title: "SwiftUI")
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
        
        navigate(title: "Chip Group") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Rail - Single Select"].tap()
            saveScreenshot(component: "chip-group", scenario: "rail", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Wrap - Single Select"].tap()
            saveScreenshot(component: "chip-group", scenario: "wrap", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Dialogs") {
            switchTab(title: "SwiftUI")
            app.buttons["Modal Success"].tap()
            saveScreenshot(component: "dialog", scenario: "success", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Confirmation"].tap()
            
            _ = app.buttons["Modal Warning"].waitForExistence(timeout: 1)
            app.buttons["Modal Warning"].tap()
            saveScreenshot(component: "dialog", scenario: "warning", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Confirmation"].tap()
            
            _ = app.buttons["Modal Destructive"].waitForExistence(timeout: 1)
            app.buttons["Modal Destructive"].tap()
            saveScreenshot(component: "dialog", scenario: "destructive", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Delete"].tap()
            
            _ = app.buttons["Modal Flare"].waitForExistence(timeout: 1)
            app.buttons["Modal Flare"].tap()
            saveScreenshot(component: "dialog", scenario: "flare", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Confirmation"].tap()
            
            _ = app.buttons["Modal Image"].waitForExistence(timeout: 1)
            app.buttons["Modal Image"].tap()
            saveScreenshot(component: "dialog", scenario: "image", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Confirmation"].tap()
            _ = app.buttons["Modal Image"].waitForExistence(timeout: 1)
        }
        
        navigate(title: "Flare views") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "flare-view", scenario: "all", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Panels") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "panel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        navigate(title: "Nudger") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "nudger", scenario: "default",
                           userInterfaceStyle: userInterfaceStyle)
        }
        
        navigate(title: "Slider") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Sliders"].tap()
            saveScreenshot(component: "slider", scenario: "all", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Star ratings") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Star rating"].tap()
            saveScreenshot(component: "star-rating", scenario: "all", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Map") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "map-markers", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        navigate(title: "Progress bar") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "progress-bar", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        navigate(title: "Carousel") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "carousel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        navigate(title: "Section header") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Default"].tap()
            saveScreenshot(component: "section-header", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["On Dark"].tap()
            saveScreenshot(component: "section-header", scenario: "on-dark", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        navigate(title: "Card list") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Rail - 3 total elements"].tap()
            saveScreenshot(component: "card-list", scenario: "rail-3-elements", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Rail - 12 total elements & Section Header Button"].tap()
            saveScreenshot(component: "card-list", scenario: "rail-12-elements-with-section-header-button", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Stack - 3 initial, 12 total elements"].tap()
            saveScreenshot(component: "card-list", scenario: "stack-3-to-12-elements", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Stack - Accessory Expand"].tap()
            saveScreenshot(component: "card-list", scenario: "stack-accessory-expand", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Stack - Accessory Button"].tap()
            saveScreenshot(component: "card-list", scenario: "stack-accessory-button", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Stack - Accessory Expand & Section Header Button"].tap()
            saveScreenshot(component: "card-list", scenario: "stack-accessory-expand-with-section-header-button", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        navigate(title: "Graphic promo") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Top aligned"].tap()
            saveScreenshot(component: "graphic-promo", scenario: "top-aligned", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Bottom aligned"].tap()
            saveScreenshot(component: "graphic-promo", scenario: "bottom-aligned", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Top aligned - Sponsored"].tap()
            saveScreenshot(component: "graphic-promo", scenario: "top-aligned-sponsored", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            
            app.tables.staticTexts["Bottom aligned - Sponsored"].tap()
            saveScreenshot(component: "graphic-promo", scenario: "bottom-aligned-sponsored", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
    }
}
