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

/// `BPKTextView` is a subclass of `UITextView` which uses the Skyscanner style.
@available(*, deprecated, message: "BPKTextView is deprecated. Use the SwiftUI BPKTextArea instead.")
@objcMembers
@IBDesignable
public final class BPKTextView: UITextView {

    /// The font style used for the TextView.
    ///
    /// See `BPKFontStyle` for the integer values to use when setting from Interface Builder.
    public var fontStyle: BPKFontStyle = .textBodyDefault {
        didSet {
            guard fontStyle != oldValue else { return }
            applyStyle()
        }
    }

    // MARK: - Initializers

    /// Create a `BPKTextView` with a specific BPKFont style.
    ///
    /// - Parameter fontStyle: Font style to be used by the TextView.
    public init(fontStyle: BPKFontStyle) {
        super.init(frame: .zero, textContainer: nil)
        commonInit(fontStyle: fontStyle)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(fontStyle: .textBodyDefault)
    }

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit(fontStyle: .textBodyDefault)
    }

    // MARK: - Overrides

    public override var text: String! {
        didSet {
            applyStyle()
        }
    }

    public override var textColor: UIColor? {
        didSet {
            guard textColor != oldValue else { return }
            applyStyle()
        }
    }

    // MARK: - Private

    private func commonInit(fontStyle: BPKFontStyle) {
        self.fontStyle = fontStyle
        super.textColor = BPKColor.textPrimaryColor
        applyStyle()
    }

    private func applyStyle() {
        let colorAttributes: [NSAttributedString.Key: Any] = textColor.map {
            [.foregroundColor: $0]
        } ?? [:]

        typingAttributes = BPKFont.makeAttributes(
            fontStyle: fontStyle,
            customAttributes: colorAttributes
        )

        guard let currentText = super.text, !currentText.isEmpty else { return }
        guard let color = textColor else { return }

        super.attributedText = BPKFont.makeAttributedString(
            fontStyle: fontStyle,
            content: currentText,
            textColor: color
        )
    }
}
