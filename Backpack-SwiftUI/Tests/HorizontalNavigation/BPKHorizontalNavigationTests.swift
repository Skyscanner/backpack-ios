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
import SwiftUI
@testable import Backpack_SwiftUI

class BPKHorizontalNavigationTests: XCTestCase {
    func test_allTabsWithoutIcon_defaultSize() {
        assertSnapshot(
            BPKHorizontalNavigation(
                tabs: [.init(title: "One"), .init(title: "Two"), .init(title: "Three")],
                selectedTab: 1
            )
            .frame(width: 400)
        )
    }
    
    func test_allTabsWithoutIcon_smallSize() {
        assertSnapshot(
            BPKHorizontalNavigation(
                tabs: [.init(title: "One"), .init(title: "Two"), .init(title: "Three")],
                size: .small,
                selectedTab: 1
            )
            .frame(width: 400)
        )
    }

    func test_allTabsWithIcon_defaultSize() {
        assertSnapshot(
            BPKHorizontalNavigation(
                tabs: [
                    .init(title: "One", icon: .flight),
                    .init(title: "Two", icon: .flight),
                    .init(title: "Three", icon: .flight)
                ],
                selectedTab: 1
            )
            .frame(width: 400)
        )
    }

    func test_allTabsWithIcon_smallSize() {
        assertSnapshot(
            BPKHorizontalNavigation(
                tabs: [
                    .init(title: "One", icon: .flight),
                    .init(title: "Two", icon: .flight),
                    .init(title: "Three", icon: .flight)
                ],
                size: .small,
                selectedTab: 1
            )
            .frame(width: 400)
        )
    }
    
    func test_accessibility() {
        assertA11ySnapshot(
            BPKHorizontalNavigation(
                tabs: [
                    .init(title: "One", icon: .flight),
                    .init(title: "Two", icon: .flight),
                    .init(title: "Three", icon: .flight)
                ],
                selectedTab: 1
            )
        )
    }
}

extension BPKHorizontalNavigation.Tab {
    init(title: String, icon: BPKIcon? = nil) {
        self.init(title: title, icon: icon, onClick: {})
    }
}
