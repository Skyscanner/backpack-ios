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
    
    private func createView(alignment: BPKPrice.Alignment, size: BPKPrice.Size) -> UIView {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = BPKColor.surfaceDefaultColor
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        let price = createPrice(alignment: alignment, size: size)
        
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
    
    private func createPrice(alignment: BPKPrice.Alignment, size: BPKPrice.Size) -> BPKPrice {
        let price = BPKPrice(
            price: "£1830",
            leadingText: "App only deal",
            lineThroughText: "£2033",
            trailingText: "per day",
            alignment: alignment,
            size: size
        )

        return price
    }
    
    func testViewSnapshotWithLeftAndLarge() {
        let exampleView = createView(alignment: .left, size: .large)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithLeftAndSmall() {
        let exampleView = createView(alignment: .left, size: .small)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithRightAndLarge() {
        let exampleView = createView(alignment: .right, size: .large)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithRightAndSmall() {
        let exampleView = createView(alignment: .right, size: .small)
        assertSnapshot(exampleView)
    }
}
