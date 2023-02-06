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

import UIKit
import Backpack

private struct CardButtonSampleRow {
    let title: String
    let cardButtons: [CardButtonSample]
}

private struct CardButtonSample {
    let backgroundColor: UIColor
    let size: BPKCardButtonSize
    let style: BPKCardButtonStyle
}

final class CardButtonsViewController: UIViewController {
    private let sampleButtons: [CardButtonSampleRow] = [
        CardButtonSampleRow(
            title: "Size: default.\tStyle:[default, contained, onDark]",
            cardButtons: [
                CardButtonSample(
                    backgroundColor: BPKColor.surfaceDefaultColor,
                    size: .default,
                    style: .default),
                CardButtonSample(
                    backgroundColor: BPKColor.surfaceHighlightColor,
                    size: .default,
                    style: .contained),
                CardButtonSample(
                    backgroundColor: BPKColor.black,
                    size: .default,
                    style: .onDark)
            ]
        ),
        CardButtonSampleRow(
            title: "Size: small.\tStyle:[default, contained, onDark]",
            cardButtons: [
                CardButtonSample(
                    backgroundColor: BPKColor.surfaceDefaultColor,
                    size: .small,
                    style: .default),
                CardButtonSample(
                    backgroundColor: BPKColor.surfaceHighlightColor,
                    size: .small,
                    style: .contained),
                CardButtonSample(
                    backgroundColor: BPKColor.black,
                    size: .small,
                    style: .onDark)
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.canvasColor
        title = "Card Button"

        setupView()
    }

    private func setupView() {
        let stack = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.spacing = BPKSpacingMd
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        sampleButtons.forEach { row in
            let label = BPKLabel()
            label.numberOfLines = 0
            label.text = row.title
            stack.addArrangedSubview(label)

            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            row.cardButtons.forEach {
                let cardButton = makeCardButton($0)
                horizontalStack.addArrangedSubview(cardButton)
            }
            stack.addArrangedSubview(horizontalStack)
        }
        
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            stack.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            stack.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            stack.bottomAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
    
    private func makeCardButton(_ cardButtonParams: CardButtonSample) -> UIView {
        let cardButton = BPKShareCardButton(
            accessibilityLabel: "",
            style: cardButtonParams.style,
            size: cardButtonParams.size,
            onClick: {}
        )
        cardButton.translatesAutoresizingMaskIntoConstraints = false

        let container = UIView()
        container.backgroundColor = cardButtonParams.backgroundColor
        container.addSubview(cardButton)

        NSLayoutConstraint.activate([
            cardButton.topAnchor.constraint(
                equalTo: container.topAnchor,
                constant: BPKSpacingBase
            ),
            cardButton.bottomAnchor.constraint(
                equalTo: container.bottomAnchor,
                constant: -BPKSpacingBase
            ),
            cardButton.leadingAnchor.constraint(
                equalTo: container.leadingAnchor,
                constant: BPKSpacingXl
            ),
            cardButton.trailingAnchor.constraint(
                equalTo: container.trailingAnchor,
                constant: -BPKSpacingXl
            )
        ])

        return container
    }
}
