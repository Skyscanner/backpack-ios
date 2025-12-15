/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

final class BPKCardWrapperSnapshotTests: XCTestCase {
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    func testViewSnapshotWithCard() {
        // Given
        let sut = BPKCardWrapper(
            header: createHeader(title: "BPKObjcUIKitCard"),
            card: createCard(
                isDivided: false,
                cornerStyle: .small,
                isPadded: true
            ),
            backgroundColor: BPKColor.coreAccentColor)
        
        // When
        let snapshotView = embed(wrapper: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testViewSnapshotWithCardAndPrimaryColor() {
        // Given
        let sut = BPKCardWrapper(
            header: createHeader(title: "Primary color"),
            card: createCard(
                isDivided: false,
                cornerStyle: .small,
                isPadded: true
            ),
            backgroundColor: BPKColor.corePrimaryColor)
        
        // When
        let snapshotView = embed(wrapper: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testViewSnapshotWithCardNotElevated() {
        // Given
        let sut = BPKCardWrapper(
            header: createHeader(title: "Not elevated"),
            card: createCard(
                isDivided: false,
                cornerStyle: .small,
                isPadded: true
            ),
            backgroundColor: BPKColor.coreAccentColor)
        sut.elevation = .none
        
        // When
        let snapshotView = embed(wrapper: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testViewSnapshotWithCardAndCorneStyleLarge() {
        // Given
        let sut = BPKCardWrapper(
            header: createHeader(title: "Corner style large"),
            card: createCard(
                isDivided: false,
                cornerStyle: .large,
                isPadded: true
            ),
            backgroundColor: BPKColor.coreAccentColor)
        
        // When
        let snapshotView = embed(wrapper: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testViewSnapshotWithDividedCard() {
        // Given
        let sut = BPKCardWrapper(
            header: createHeader(title: "BPKObjcUIKitDividedCard"),
            card: createCard(
                isDivided: true,
                cornerStyle: .small,
                isPadded: true
            ),
            backgroundColor: BPKColor.coreAccentColor)
        
        // When
        let snapshotView = embed(wrapper: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testViewSnapshotWithDividedCardAndNotPadded() {
        // Given
        let sut = BPKCardWrapper(
            header: createHeader(title: "BPKObjcUIKitDividedCard not padded"),
            card: createCard(
                isDivided: true,
                cornerStyle: .small,
                isPadded: false
            ),
            backgroundColor: BPKColor.coreAccentColor)
        
        // When
        let snapshotView = embed(wrapper: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
}
    
// MARK: Helpers
extension BPKCardWrapperSnapshotTests {
    private func createCard(
        isDivided: Bool,
        cornerStyle: BPKCardCornerStyle,
        isPadded: Bool
    ) -> BPKObjcUIKitCard {
        let label1 = createContectLabel(text: """
            Lorem ipsum dolor sit amet,
            consectetuer adipiscing elit.
            Aenean commodo ligula eget dolor.
        """)
        
        let label2 = createContectLabel(text: "Lorem ipsum dolor sit amet")
        
        if isDivided {
            let card = BPKObjcUIKitDividedCard()
            card.setSubviews(primarySubview: label1, secondarySubview: label2)
            card.lineStyle = .solid
            card.orientation = .vertical
            card.isElevated = false
            card.cornerStyle = cornerStyle
            card.isPadded = isPadded
            return card
        }
        
        let card = BPKObjcUIKitCard(padded: true)
        card.subview = label1
        card.isElevated = false
        card.cornerStyle = cornerStyle
        card.isPadded = isPadded
        return card
    }
    
    private func createHeader(title: String) -> UIView {
        let header = UIView()

        let label = BPKLabel(fontStyle: .textBodyDefault)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = .white
        header.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: BPKSpacingMd),
            label.topAnchor.constraint(equalTo: header.topAnchor, constant: BPKSpacingMd),
            
            label.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -BPKSpacingMd),
            label.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -BPKSpacingMd)
        ])
        
        return header
    }
    
    private func createContectLabel(text: String) -> BPKLabel {
        let label = BPKLabel(fontStyle: .textBodyDefault)
        label.text = text
        label.numberOfLines = 0
        
        return label
    }
    
    private func embed(wrapper: BPKCardWrapper) -> UIView {
        let parentView = UIView()
        parentView.backgroundColor = BPKColor.canvasColor
        parentView.translatesAutoresizingMaskIntoConstraints = false
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(wrapper)
        
        NSLayoutConstraint.activate([
            wrapper.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: BPKSpacingBase),
            wrapper.topAnchor.constraint(equalTo: parentView.topAnchor, constant: BPKSpacingBase),
            
            wrapper.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -BPKSpacingBase),
            wrapper.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -BPKSpacingBase)
        ])
        
        return parentView
    }
}
