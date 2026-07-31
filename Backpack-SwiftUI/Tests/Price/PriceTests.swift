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

class PriceTests: XCTestCase {
    struct PriceTest: Identifiable {
        let id = UUID()
        let price: String
        let previousPrice: String?
        let leadingText: String?
        let trailingText: String?
        let onPriceClicked: (() -> Void)?

        init(
            price: String,
            previousPrice: String? = nil,
            leadingText: String? = nil,
            trailingText: String? = nil,
            onPriceClicked: (() -> Void)? = nil
        ) {
            self.price = price
            self.previousPrice = previousPrice
            self.leadingText = leadingText
            self.trailingText = trailingText
            self.onPriceClicked = onPriceClicked
        }
    }
    
    let permutations: [PriceTest] = [
        .init(price: "£1,830"),
        .init(price: "£1,830", trailingText: "per day"),
        .init(price: "£1,830", previousPrice: "£2033", trailingText: "per day"),
        .init(price: "£1,830", leadingText: "App only deal", trailingText: "per day"),
        .init(price: "£1,830", previousPrice: "£2033", leadingText: "App only deal", trailingText: "per day"),
        .init(
            price: "£1,830",
            previousPrice: "£2033",
            leadingText: "App only deal",
            trailingText: "per day",
            onPriceClicked: {}
        )
    ]
    
    private var styles: [(style: BPKPrice.Style, name: String)] {
        [(.default, "default"), (.onContrast, "onContrast")]
    }

    private func testView(size: BPKPrice.Size, alignment: BPKPrice.Alignment, style: BPKPrice.Style = .default) -> some View {
        VStack(alignment: .leading) {
            ForEach(permutations) { item in
                BPKPrice(
                    price: item.price,
                    leadingText: item.leadingText,
                    previousPrice: item.previousPrice,
                    trailingText: item.trailingText,
                    style: style,
                    onPriceClicked: item.onPriceClicked,
                    alignment: alignment,
                    size: size
                )
            }
        }
    }

    func test_small_withLeadingAlignment() {
        styles.forEach { testCase in
            assertSnapshot(
                testView(size: .small, alignment: .leading, style: testCase.style),
                testName: "test_small_withLeadingAlignment_and\(testCase.name)Style"
            )
        }
    }

    func test_small_withTrailingAlignment() {
        styles.forEach { testCase in
            assertSnapshot(
                testView(size: .small, alignment: .trailing, style: testCase.style),
                testName: "test_small_withTrailingAlignment_\(testCase.name)"
            )
        }
    }

    func test_small_withRowAlignment() {
        styles.forEach { testCase in
            assertSnapshot(
                testView(size: .small, alignment: .row, style: testCase.style),
                testName: "test_small_withRowAlignment_\(testCase.name)"
            )
        }
    }

    func test_extraSmall_withLeadingAlignment() {
        styles.forEach { testCase in
            assertSnapshot(
                testView(size: .extraSmall, alignment: .leading, style: testCase.style),
                testName: "test_extraSmall_withLeadingAlignment_\(testCase.name)"
            )
        }
    }

    func test_extraSmall_withTrailingAlignment() {
        styles.forEach { testCase in
            assertSnapshot(
                testView(size: .extraSmall, alignment: .trailing, style: testCase.style),
                testName: "test_extraSmall_withTrailingAlignment_\(testCase.name)"
            )
        }
    }

    func test_extraSmall_withRowAlignment() {
        styles.forEach { testCase in
            assertSnapshot(
                testView(size: .extraSmall, alignment: .row, style: testCase.style),
                testName: "test_extraSmall_withRowAlignment_\(testCase.name)"
            )
        }
    }

    func test_large_withLeadingAlignment() {
        styles.forEach { testCase in
            assertSnapshot(
                testView(size: .large, alignment: .leading, style: testCase.style),
                testName: "test_large_withLeadingAlignment_\(testCase.name)"
            )
        }
    }

    func test_large_withTrailingAlignment() {
        styles.forEach { testCase in
            assertSnapshot(
                testView(size: .large, alignment: .trailing, style: testCase.style),
                testName: "test_large_withTrailingAlignment_\(testCase.name)"
            )
        }
    }
}
