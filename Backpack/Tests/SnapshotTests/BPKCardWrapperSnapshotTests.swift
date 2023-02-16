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
            header: createHeader(title: "BPKCard"),
            card: createCard(isDivided: false),
            backgroundColor: BPKColor.coreAccentColor)
        
        // When
        let snapshotView = embed(wrapper: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testViewSnapshotWithPrimaryColor() {
        // Given
        let sut = BPKCardWrapper(
            header: createHeader(title: "PrimaryColor"),
            card: createCard(isDivided: false),
            backgroundColor: BPKColor.corePrimaryColor)
        
        // When
        let snapshotView = embed(wrapper: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testViewSnapshotWithDividedCard() {
        // Given
        let sut = BPKCardWrapper(
            header: createHeader(title: "BPKDividedCard"),
            card: createCard(isDivided: true),
            backgroundColor: BPKColor.coreAccentColor)
        
        // When
        let snapshotView = embed(wrapper: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
}
    
// MARK: Helpers
extension BPKCardWrapperSnapshotTests {
    private func createCard(isDivided: Bool) -> BPKCard {
        let label1 = createContectLabel(text: """
            Lorem ipsum dolor sit amet,
            consectetuer adipiscing elit.
            Aenean commodo ligula eget dolor.
        """)
        
        let label2 = createContectLabel(text: "Lorem ipsum dolor sit amet")
        
        if isDivided {
            let card = BPKDividedCard()
            card.setSubviews(primarySubview: label1, secondarySubview: label2)
            card.lineStyle = .solid
            card.orientation = .vertical
            card.isElevated = false
            card.isPadded = true
            return card
        }
        
        let card = BPKCard(padded: true)
        card.isElevated = false
        card.subview = label1
        return card
    }
    
    private func createHeader(title: String) -> UIView {
        let header = UIStackView()
        header.axis = .horizontal
        header.distribution = .fill
        header.alignment = .center
        header.spacing = BPKSpacingMd
        header.translatesAutoresizingMaskIntoConstraints = false
        header.isLayoutMarginsRelativeArrangement = true
        header.layoutMargins = UIEdgeInsets(
            top: BPKSpacingMd,
            left: BPKSpacingMd,
            bottom: BPKSpacingMd,
            right: BPKSpacingMd)
        
        let iconView = UIImageView()
        iconView.contentMode = .scaleToFill
        iconView.image =  BPKIcon.makeSmallIcon(name: .flag, color: .white)
        iconView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        header.addArrangedSubview(iconView)
        
        let label = BPKLabel(fontStyle: .textBodyDefault)
        label.text = title
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        header.addArrangedSubview(label)
        
        return header
    }
    
    private func createContectLabel(text: String) -> BPKLabel {
        let label = BPKLabel(fontStyle: .textBodyDefault)
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .natural
        
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
