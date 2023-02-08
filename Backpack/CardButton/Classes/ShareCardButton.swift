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
        viewConfigurator.configureSizeConstraints(self)
    }

    private func updateLookAndFeel() {
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

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateLookAndFeel()
    }
}
