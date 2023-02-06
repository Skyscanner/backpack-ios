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

// Hold shared logic between BPKSaveCardButton & BPKShareCardButton
class CardButtonViewConfigurator {
    struct CardButtonIcons {
        let smallIcon: BPKSmallIconName
        let smallIconHighlighted: BPKSmallIconName
        let defaultIcon: BPKLargeIconName
        let defaultIconHighlighted: BPKLargeIconName
    }

    struct CardButtonColor {
        let iconColorOnDark: UIColor
        let iconColorContained: UIColor
        let iconColorDefault: UIColor
        let highlightedIconColorOnDark: UIColor
        let highlightedIconColorContained: UIColor
        let highlightedIconColorDefault: UIColor
    }

    var icons: CardButtonIcons
    var colors: CardButtonColor
    // CardButton Required a larger hit area of at least 48px
    private let widthHeight = BPKSpacingLg * 2

    init(icons: CardButtonIcons, colors: CardButtonColor) {
        self.icons = icons
        self.colors = colors
    }

    func configureSizeConstraints(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: widthHeight),
            button.heightAnchor.constraint(equalToConstant: widthHeight)
        ])
    }

    func createContainedBackgroundCircle() -> UIView {
        let circle = UIView()
        circle.backgroundColor = BPKColor.textDisabledOnDarkColor.withAlphaComponent(0.5)
        circle.isUserInteractionEnabled = false
        return circle
    }

    func setupButtonBackground(
        _ button: UIButton,
        containedBackgroundCircle: UIView,
        style: BPKCardButtonStyle,
        size: BPKCardButtonSize
    ) {
        switch style {
        case .contained:
            if containedBackgroundCircle.superview == nil {
                add(containedBackgroundCircle: containedBackgroundCircle,
                    to: button,
                    buttonSize: size)
            }
        case .default, .onDark:
            if containedBackgroundCircle.superview != nil {
                containedBackgroundCircle.removeFromSuperview()
            }
        }
    }

    private func add(
        containedBackgroundCircle: UIView,
        to button: UIButton,
        buttonSize: BPKCardButtonSize
    ) {
        button.addSubview(containedBackgroundCircle)
        containedBackgroundCircle.translatesAutoresizingMaskIntoConstraints = false
        button.imageView.map { button.bringSubviewToFront($0) }

        let circleSize: CGFloat
        switch buttonSize {
        case .default:
            circleSize = BPKIcon.concreteSizeForLargeIcon.width + BPKSpacingBase
        case .small:
            circleSize = BPKIcon.concreteSizeForSmallIcon.width + BPKSpacingBase
        }

        NSLayoutConstraint.activate([
            containedBackgroundCircle.widthAnchor.constraint(equalToConstant: circleSize),
            containedBackgroundCircle.heightAnchor.constraint(equalToConstant: circleSize),
            containedBackgroundCircle.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            containedBackgroundCircle.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        containedBackgroundCircle.layer.cornerRadius = circleSize / 2
    }

    func configureButtonImages(
        _ button: UIButton,
        style: BPKCardButtonStyle,
        size: BPKCardButtonSize
    ) {
        switch size {
        case .default:
            let largeIconNormal = BPKIcon.makeLargeIcon(
                name: icons.defaultIcon,
                color: normalIconColor(style: style)
            )
            button.setImage(largeIconNormal, for: .normal)

            let largeIconHighlighted = BPKIcon.makeLargeIcon(
                name: icons.defaultIconHighlighted,
                color: highlightedIconColor(style: style)
            )
            button.setImage(largeIconHighlighted, for: .highlighted)
        case .small:
            let smallIconNormal = BPKIcon.makeSmallIcon(
                name: icons.smallIcon,
                color: normalIconColor(style: style)
            )
            button.setImage(smallIconNormal, for: .normal)

            let smallIconHighlighted = BPKIcon.makeSmallIcon(
                name: icons.smallIconHighlighted,
                color: highlightedIconColor(style: style)
            )
            button.setImage(smallIconHighlighted, for: .highlighted)
        }
    }

    private func normalIconColor(style: BPKCardButtonStyle) -> UIColor {
        switch style {
        case .onDark:
            return colors.iconColorOnDark
        case .contained:
            return colors.iconColorContained
        case .default:
            return colors.iconColorDefault
        }
    }

    private func highlightedIconColor(style: BPKCardButtonStyle) -> UIColor {
        switch style {
        case .onDark:
            return colors.highlightedIconColorOnDark
        case .contained:
            return colors.highlightedIconColorContained
        case .default:
            return colors.highlightedIconColorDefault
        }
    }
}
