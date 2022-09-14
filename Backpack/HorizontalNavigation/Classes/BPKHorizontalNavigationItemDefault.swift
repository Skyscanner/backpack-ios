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

import Foundation

class BPKHorizontalNavigationItemDefault<
    Size: BPKHorizontalNavigationSize
>: UIButton, BPKHorizontalNavigationItem, BPKHorizontalNavigationItemObjc {
    struct IconDefinition {
        let image: UIImage
        let size: CGSize
    }

    override var isSelected: Bool {
        didSet {
            updateStyle()
        }
    }

    var selectedColor: UIColor? {
        didSet {
            updateStyle()
        }
    }

    var appearance: BPKHorizontalNavigationAppearance = .normal {
        didSet {
            updateStyle()
        }
    }

    var icon: IconDefinition?

    var hasIcon: Bool { icon != nil }
    let name: String

    private var contentColor: UIColor {
        if isSelected {
            return selectedColor ?? .bpk_coreAccent
        }
        
        switch appearance {
        case .normal: return .bpk_textPrimary
        case .alternate: return .bpk_skyGrayTint07
        }
    }

    init(name: String) {
        self.name = name

        super.init(frame: .zero)

        setUp()
    }

    init(name: String, iconDefinition: IconDefinition) {
        self.name = name
        self.icon = iconDefinition

        super.init(frame: .zero)

        setUp()
    }

    override var intrinsicContentSize: CGSize {
        let buttonIntrinsicContentSize = super.intrinsicContentSize

        if let icon = icon {
            let iconHeight = icon.size.height
            let width = buttonIntrinsicContentSize.width + 3 * Size.horizontalSpacing
            let height = iconHeight + Size.verticalSpacing / 2.0

            return CGSize(width: width, height: height)
        } else {
            let width = buttonIntrinsicContentSize.width + 2 * Size.horizontalSpacing
            let height = buttonIntrinsicContentSize.height

            return CGSize(width: width, height: height)
        }
    }

    private func setUp() {
        self.titleLabel?.lineBreakMode = .byTruncatingTail

        if let icon = icon {
            setImage(icon.image, for: .normal)
            adjustsImageWhenHighlighted = false
            imageView?.tintColor = contentColor
        }

        updateStyle()
    }

    private func updateStyle() {
        let titleString = BPKFont.makeAttributedString(
            fontStyle: Size.fontStyle, content: name, textColor: contentColor
        )

        setAttributedTitle(titleString, for: .normal)

        updateInsets()
        updateIconStyle()
    }

    private func updateInsets() {
        if !hasIcon {
            titleEdgeInsets = UIEdgeInsets(
                top: Size.verticalSpacing, left: Size.horizontalSpacing,
                bottom: Size.verticalSpacing, right: Size.horizontalSpacing
            )
            return
        }

        let horizontalInset = Size.horizontalSpacing / 2.0

        if BPKRTLSupport.viewIsRTL(self) {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: horizontalInset)
        } else {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: horizontalInset)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: 0)
        }
    }

    private func updateIconStyle() {
        imageView?.tintColor = contentColor
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
