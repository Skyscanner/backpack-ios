/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

final class BPKCardSnapshotTest: XCTestCase {

    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }
    
    func testViewSnapshotWithoutPadded() {
        // Given
        let sut = BPKCard(padded: false)
        let innerView = UIView()
        innerView.backgroundColor = BPKColor.statusSuccessFillColor
        
        // When
        configure(card: sut, withInnerView: innerView)
        let snapshotView = embed(card: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    // MARK: Helpers
    private func configure(card: BPKCard, withInnerView innerView: UIView) {
        [innerView, card].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        card.subview = innerView
        
        NSLayoutConstraint.activate([
            innerView.widthAnchor.constraint(equalToConstant: 90),
            innerView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func embed(card: BPKCard) -> UIView {
        let parentView = UIView()
        parentView.backgroundColor = BPKColor.canvasColor
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: BPKSpacingBase),
            card.topAnchor.constraint(equalTo: parentView.topAnchor, constant: BPKSpacingBase),
            
            card.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -BPKSpacingBase),
            card.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -BPKSpacingBase)
        ])
        
        return parentView
    }
}
