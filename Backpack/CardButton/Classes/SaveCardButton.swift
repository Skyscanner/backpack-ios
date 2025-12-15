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

public class BPKSaveCardButton: UIButton {

    public private(set) var checked: Bool {
        didSet {
            updateLookAndFeel()
            onCheckedChange?(checked)
        }
    }

    public var style: BPKCardButtonStyle {
        didSet { updateLookAndFeel() }
    }

    public var size: BPKCardButtonSize {
        didSet { updateLookAndFeel() }
    }

    public var onCheckedChange: ((Bool) -> Void)?

    private let backgroundCircle = CardButtonBackgroundView()

    public init(
        checked: Bool = false,
        accessibilityLabel: String,
        style: BPKCardButtonStyle = .default,
        size: BPKCardButtonSize = .default,
        onCheckedChange: ((Bool) -> Void)? = nil
    ) {
        self.checked = checked
        self.style = style
        self.size = size
        self.onCheckedChange = onCheckedChange

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
        updateAccessibilityTraits()
    }

    private func updateButtonImages() {
        let icons = checked ? Self.checkedIcons : Self.uncheckedIcons

        switch size {
        case .large:
            let largeIconNormal = BPKObjcUIKitIcon.makeLargeIcon(
                name: icons.defaultIcon,
                color: normalIconColor(style: style, checked: checked)
            )
            setImage(largeIconNormal, for: .normal)

            let largeIconHighlighted = BPKObjcUIKitIcon.makeLargeIcon(
                name: icons.defaultIconHighlighted,
                color: highlightedIconColor(style: style, checked: checked)
            )
            setImage(largeIconHighlighted, for: .highlighted)
        case .default:
            let smallIconNormal = BPKObjcUIKitIcon.makeSmallIcon(
                name: icons.smallIcon,
                color: normalIconColor(style: style, checked: checked)
            )
            setImage(smallIconNormal, for: .normal)

            let smallIconHighlighted = BPKObjcUIKitIcon.makeSmallIcon(
                name: icons.smallIconHighlighted,
                color: highlightedIconColor(style: style, checked: checked)
            )
            setImage(smallIconHighlighted, for: .highlighted)
        }
    }

    private func normalIconColor(style: BPKCardButtonStyle, checked: Bool) -> UIColor {
        let appearanceSet = Self.appearance(from: style)
        return checked ? appearanceSet.normal.iconColorChecked : appearanceSet.normal.iconColor
    }

    private func highlightedIconColor(style: BPKCardButtonStyle, checked: Bool) -> UIColor {
        let appearanceSet = Self.appearance(from: style)
        return checked ? appearanceSet.highlighted.iconColorChecked : appearanceSet.highlighted.iconColor
    }

    private func updateAccessibilityTraits() {
        if checked {
            accessibilityTraits.insert(.selected)
        } else {
            accessibilityTraits.remove(.selected)
        }
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
        updateLookAndFeel()
    }
}

extension BPKSaveCardButton {
    public func setChecked(_ newValue: Bool, animated: Bool) {
        guard animated, let imageView = imageView else {
            checked = newValue
            return
        }
        if newValue {
            // Update icon color before animation starts
            checked = true
            // 1. resize to 30px
            // 2. wait
            // 3. resize back to 24px
            let transformBefore = imageView.transform
            UIView.animate(
                withDuration: BPKDuration.animationDurationSm,
                delay: 0,
                options: UIView.AnimationOptions([.beginFromCurrentState, .curveEaseOut])
            ) {
                imageView.transform = CGAffineTransformMakeScale(1.25, 1.25)
            }
            UIView.animate(
                withDuration: BPKDuration.animationDurationSm,
                delay: BPKDuration.animationDurationSm * 2,
                options: UIView.AnimationOptions([.beginFromCurrentState, .curveEaseIn])
            ) {
                imageView.transform = transformBefore
            }
        } else {
            // return to default state with transition
            UIView.transition(
                with: self,
                duration: BPKDuration.animationDurationSm,
                options: .transitionCrossDissolve
            ) {
                self.checked = newValue
            }
        }
    }
}
