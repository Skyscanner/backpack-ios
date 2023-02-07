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

class BPKShareCardButtonSnapshotTest: XCTestCase {
    
    let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)
    
    override func setUp() {
        super.setUp()
        isRecording = false
    }

    private let buttonStylesAndSizes: [(BPKCardButtonStyle, BPKCardButtonSize)] = [
        (.default, .default),
        (.default, .small),
        (.contained, .default),
        (.contained, .small),
        (.onDark, .default),
        (.onDark, .small)
    ]

    private func buttonBackgroundColor(for style: BPKCardButtonStyle) -> UIColor {
        switch style {
        case .default:
            return BPKColor.surfaceDefaultColor
        case .contained:
            return BPKColor.surfaceHighlightColor
        case .onDark:
            return BPKColor.black
        }
    }

    private func createCardButtons() -> UIView {
        let stackView = createStackView()
        let parentView = UIView(frame: .zero)
        
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(stackView)

        buttonStylesAndSizes.map { (style, size) in
            let cardButton = BPKShareCardButton(
                accessibilityLabel: "",
                style: style,
                size: size,
                onClick: {}
            )
            cardButton.backgroundColor = buttonBackgroundColor(for: style)
            return cardButton
        }.forEach(stackView.addArrangedSubview(_:))

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: parentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            parentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            parentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        return parentView
    }

    private func createStackView() -> UIStackView {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
        stackView.spacing = BPKSpacingMd
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    func testShareCardButtonSnapshot() {
        let shareButtons = createCardButtons()
        assertSnapshot(shareButtons)
    }
}
