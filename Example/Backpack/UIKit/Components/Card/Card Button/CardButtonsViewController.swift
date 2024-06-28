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

final class CardButtonsViewController: UIViewController {

    private let sampleButtons: [Row] = [
        Row.shareButtonRow(size: .default),
        Row.shareButtonRow(size: .large),
        Row.saveButtonRow(size: .default, checked: false),
        Row.saveButtonRow(size: .large, checked: false),
        Row.saveButtonRow(size: .default, checked: true),
        Row.saveButtonRow(size: .large, checked: true)
    ]

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.spacing = BPKSpacingSm
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()

    private let titlesView: UIView = {
        let titleStack = UIStackView()
        titleStack.spacing = BPKSpacingBase
        titleStack.distribution = .equalCentering
        ["default", "contained", "onDark"].forEach { text in
            let styleLabelDefault = BPKLabel()
            styleLabelDefault.text = text
            titleStack.addArrangedSubview(styleLabelDefault)
        }
        return titleStack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.canvasColor
        title = "Card Button"

        setupView()
    }

    private func setupView() {
        stack.addArrangedSubview(titlesView)

        sampleButtons.forEach { row in
            let label = BPKLabel()
            label.numberOfLines = 0
            label.text = row.title
            stack.addArrangedSubview(label)

            let horizontalStack = UIStackView()
            horizontalStack.distribution = .equalCentering
            row.cardButtons.forEach {
                let cardButton = makeCardButtonWithContainer($0)
                horizontalStack.addArrangedSubview(cardButton)
            }
            stack.addArrangedSubview(horizontalStack)
        }

        view.addSubview(scrollView)
        scrollView.addSubview(stack)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            stack.widthAnchor.constraint(equalTo: view.widthAnchor),
            stack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    private func makeCardButton(_ cardButtonParams: ButtonData) -> UIView {
        let cardButton: UIView
        switch cardButtonParams.icon {
        case .share:
            cardButton = BPKShareCardButton(
                accessibilityLabel: NSLocalizedString("Share", comment: ""),
                style: cardButtonParams.style,
                size: cardButtonParams.size
            )
        case .unsaved:
            let saveButton = BPKSaveCardButton(
                checked: false,
                accessibilityLabel: NSLocalizedString("Save", comment: ""),
                style: cardButtonParams.style,
                size: cardButtonParams.size
            )
            saveButton.addAction(UIAction(title: "tapped", handler: { _ in
                saveButton.setChecked(!saveButton.checked, animated: true)
            }), for: .primaryActionTriggered)
            cardButton = saveButton
        case .saved:
            let saveButton = BPKSaveCardButton(
                checked: true,
                accessibilityLabel: NSLocalizedString("Save", comment: ""),
                style: cardButtonParams.style,
                size: cardButtonParams.size
            )
            saveButton.addAction(UIAction(title: "tapped", handler: { _ in
                saveButton.setChecked(!saveButton.checked, animated: true)
            }), for: .primaryActionTriggered)
            cardButton = saveButton
        }
        cardButton.translatesAutoresizingMaskIntoConstraints = false
        return cardButton
    }

    private func makeCardButtonWithContainer(_ cardButtonParams: ButtonData) -> UIView {
        let cardButton = makeCardButton(cardButtonParams)
        let container = makeContainer(subview: cardButton)
        container.backgroundColor = cardButtonParams.backgroundColor

        return container
    }

    private func makeContainer(subview: UIView) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(subview)
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            container.widthAnchor.constraint(equalToConstant: BPKSpacingLg * 2),
            container.heightAnchor.constraint(equalToConstant: BPKSpacingLg * 2)
        ])
        return container
    }
}

extension CardButtonsViewController {
    private struct Row {
        let title: String
        let cardButtons: [ButtonData]

        static let stylesAndBackgroundsPerRow: [(BPKCardButtonStyle, UIColor)] = [
            (style: .default, backgroundColor: BPKColor.surfaceDefaultColor),
            (style: .contained, backgroundColor: BPKColor.surfaceHighlightColor),
            (style: .onDark, backgroundColor: BPKColor.black)
        ]

        static func shareButtonRow(size: BPKCardButtonSize) -> Row {
            Row(
                title: "Size: \(size)",
                cardButtons: stylesAndBackgroundsPerRow.map { (style, backgroundColor) in
                    ButtonData(
                        icon: .share,
                        backgroundColor: backgroundColor,
                        size: size,
                        style: style
                    )
                }
            )
        }
        static func saveButtonRow(size: BPKCardButtonSize, checked: Bool) -> Row {
            Row(
                title: "Size: \(size). Checked: \(checked)",
                cardButtons: stylesAndBackgroundsPerRow.map { (style, backgroundColor) in
                    ButtonData(
                        icon: checked ? .saved : .unsaved,
                        backgroundColor: backgroundColor,
                        size: size,
                        style: style
                    )
                }
            )
        }
    }

    private enum ButtonIcon {
        case share
        case unsaved
        case saved
    }

    private struct ButtonData {
        let icon: ButtonIcon
        let backgroundColor: UIColor
        let size: BPKCardButtonSize
        let style: BPKCardButtonStyle
    }
}
