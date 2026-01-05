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

    private let backgroundCircle = CardButtonBackgroundView()

    public init(
        accessibilityLabel: String,
        style: BPKCardButtonStyle = .default,
        size: BPKCardButtonSize = .default
    ) {
        self.style = style
        self.size = size

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
            widthAnchor.constraint(equalToConstant: size.buttonWidthHeight),
            heightAnchor.constraint(equalToConstant: size.buttonWidthHeight)
        ])
    }

    private func updateLookAndFeel() {
        updateButtonImages()
        backgroundCircle.updateLookAndFeel(size: size, style: style, parentButton: self)
    }

    private func updateButtonImages() {
        setImage(size.normalIcon(style.normalIconColor), for: .normal)
        setImage(size.highlightedIcon(style.highlightedIconColor), for: .highlighted)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
        updateLookAndFeel()
    }
}

fileprivate extension BPKCardButtonStyle {
    var normalIconColor: UIColor {
        switch self {
        case .onDark:
            return BPKColor.textOnDarkColor
        case .contained:
            return BPKColor.textPrimaryColor
        case .default:
            return BPKColor.textPrimaryColor
        }
    }

    var highlightedIconColor: UIColor {
        switch self {
        case .onDark:
            return BPKColor.textDisabledOnDarkColor
        case .contained:
            return BPKColor.textLinkColor
        case .default:
            return BPKColor.textLinkColor
        }
    }
}

fileprivate extension BPKCardButtonSize {
    func normalIcon(_ color: UIColor) -> UIImage {
        switch self {
        case .large:
            return BPKObjcUIKitIcon.makeLargeIcon(
                name: .shareiOS,
                color: color
            )
        case .default:
            return BPKObjcUIKitIcon.makeSmallIcon(
                name: .shareiOS,
                color: color
            )
        }
    }

    func highlightedIcon(_ color: UIColor) -> UIImage {
        switch self {
        case .large:
            return BPKObjcUIKitIcon.makeLargeIcon(
                name: .shareiOS,
                color: color
            )
        case .default:
            return BPKObjcUIKitIcon.makeSmallIcon(
                name: .shareiOS,
                color: color
            )
        }
    }
}
