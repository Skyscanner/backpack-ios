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

    private let viewConfigurator = CardButtonViewConfigurator(
        icons: CardButtonViewConfigurator.CardButtonIcons(
            smallIcon: .shareiOS,
            smallIconHighlighted: .shareiOS,
            defaultIcon: .shareiOS,
            defaultIconHighlighted: .shareiOS
        ),
        colors: CardButtonViewConfigurator.CardButtonColor(
            iconColorOnDark: BPKColor.textOnDarkColor,
            iconColorContained: BPKColor.textPrimaryColor,
            iconColorDefault: BPKColor.textPrimaryColor,
            highlightedIconColorOnDark: BPKColor.textDisabledOnDarkColor,
            highlightedIconColorContained: BPKColor.textLinkColor,
            highlightedIconColorDefault: BPKColor.textLinkColor
        )
    )

    private lazy var containedBackgroundCircle: UIView = {
        viewConfigurator.createContainedBackgroundCircle()
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

        viewConfigurator.configureSizeConstraints(self)
    }

    private func render() {
        viewConfigurator.configureButtonImages(
            self,
            style: style,
            size: size
        )

        viewConfigurator.setupButtonBackground(
            self,
            containedBackgroundCircle: containedBackgroundCircle,
            style: style,
            size: size
        )
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
