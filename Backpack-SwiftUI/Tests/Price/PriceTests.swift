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

    private func testView(
        size: BPKPrice.Size,
        alignment: BPKPrice.Alignment
    ) -> some View {
        let styles: [BPKPrice.Style] = [.default, .onContrast]

        return VStack(alignment: .leading, spacing: .base) {
            ForEach(Array(styles.enumerated()), id: \.offset) { _, style in
                self.styleView(
                    style: style,
                    size: size,
                    alignment: alignment
                )
            }
        }
    }

    private func styleView(
        style: BPKPrice.Style,
        size: BPKPrice.Size,
        alignment: BPKPrice.Alignment
    ) -> some View {
        let backgroundColor: BPKColor = style == .default
            ? .surfaceDefaultColor
            : .surfaceContrastColor

        return VStack(alignment: .leading, spacing: .sm) {
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.base)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .background(backgroundColor)
        }
    }

    func test_small_withLeadingAlignment() {
        assertSnapshot(testView(size: .small, alignment: .leading))
    }

    func test_small_withTrailingAlignment() {
        assertSnapshot(testView(size: .small, alignment: .trailing))
    }

    func test_small_withRowAlignment() {
        assertSnapshot(testView(size: .small, alignment: .row))
    }

    func test_extraSmall_withLeadingAlignment() {
        assertSnapshot(testView(size: .extraSmall, alignment: .leading))
    }

    func test_extraSmall_withTrailingAlignment() {
        assertSnapshot(testView(size: .extraSmall, alignment: .trailing))
    }

    func test_extraSmall_withRowAlignment() {
        assertSnapshot(testView(size: .extraSmall, alignment: .row))
    }

    func test_large_withLeadingAlignment() {
        assertSnapshot(testView(size: .large, alignment: .leading))
    }

    func test_large_withTrailingAlignment() {
        assertSnapshot(testView(size: .large, alignment: .trailing))
    }
}
