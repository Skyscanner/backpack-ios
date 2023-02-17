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
        previousPrice: String? = "£2033",
        trailingText: String? = "per day",
        alignment: BPKPrice.Alignment = .leading,
        size: BPKPrice.Size = .large
    ) -> UIView {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = BPKColor.surfaceDefaultColor
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        let price = BPKPrice(
            price: price,
            leadingText: leadingText,
            previousPrice: previousPrice,
            trailingText: trailingText,
            alignment: alignment,
            size: size
        )
        
        price.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(price)
        
        NSLayoutConstraint.activate([
            price.topAnchor.constraint(equalTo: parentView.topAnchor),
            price.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            price.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            price.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
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
    
    func testViewSnapshotWithTrailingAndLarge() {
        let exampleView = createView(alignment: .trailing, size: .large)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithTrailingAndSmall() {
        let exampleView = createView(alignment: .trailing, size: .small)
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
}
