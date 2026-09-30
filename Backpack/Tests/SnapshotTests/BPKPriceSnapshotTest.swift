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
import Backpack

import SnapshotTesting

class BPKPriceSnapshotTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    private func createView(
        price: String = "£1830",
        leadingText: String? = "App only deal",
        leadingIcon: BPKIconName? = nil,
        trailingIcon: BPKIconName? = nil,
        previousPrice: String? = "£2033",
        trailingText: String? = "per day",
        onLeadingTextClicked: (() -> Void)? = nil,
        alignment: BPKPrice.Alignment = .leading,
        size: BPKPrice.Size = .large
    ) -> UIView {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = BPKColor.surfaceDefaultColor
        parentView.translatesAutoresizingMaskIntoConstraints = false

        let priceView = BPKPrice(alignment: alignment, size: size)
        priceView.price = price
        priceView.leadingText = leadingText
        priceView.leadingIcon = leadingIcon
        priceView.trailingIcon = trailingIcon
        priceView.previousPrice = previousPrice
        priceView.trailingText = trailingText
        priceView.onLeadingTextClicked = onLeadingTextClicked

        priceView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(priceView)
        
        NSLayoutConstraint.activate([
            priceView.topAnchor.constraint(equalTo: parentView.topAnchor),
            priceView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            priceView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            priceView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
        
        return parentView
    }
    
    func testViewSnapshotWithLeadingAndLarge() {
        let exampleView = createView(alignment: .leading, size: .large)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithLeadingAndSmall() {
        let exampleView = createView(alignment: .leading, size: .small)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithLeadingAndExtraSmall() {
        let exampleView = createView(alignment: .leading, size: .extraSmall)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithTrailingAndLarge() {
        let exampleView = createView(alignment: .trailing, size: .large)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithTrailingAndSmall() {
        let exampleView = createView(alignment: .trailing, size: .small)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithTrailingAndExtraSmall() {
        let exampleView = createView(alignment: .trailing, size: .extraSmall)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithNoPreviousPrice() {
        let exampleView = createView(previousPrice: nil)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithNoLeadingText() {
        let exampleView = createView(leadingText: nil)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithNoTrailingText() {
        let exampleView = createView(trailingText: nil)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithPriceOnly() {
        let exampleView = createView(leadingText: nil, previousPrice: nil, trailingText: nil)
        assertSnapshot(exampleView)
    }

    func testViewSnapshotWithTappableLeadingTextAndIcon() {
        let exampleView = createView(
            price: "£50",
            leadingText: "£10 cheaper",
            trailingIcon: .informationCircle,
            previousPrice: nil,
            trailingText: nil,
            onLeadingTextClicked: {}
        )
        assertSnapshot(exampleView)
    }

    func testViewSnapshotWithTappableLeadingTextAndLeadingAndTrailingIcons() {
        let exampleView = createView(
            price: "£50",
            leadingText: "£10 cheaper",
            leadingIcon: .informationCircle,
            trailingIcon: .informationCircle,
            previousPrice: nil,
            trailingText: nil,
            onLeadingTextClicked: {}
        )
        assertSnapshot(exampleView)
    }
}
