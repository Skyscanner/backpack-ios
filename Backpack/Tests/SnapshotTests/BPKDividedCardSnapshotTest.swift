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

final class BPKDividedCardSnapshotTest: XCTestCase {
    private lazy var primaryInnerView: UIView = {
        let innerView = UIView()
        innerView.backgroundColor = BPKColor.statusSuccessFillColor
        return innerView
    }()
    
    private lazy var secondaryInnerView: UIView = {
        let innerView = UIView()
        innerView.backgroundColor = BPKColor.statusWarningFillColor
        return innerView
    }()
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    func testDividedSnapshotWithPaddedHorizontal() {
        // Given
        let sut = BPKDividedCard(padded: true)
        
        // When
        configure(card: sut, withPrimarySubview: primaryInnerView, secondarySubview: secondaryInnerView)
        let snapshotView = embed(card: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func createDividedSnapshotWithPaddedHorizontalAndLargeCornerStyle() {
        // Given
        let sut = BPKDividedCard(padded: true)
        sut.cornerStyle = .large
        
        // When
        configure(card: sut, withPrimarySubview: primaryInnerView, secondarySubview: secondaryInnerView)
        let snapshotView = embed(card: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testDividedSnapshotWithPaddedVertical() {
        // Given
        let sut = BPKDividedCard(padded: true)
        sut.orientation = .vertical
        
        // When
        configure(card: sut, withPrimarySubview: primaryInnerView, secondarySubview: secondaryInnerView)
        let snapshotView = embed(card: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testDividedSnapshotWithoutPaddedHorizontal() {
        // Given
        let sut = BPKDividedCard(padded: false)
        
        // When
        configure(card: sut, withPrimarySubview: primaryInnerView, secondarySubview: secondaryInnerView)
        let snapshotView = embed(card: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testDividedSnapshotWithoutPaddedHorizontalAndLargeCornerStyle() {
        // Given
        let sut = BPKDividedCard(padded: false)
        sut.cornerStyle = .large
        
        // When
        configure(card: sut, withPrimarySubview: primaryInnerView, secondarySubview: secondaryInnerView)
        let snapshotView = embed(card: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testDividedSnapshotWithoutPaddedVertical() {
        // Given
        let sut = BPKDividedCard(padded: false)
        sut.orientation = .vertical
        
        // When
        configure(card: sut, withPrimarySubview: primaryInnerView, secondarySubview: secondaryInnerView)
        let snapshotView = embed(card: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testDividedSnapshotVerticalSolidLine() {
        // Given
        let sut = BPKDividedCard(padded: true)
        sut.orientation = .vertical
        sut.lineStyle = .solid
        
        // When
        configure(card: sut, withPrimarySubview: primaryInnerView, secondarySubview: secondaryInnerView)
        let snapshotView = embed(card: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testDividedSnapshotVerticalSolidLineWithoutPadding() {
        // Given
        let sut = BPKDividedCard(padded: false)
        sut.orientation = .vertical
        sut.lineStyle = .solid
        
        // When
        configure(card: sut, withPrimarySubview: primaryInnerView, secondarySubview: secondaryInnerView)
        let snapshotView = embed(card: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    // MARK: Helpers
    private func configure(card: BPKDividedCard, withPrimarySubview primarySubview: UIView, secondarySubview: UIView) {
        [primarySubview, secondarySubview, card].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        card.setSubviews(primarySubview: primarySubview, secondarySubview: secondarySubview)
                
        NSLayoutConstraint.activate([
            primarySubview.widthAnchor.constraint(equalToConstant: 90),
            primarySubview.heightAnchor.constraint(equalToConstant: 80),
            
            secondarySubview.widthAnchor.constraint(equalToConstant: 30),
            secondarySubview.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func embed(card: UIView) -> UIView {
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
        
        parentView.layoutIfNeeded()
        
        return parentView
    }
}
