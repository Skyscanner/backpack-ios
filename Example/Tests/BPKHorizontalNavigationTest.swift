/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

import Foundation
import XCTest
import Backpack

typealias DefaultNav = BPKHorizontalNavigation<BPKHorizontalNavigationSizeDefault>

class BPKHorizontalNavigationTest: XCTestCase {
    var horizontalNav: DefaultNav!

    override func setUp() {
        horizontalNav = DefaultNav(options: [
            .text("Flights", tag: 0),
            .text("Hotels", tag: 1),
            .text("Car Hire", tag: 2)
        ], selectedItemIndex: 0)
    }

    func testInitWithOptions() {
        XCTAssertEqual(horizontalNav.options, [
            .text("Flights", tag: 0),
            .text("Hotels", tag: 1),
            .text("Car Hire", tag: 2)
        ])
    }

    func testInitWithSelectedItemIndex() {
        let horizontalNav = DefaultNav(options: [
            .text("Flights", tag: 0),
            .text("Hotels", tag: 1),
            .text("Car HIre", tag: 2)
        ], selectedItemIndex: 2)

        XCTAssertEqual(horizontalNav.selectedItemIndex, 2)
    }

    func testSetSelectedItemIndex() {
        let horizontalNav = DefaultNav(options: [
            .text("Flights", tag: 0),
            .text("Hotels", tag: 1),
            .text("Car HIre", tag: 2)
        ], selectedItemIndex: 2)

        XCTAssertEqual(horizontalNav.selectedItemIndex, 2)

        horizontalNav.selectedItemIndex = 0

        XCTAssertEqual(horizontalNav.selectedItemIndex, 0)
    }

    func testSetOptions() {
        horizontalNav.options = [
            .textAndIcon("Test", icon: BPKLargeIconName.accessibility)
        ]

        XCTAssertEqual(horizontalNav.options, [
            .textAndIcon("Test", icon: BPKLargeIconName.accessibility)
        ])
    }

    func testDefaultAppearance() {
        XCTAssertEqual(horizontalNav.appearance, .normal)
    }

    func testSetAppearance() {
        XCTAssertEqual(horizontalNav.appearance, .normal)

        horizontalNav.appearance = .alternate

        XCTAssertEqual(horizontalNav.appearance, .alternate)
    }
}
