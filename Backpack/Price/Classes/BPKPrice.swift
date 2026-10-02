/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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
import UIKit

public final class BPKPrice: UIView {
    public enum Size {
        case large, small, extraSmall
    }
    
    public enum Alignment {
        case leading, trailing
    }
    
    public var price: String? {
        didSet {
            priceLabel.text = price
            updateViews()
        }
    }
    
    public var leadingText: String? {
        didSet {
            leadingTextLabel.text = leadingText
            updateViews()
        }
    }

    public var leadingTextAccessibilityLabel: String? {
        didSet { updateLeadingTextRow() }
    }

    public var leadingIcon: BPKIconName? {
        didSet { updateLeadingTextRow() }
    }

    public var trailingIcon: BPKIconName? {
        didSet { updateLeadingTextRow() }
    }

    public var onLeadingTextClicked: (() -> Void)? {
        didSet { updateLeadingTextRow() }
    }

    public var previousPrice: String? {
        didSet {
            previousPriceLabel.text = previousPrice
            updateViews()
        }
    }
    
    public var trailingText: String? {
        didSet {
            trailingTextLabel.text = trailingText
            updateViews()
        }
    }
    
    public var alignment: Alignment {
        didSet { updateAlignmentPositioning() }
    }
    
    public var size: Size {
        didSet { stylePriceLabel() }
    }
    
    private let priceLabel = BPKLabel()
    private let trailingTextLabel = BPKLabel()
    private let previousPriceLabel = BPKLabel()
    private let separatorLabel = BPKLabel()
    private let leadingTextLabel = BPKLabel()

    private let leadingIconView: BPKObjcUIKitIconView = {
        let iconView = BPKObjcUIKitIconView(iconName: .none, size: .small)
        iconView.isAccessibilityElement = false
        return iconView
    }()

    private let trailingIconView: BPKObjcUIKitIconView = {
        let iconView = BPKObjcUIKitIconView(iconName: .none, size: .small)
        iconView.isAccessibilityElement = false
        return iconView
    }()

    private let leadingTextRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = BPKSpacingSm
        stackView.alignment = .center
        return stackView
    }()

    private let topTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = BPKSpacingSm
        return stackView
    }()
    
    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = BPKSpacingSm
        stackView.alignment = .firstBaseline
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public init(alignment: Alignment = .leading, size: Size = .large) {
        self.alignment = alignment
        self.size = size
        
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var expandedLeadingTextFrame: CGRect? {
        guard onLeadingTextClicked != nil, !leadingTextRowStackView.isHidden else { return nil }
        return leadingTextRowStackView
            .convert(leadingTextRowStackView.bounds, to: self)
            .insetBy(dx: -BPKSpacingMd, dy: -BPKSpacingSm)
    }

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event) || expandedLeadingTextFrame?.contains(point) == true
    }

    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        guard hitView != nil, expandedLeadingTextFrame?.contains(point) == true else { return hitView }
        return leadingTextRowStackView
    }

    private func setupView() {
        [priceLabel, trailingTextLabel].forEach {
            priceStackView.addArrangedSubview($0)
        }

        [topTextStackView, priceStackView].forEach {
            containerStackView.addArrangedSubview($0)
        }

        updateViews()
        containerStackView.addSubview(priceStackView)
        addSubview(containerStackView)
    }

    private func updateViews() {
        stylePriceLabel()
        styleAccessoryLabels()

        leadingTextLabel.text = leadingText
        separatorLabel.text = "•"
        priceLabel.text = price
        trailingTextLabel.text = trailingText

        previousPriceLabel.text = previousPrice
        applyLineThroughStyling()

        previousPriceLabel.isHidden = previousPrice == nil
        leadingTextLabel.isHidden = leadingText == nil

        if trailingText == nil {
            priceStackView.removeArrangedSubview(trailingTextLabel)
            trailingTextLabel.removeFromSuperview()
        } else {
            priceStackView.addArrangedSubview(trailingTextLabel)
        }

        separatorLabel.isHidden = previousPriceLabel.isHidden || leadingTextLabel.isHidden

        updateLeadingTextRow()
        updateAlignmentPositioning()
    }

    private func updateLeadingTextRow() {
        leadingTextRowStackView.isHidden = leadingText == nil

        leadingIconView.iconName = leadingIcon
        leadingIconView.tintColor = BPKColor.textSecondaryColor
        leadingIconView.isHidden = leadingIcon == nil

        trailingIconView.iconName = trailingIcon
        trailingIconView.tintColor = BPKColor.textSecondaryColor
        trailingIconView.isHidden = trailingIcon == nil

        leadingTextRowStackView.gestureRecognizers?.forEach {
            leadingTextRowStackView.removeGestureRecognizer($0)
        }

        if onLeadingTextClicked != nil {
            let tap = UITapGestureRecognizer(target: self, action: #selector(leadingTextRowTapped))
            leadingTextRowStackView.addGestureRecognizer(tap)
            leadingTextRowStackView.isUserInteractionEnabled = true
            leadingTextRowStackView.isAccessibilityElement = true
            leadingTextRowStackView.accessibilityLabel = leadingTextAccessibilityLabel ?? leadingText
            leadingTextRowStackView.accessibilityTraits = .button
        } else if let leadingTextAccessibilityLabel {
            leadingTextRowStackView.isUserInteractionEnabled = false
            leadingTextRowStackView.isAccessibilityElement = true
            leadingTextRowStackView.accessibilityLabel = leadingTextAccessibilityLabel
            leadingTextRowStackView.accessibilityTraits = []
        } else {
            leadingTextRowStackView.isUserInteractionEnabled = false
            leadingTextRowStackView.isAccessibilityElement = false
        }
    }

    @objc
    private func leadingTextRowTapped() {
        onLeadingTextClicked?()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func updateAlignmentPositioning() {
        switch alignment {
        case .leading:
            containerStackView.alignment = .leading
            priceStackView.axis = .horizontal
            priceStackView.alignment = .firstBaseline
            priceStackView.spacing = BPKSpacingSm
            [priceLabel, trailingTextLabel].forEach {
                $0.setContentCompressionResistancePriority(.required, for: .horizontal)
                $0.setContentHuggingPriority(.required, for: .horizontal)
            }
        case .trailing:
            containerStackView.alignment = .trailing
            priceStackView.axis = .vertical
            priceStackView.alignment = .trailing
            priceStackView.spacing = BPKSpacingNone
            [priceLabel, trailingTextLabel].forEach {
                $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
                $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
            }
        }
        
        // separatorLabel and previousPriceLabel must never stretch to fill extra space, so pin them to
        // required hugging - that leaves leadingTextRowStackView as the single, unambiguous flexible
        // candidate, avoiding UIStackView's text-width-disambiguation logic inflating the row.
        // It also needs required compression resistance so it isn't the one UIStackView shrinks/wraps
        // when nothing is actually short on space.
        [separatorLabel, previousPriceLabel].forEach {
            $0.setContentHuggingPriority(.required, for: .horizontal)
        }
        [leadingTextRowStackView, leadingTextLabel].forEach {
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
        var topLabels: [UIView] = [previousPriceLabel, separatorLabel, leadingTextRowStackView]

        if alignment == .trailing {
            topLabels.reverse()
        }

        topTextStackView.arrangedSubviews.forEach {
            topTextStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        topLabels.forEach {
            topTextStackView.addArrangedSubview($0)
        }

        let leadingTextRowItems: [UIView] = [leadingIconView, leadingTextLabel, trailingIconView]

        leadingTextRowStackView.arrangedSubviews.forEach {
            leadingTextRowStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        leadingTextRowItems.forEach {
            leadingTextRowStackView.addArrangedSubview($0)
        }
    }
    
}

// MARK: - Styling

private extension BPKPrice {
    func accessoryFontStyle() -> BPKFontStyle {
        switch size {
        case .large:
            return .textFootnote
        case .small, .extraSmall:
            return .textCaption
        }
    }

    func applyLineThroughStyling() {
        guard let previousPrice = previousPrice else {
            previousPriceLabel.attributedText = nil
            return
        }
        let attributedString = NSAttributedString(string: previousPrice, attributes: strikeThroughTextAttributes())
        previousPriceLabel.attributedText = attributedString
    }

    func stylePriceLabel() {
        priceLabel.textColor = BPKColor.textPrimaryColor
        priceLabel.numberOfLines = 0

        switch size {
        case .large:
            priceLabel.fontStyle = .textHeading2
        case .small:
            priceLabel.fontStyle = .textHeading4
        case .extraSmall:
            priceLabel.fontStyle = .textHeading5
        }
    }

    func styleAccessoryLabels() {
        [
            trailingTextLabel,
            previousPriceLabel,
            separatorLabel,
            leadingTextLabel
        ].forEach {
            $0.fontStyle = accessoryFontStyle()
            $0.textColor = BPKColor.textSecondaryColor
        }
        trailingTextLabel.numberOfLines = 0
        previousPriceLabel.numberOfLines = 0
        leadingTextLabel.numberOfLines = 0
    }

    func strikeThroughTextAttributes() -> [NSAttributedString.Key: Any] {
        [
            .foregroundColor: BPKColor.textSecondaryColor,
            .font: BPKFont.makeFont(fontStyle: accessoryFontStyle()),
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: BPKColor.textSecondaryColor
        ]
    }
}
