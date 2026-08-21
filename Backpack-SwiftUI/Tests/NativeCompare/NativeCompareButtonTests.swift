//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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
import Backpack_Common

/// One cropped image per button type, light and dark, for the "Backpack on native" audit.
final class NativeCompareButtonTests: XCTestCase {
    func testPrimary() {
        snapshot(.primary)
    }

    func testSecondary() {
        snapshot(.secondary)
    }

    func testDestructive() {
        snapshot(.destructive)
    }

    func testLink() {
        snapshot(.link)
    }

    func testPrimaryAtLargeText() {
        largeTextSnapshot(.primary)
    }

    func testSecondaryAtLargeText() {
        largeTextSnapshot(.secondary)
    }

    func testDestructiveAtLargeText() {
        largeTextSnapshot(.destructive)
    }

    func testLinkAtLargeText() {
        largeTextSnapshot(.link)
    }

    /// The same row at a large Dynamic Type size, light only: swatches and columns must grow with the text.
    private func largeTextSnapshot(
        _ pair: ButtonComparison,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        BPKFont.setDynamicType(enabled: true)
        defer { BPKFont.setDynamicType(enabled: false) }
        assertSnapshot(
            NativeCompareButtonRow(pair: pair)
                .frame(width: 720)
                .environment(\.sizeCategory, .accessibilityLarge),
            modes: [.light],
            file: file,
            testName: testName,
            line: line
        )
    }

    private func snapshot(
        _ pair: ButtonComparison,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        assertSnapshot(
            NativeCompareButtonRow(pair: pair).frame(width: 720),
            modes: [.light, .dark],
            file: file,
            testName: testName,
            line: line
        )
    }
}
