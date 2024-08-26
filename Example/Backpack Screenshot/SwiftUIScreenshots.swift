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
        app.launchArguments.append("FORCE_LIGHT_MODE")
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
        await navigate(title: "Labels") {
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
            
            app.tables.staticTexts["Hero"].tap()
            saveScreenshot(component: "text", scenario: "hero", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Buttons") {
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

        await navigate(title: "Rating") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["BPKRating: title text"].tap()
            saveScreenshot(component: "rating", scenario: "with-title-text", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["BPKRating: titleView image"].tap()
            saveScreenshot(component: "rating", scenario: "with-custom-title-view-image", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Switches") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "switch", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Cards") {
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
        
        await navigate(title: "Overlay") {
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
        
        await navigate(title: "Badges") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "badge", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Spinners") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "spinner", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Banner Alert") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "banner-alert", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Skeleton") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "skeleton", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Text area") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "text-area", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Text fields") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "text-field", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Bottom sheet") {
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
        
        await navigate(title: "Price") {
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
        
        await navigate(title: "Chips") {
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
        
        await navigate(title: "Chip Group") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Rail - Single Select"].tap()
            saveScreenshot(component: "chip-group-single", scenario: "rail", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Wrap - Single Select"].tap()
            saveScreenshot(component: "chip-group-single", scenario: "wrap", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Rail - Multi Select"].tap()
            saveScreenshot(component: "chip-group-multi", scenario: "rail", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Wrap - Multi Select"].tap()
            saveScreenshot(component: "chip-group-multi", scenario: "wrap", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Dialogs") {
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
        
        await navigate(title: "Flare views") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "flare-view", scenario: "all", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Panels") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "panel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Nudger") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "nudger", scenario: "default",
                           userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Slider") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Sliders"].tap()
            saveScreenshot(component: "slider", scenario: "all", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Star ratings") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Star rating"].tap()
            saveScreenshot(component: "star-rating", scenario: "all", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        await navigate(title: "Map") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "map-markers", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Progress bar") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "progress-bar", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Carousel") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "carousel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Carousel Card") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "carousel-card", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Card Carousel") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "card-carousel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Section header") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Default"].tap()
            saveScreenshot(component: "section-header", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["On Dark"].tap()
            saveScreenshot(component: "section-header", scenario: "on-dark", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        await navigate(title: "Card list") {
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
        
        await navigate(title: "Graphic promo") {
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

        await navigate(title: "Calendar") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Range Selection"].tap()
            saveScreenshot(component: "calendar", scenario: "range", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Single Selection"].tap()
            saveScreenshot(component: "calendar", scenario: "single", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Snippet") {
            app.tables.staticTexts["Landscape"].tap()
            saveScreenshot(component: "snippet", scenario: "landscape", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()

            app.tables.staticTexts["Square"].tap()
            saveScreenshot(component: "snippet", scenario: "square", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()

            app.tables.staticTexts["Portrait"].tap()
            saveScreenshot(component: "snippet", scenario: "portrait", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Inset Banner") {
            saveScreenshot(component: "inset-banner", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "App Search Modal") {
            app.tables.staticTexts["Loading"].tap()
            saveScreenshot(component: "app-search-modal", scenario: "loading", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()

            app.tables.staticTexts["Content"].tap()
            saveScreenshot(component: "app-search-modal", scenario: "content", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()

            app.tables.staticTexts["Error"].tap()
            saveScreenshot(component: "app-search-modal", scenario: "error", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

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
            tapBackButton()
        }
        
        await navigate(title: "Buttons") {
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

        await navigate(title: "Rating") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["BPKRating: title text"].tap()
            saveScreenshot(component: "rating", scenario: "with-title-text", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["BPKRating: titleView image"].tap()
            saveScreenshot(component: "rating", scenario: "with-custom-title-view-image", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Switches") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "switch", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Cards") {
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
        
        await navigate(title: "Overlay") {
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
        
        await navigate(title: "Badges") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "badge", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Spinners") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "spinner", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Skeleton") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "skeleton", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Text area") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "text-area", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Text fields") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "text-field", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Search Input Summary") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "search-input-summary", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Bottom sheet") {
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
        
        await navigate(title: "Price") {
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
        
        await navigate(title: "Chips") {
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
        
        await navigate(title: "Chip Group") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Rail - Single Select"].tap()
            saveScreenshot(component: "chip-group-single", scenario: "rail", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Wrap - Single Select"].tap()
            saveScreenshot(component: "chip-group-single", scenario: "wrap", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Rail - Multi Select"].tap()
            saveScreenshot(component: "chip-group-multi", scenario: "rail", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Wrap - Multi Select"].tap()
            saveScreenshot(component: "chip-group-multi", scenario: "wrap", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Dialogs") {
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
        
        await navigate(title: "Flare views") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "flare-view", scenario: "all", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Panels") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "panel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Nudger") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "nudger", scenario: "default",
                           userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Slider") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Sliders"].tap()
            saveScreenshot(component: "slider", scenario: "all", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Star ratings") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Star rating"].tap()
            saveScreenshot(component: "star-rating", scenario: "all", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        await navigate(title: "Map") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "map-markers", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Progress bar") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "progress-bar", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }

        await navigate(title: "Carousel") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "carousel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Carousel Card") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "carousel-card", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Card Carousel") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "card-carousel", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Section header") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Default"].tap()
            saveScreenshot(component: "section-header", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["On Dark"].tap()
            saveScreenshot(component: "section-header", scenario: "on-dark", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }

        await navigate(title: "Card list") {
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
        
        await navigate(title: "Graphic promo") {
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

        await navigate(title: "Calendar") {
            switchTab(title: "SwiftUI")
            app.tables.staticTexts["Range Selection"].tap()
            saveScreenshot(component: "calendar", scenario: "range", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
            app.tables.staticTexts["Single Selection"].tap()
            saveScreenshot(component: "calendar", scenario: "single", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Field Set") {
            app.tables.staticTexts["Default State"].tap()
            saveScreenshot(component: "field-set", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()

            app.tables.staticTexts["Error State"].tap()
            saveScreenshot(component: "field-set", scenario: "error", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Snippet") {
            app.tables.staticTexts["Landscape"].tap()
            saveScreenshot(component: "snippet", scenario: "landscape", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()

            app.tables.staticTexts["Square"].tap()
            saveScreenshot(component: "snippet", scenario: "square", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()

            app.tables.staticTexts["Portrait"].tap()
            saveScreenshot(component: "snippet", scenario: "portrait", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Rating Bar") {
            saveScreenshot(component: "rating-bar", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Inset Banner") {
            saveScreenshot(component: "inset-banner", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Image Gallery Preview") {
            saveScreenshot(component: "image-gallery-preview", scenario: "default", userInterfaceStyle: userInterfaceStyle)
        }
        
        await navigate(title: "Image Gallery Slideshow") {
            saveScreenshot(component: "image-gallery-slideshow", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Close"].tap()
        }
        
        await navigate(title: "Image Gallery Grid") {
            app.buttons["Show Chip Categories"].tap()
            saveScreenshot(component: "image-gallery-grid", scenario: "chips", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Close Gallery"].tap()
            app.buttons["Show Image Categories"].tap()
            saveScreenshot(component: "image-gallery-grid", scenario: "images", userInterfaceStyle: userInterfaceStyle)
            app.buttons["Close Gallery"].tap()
        }
        
        await navigate(title: "App Search Modal") {
            app.tables.staticTexts["Loading"].tap()
            saveScreenshot(component: "app-search-modal", scenario: "loading", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()

            app.tables.staticTexts["Content"].tap()
            saveScreenshot(component: "app-search-modal", scenario: "content", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()

            app.tables.staticTexts["Error"].tap()
            saveScreenshot(component: "app-search-modal", scenario: "error", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Horizontal navigation") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "horizontal-navigation", scenario: "default", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
        
        await navigate(title: "Card Button") {
            switchTab(title: "SwiftUI")
            saveScreenshot(component: "card-button", scenario: "all", userInterfaceStyle: userInterfaceStyle)
            tapBackButton()
        }
    }
}
