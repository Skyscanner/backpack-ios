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

@objcMembers
@objc
public class BPKShareCardButton: UIButton {

    public var style: BPKCardButtonStyle = .default {
        didSet { render() }
    }

    public var size: BPKCardButtonSize = .default {
        didSet { render() }
    }

    public var onClick: () -> Void = {}

    // CardButton Required a larger hit area of 48px
    private let widthHeight = BPKSpacingLg * 2

    private lazy var containedBackgroundCircle: UIView = {
        let circle = UIView()
        circle.backgroundColor = BPKColor.textDisabledOnDarkColor.withAlphaComponent(0.5)
        circle.isUserInteractionEnabled = false
        return circle
    }()

    public convenience init(
        accessibilityLabel: String,
        style: BPKCardButtonStyle = .default,
        size: BPKCardButtonSize = .default,
        onClick: @escaping () -> Void
    ) {
        self.init(frame: .zero)
        self.accessibilityLabel = accessibilityLabel
        self.style = style
        self.size = size
        self.onClick = onClick
        render()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        addTarget(
            self,
            action: #selector(primaryActionTriggered),
            for: .primaryActionTriggered
        )

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(greaterThanOrEqualToConstant: widthHeight),
            heightAnchor.constraint(greaterThanOrEqualToConstant: widthHeight)
        ])
    }

    private func render() {
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
        setupBackground()
    }

    private func setupBackground() {
        switch style {
        case .contained:
            if containedBackgroundCircle.superview == nil {
                addBackgroundCircle()
            }
        case .default, .onDark:
            if containedBackgroundCircle.superview != nil {
                containedBackgroundCircle.removeFromSuperview()
            }
        }
    }

    private func addBackgroundCircle() {
        addSubview(containedBackgroundCircle)
        containedBackgroundCircle.translatesAutoresizingMaskIntoConstraints = false
        imageView.map { bringSubviewToFront($0) }

        let circleSize: CGFloat
        switch size {
        case .default:
            circleSize = BPKIcon.concreteSizeForLargeIcon.width + BPKSpacingBase
        case .small:
            circleSize = BPKIcon.concreteSizeForSmallIcon.width + BPKSpacingBase
        }

        NSLayoutConstraint.activate([
            containedBackgroundCircle.widthAnchor.constraint(equalToConstant: circleSize),
            containedBackgroundCircle.heightAnchor.constraint(equalToConstant: circleSize),
            containedBackgroundCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            containedBackgroundCircle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        containedBackgroundCircle.layer.cornerRadius = circleSize / 2
    }

    private func normalIconColor(style: BPKCardButtonStyle) -> UIColor {
        switch style {
        case .onDark:
            return BPKColor.textOnDarkColor
        case .contained, .default:
            return BPKColor.textPrimaryColor
        }
    }

    private func highlightedIconColor(style: BPKCardButtonStyle) -> UIColor {
        switch style {
        case .onDark:
            return BPKColor.textDisabledOnDarkColor
        case .contained, .default:
            return BPKColor.textLinkColor
        }
    }

    @objc
    private func primaryActionTriggered() {
        onClick()
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        render()
    }
}
