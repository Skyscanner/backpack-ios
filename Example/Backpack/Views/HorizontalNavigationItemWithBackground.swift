/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2020 Skyscanner Ltd. All rights reserved.
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
import Backpack

@objc(BPKHorizontalNavigationItemWithBackground)
public class HorizontalNavigationItemWithBackground: UIButton, BPKHorizontalNavigationItem {
    // MARK: - BPKHorizontalNavigationItem

    public var size: BPKHorizontalNavigationSize = .default {
        didSet {
            updateTitle()
        }
    }

    public var selectedColor: UIColor? = BPKColor.primaryColor

    public var appearance: BPKHorizontalNavigationAppearance = .normal

    // MARK: Implementaiton

    let title: String

    @objc
    public init(title: String) {
        self.title = title

        super.init(frame: .zero)

        setUp()
    }

    func setUp() {
        titleEdgeInsets = UIEdgeInsets(top: 0, left: BPKSpacingBase, bottom: 0, right: BPKSpacingBase)
        updateStyle()
    }

    func updateTitle() {
        let fontStyle: BPKFontStyle = size == .default ? .textBaseEmphasized : .textSmEmphasized
        var textColor = BPKColor.textPrimaryColor

        if isSelected || isHighlighted {
            textColor = .white
        }

        let attributedString = BPKFont.makeAttributedString(
            fontStyle: fontStyle, content: title, textColor: textColor
        )

        setAttributedTitle(attributedString, for: .normal)
    }

    func updateBackground() {
        if isSelected {
            self.backgroundColor = selectedColor
        } else if isHighlighted {
            self.backgroundColor = selectedColor?.withAlphaComponent(0.6)
        } else {
            self.backgroundColor = .clear
        }
    }

    func updateStyle() {
        updateTitle()
        updateBackground()
    }

    // MARK: - Overrides

    override public var isSelected: Bool {
        didSet {
            updateStyle()
        }
    }

    override public var isHighlighted: Bool {
        didSet {
            updateStyle()
        }
    }

    override public var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 2 * BPKSpacingBase, height: size.height)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
                updateStyle()
            }
        }
    }

    // MARK: - Coder

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
