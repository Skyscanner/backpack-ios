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
public class BPKSaveCardButton: UIButton {

    public var checked: Bool = false {
        didSet {
            // SONIC-1376 add check/uncheck animation
            viewConfigurator.icons = checked ? Self.checkedIcons : Self.uncheckedIcons
            viewConfigurator.colors = checked ? Self.checkedColor : Self.uncheckedColor
            render()
            onCheckedChange(checked)
        }
    }

    public var style: BPKCardButtonStyle = .default {
        didSet { render() }
    }

    public var size: BPKCardButtonSize = .default {
        didSet { render() }
    }

    public var onCheckedChange: (Bool) -> Void = { _ in }

    private var viewConfigurator: CardButtonViewConfigurator

    private lazy var containedBackgroundCircle: UIView = {
        viewConfigurator.createContainedBackgroundCircle()
    }()

    public init(
        checked: Bool,
        accessibilityLabel: String,
        style: BPKCardButtonStyle = .default,
        size: BPKCardButtonSize = .default,
        onCheckedChange: @escaping (Bool) -> Void
    ) {
        self.viewConfigurator = CardButtonViewConfigurator(
            icons: checked ? Self.checkedIcons : Self.uncheckedIcons,
            colors: checked ? Self.checkedColor : Self.uncheckedColor
        )
        self.checked = checked
        self.style = style
        self.size = size
        self.onCheckedChange = onCheckedChange
        super.init(frame: .zero)
        self.accessibilityLabel = accessibilityLabel

        setup()
        render()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
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

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        render()
    }
}

extension BPKSaveCardButton {

    static private let uncheckedIcons = CardButtonViewConfigurator.CardButtonIcons(
        smallIcon: .heartOutline,
        smallIconHighlighted: .heart,
        defaultIcon: .heartOutline,
        defaultIconHighlighted: .heart
    )
    static private let checkedIcons = CardButtonViewConfigurator.CardButtonIcons(
        smallIcon: .heart,
        smallIconHighlighted: .heart,
        defaultIcon: .heart,
        defaultIconHighlighted: .heart
    )

    static private let uncheckedColor = CardButtonViewConfigurator.CardButtonColor(
        iconColorOnDark: BPKColor.textOnDarkColor,
        iconColorContained: BPKColor.textPrimaryColor,
        iconColorDefault: BPKColor.textPrimaryColor,
        highlightedIconColorOnDark: BPKColor.textOnDarkColor,
        highlightedIconColorContained: BPKColor.textPrimaryColor,
        highlightedIconColorDefault: BPKColor.textPrimaryColor
    )

    static private let checkedColor = CardButtonViewConfigurator.CardButtonColor(
        iconColorOnDark: BPKColor.textOnDarkColor,
        iconColorContained: BPKColor.coreAccentColor,
        iconColorDefault: BPKColor.coreAccentColor,
        highlightedIconColorOnDark: BPKColor.textOnDarkColor,
        highlightedIconColorContained: BPKColor.textPrimaryColor,
        highlightedIconColorDefault: BPKColor.textPrimaryColor
    )
}
