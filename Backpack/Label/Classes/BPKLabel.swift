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

/// `BPKLabel` is a subclass of `UILabel` which uses the Skyscanner style.
@available(*, deprecated, message: "BPKLabel is deprecated. Use the SwiftUI BPKText instead.")
@objcMembers
@IBDesignable
public final class BPKLabel: UILabel {

    /// The font style used for the label.
    ///
    /// See `BPKFontStyle` for the integer values to use when setting from Interface Builder.
    public var fontStyle: BPKFontStyle = .textBodyDefault {
        didSet {
            guard fontStyle != oldValue else { return }
            text = attributedText?.string
        }
    }

    private var persistentStyleRanges: [BPKTextDefinition] = []

    // MARK: - Initializers

    /// Create a `BPKLabel` with a specific BPKFont style.
    ///
    /// - Parameter fontStyle: Font style to be used by the label.
    public init(fontStyle: BPKFontStyle) {
        super.init(frame: .zero)
        commonInit(fontStyle: fontStyle)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(fontStyle: .textBodyDefault)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(fontStyle: .textBodyDefault)
    }

    // MARK: - Public

    /// Set the font style for a given range of the label.
    ///
    /// - Parameters:
    ///   - fontStyle: The style of the text being applied.
    ///   - range: The range to apply the font style to.
    public func setFontStyle(_ fontStyle: BPKFontStyle, range: NSRange) {
        persistentStyleRanges.append(BPKTextDefinition(fontStyle: fontStyle, range: range))

        guard let currentAttributedText = attributedText else { return }
        let resultingString = NSMutableAttributedString(attributedString: currentAttributedText)
        let newAttributes = attributes(for: fontStyle)
        resultingString.setAttributes(newAttributes, range: range)
        attributedText = resultingString
    }

    // MARK: - Overrides

    public override var text: String? {
        didSet {
            persistentStyleRanges.removeAll()
            applyTextStyle()
        }
    }

    // MARK: - Private

    private func commonInit(fontStyle: BPKFontStyle) {
        self.fontStyle = fontStyle
        super.textColor = BPKColor.textPrimaryColor
        adjustsFontForContentSizeCategory = BPKFontManager.sharedInstance().dynamicTypeEnabled
        applyTextStyle()
    }

    private func applyTextStyle() {
        guard text != nil else {
            attributedText = nil
            return
        }

        guard fontStyle.rawValue > 0 else { return }

        guard let currentAttributedText = attributedText else { return }
        let newAttributedString = NSMutableAttributedString(
            attributedString: BPKFont.attributedString(
                with: fontStyle,
                andColor: textColor,
                on: currentAttributedText
            )
        )

        for styleRange in persistentStyleRanges {
            let newAttributes = attributes(for: styleRange.fontStyle)
            newAttributedString.setAttributes(newAttributes, range: styleRange.range)
        }

        super.attributedText = newAttributedString
    }

    private func attributes(for fontStyle: BPKFontStyle) -> [NSAttributedString.Key: Any] {
        if let textColor {
            let customAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: textColor]
            return BPKFont.makeAttributes(fontStyle: fontStyle, customAttributes: customAttributes)
        } else {
            return BPKFont.makeAttributes(fontStyle: fontStyle)
        }
    }
}
