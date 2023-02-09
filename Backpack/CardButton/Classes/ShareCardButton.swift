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

public class BPKShareCardButton: UIButton {

    public var style: BPKCardButtonStyle {
        didSet { updateLookAndFeel() }
    }

    public var size: BPKCardButtonSize {
        didSet { updateLookAndFeel() }
    }

    private let viewConfigurator = CardButtonViewConfigurator()
    private let containedBackgroundCircle: UIView

    public init(
        accessibilityLabel: String,
        style: BPKCardButtonStyle = .default,
        size: BPKCardButtonSize = .default
    ) {
        self.style = style
        self.size = size
        self.containedBackgroundCircle = viewConfigurator.createContainedBackgroundCircle()

        super.init(frame: .zero)
        self.accessibilityLabel = accessibilityLabel

        setup()
        updateLookAndFeel()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: viewConfigurator.widthHeight),
            heightAnchor.constraint(equalToConstant: viewConfigurator.widthHeight)
        ])
    }

    private func updateLookAndFeel() {
        updateButtonImages()
        updateBackgroundCircleView()
    }

    private func updateButtonImages() {
        switch size {
        case .default:
            let largeIconNormal = BPKIcon.makeLargeIcon(
                name: .shareiOS,
                color: normalIconColor(style: style)
            )
            setImage(largeIconNormal, for: .normal)

            let largeIconHighlighted = BPKIcon.makeLargeIcon(
                name: .shareiOS,
                color: highlightedIconColor(style: style)
            )
            setImage(largeIconHighlighted, for: .highlighted)
        case .small:
            let smallIconNormal = BPKIcon.makeSmallIcon(
                name: .shareiOS,
                color: normalIconColor(style: style)
            )
            setImage(smallIconNormal, for: .normal)

            let smallIconHighlighted = BPKIcon.makeSmallIcon(
                name: .shareiOS,
                color: highlightedIconColor(style: style)
            )
            setImage(smallIconHighlighted, for: .highlighted)
        }
    }

    private func normalIconColor(style: BPKCardButtonStyle) -> UIColor {
        switch style {
        case .onDark:
            return BPKColor.textOnDarkColor
        case .contained:
            return BPKColor.textPrimaryColor
        case .default:
            return BPKColor.textPrimaryColor
        }
    }

    private func highlightedIconColor(style: BPKCardButtonStyle) -> UIColor {
        switch style {
        case .onDark:
            return BPKColor.textDisabledOnDarkColor
        case .contained:
            return BPKColor.textLinkColor
        case .default:
            return BPKColor.textLinkColor
        }
    }

    private func updateBackgroundCircleView() {
        if viewConfigurator.shouldAddButtonBackground(style: style) {
            if containedBackgroundCircle.superview == nil {
                addSubview(containedBackgroundCircle)
                let circleSize = viewConfigurator.buttonBackgroundSize(size: size)
                containedBackgroundCircle.layer.cornerRadius = circleSize / 2

                NSLayoutConstraint.activate([
                    containedBackgroundCircle.widthAnchor.constraint(equalToConstant: circleSize),
                    containedBackgroundCircle.heightAnchor.constraint(equalToConstant: circleSize),
                    containedBackgroundCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
                    containedBackgroundCircle.centerYAnchor.constraint(equalTo: centerYAnchor)
                ])
                imageView.map { bringSubviewToFront($0) }
            }
        } else {
            if containedBackgroundCircle.superview != nil {
                containedBackgroundCircle.removeFromSuperview()
            }
        }
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
        updateLookAndFeel()
    }
}
