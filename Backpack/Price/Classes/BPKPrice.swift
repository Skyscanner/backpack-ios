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
        case large, small
    }
    
    public enum Alignment {
        case leading, trailing
    }
    
    public var price: String?
    public var leadingText: String?
    public var previousPrice: String?
    public var trailingText: String?
    
    public var alignment: Alignment {
        didSet {
            updateAlignmentPositioning()
        }
    }
    
    public var size: Size {
        didSet {
            updateAlignmentPositioning()
        }
    }
        
    private let priceLabel = BPKLabel()
    private let trailingTextLabel = BPKLabel()
    private let previousPriceLabel = BPKLabel()
    private let separatorLabel = BPKLabel()
    private let leadingTextLabel = BPKLabel()
    private let topTextStackView = UIStackView()
    private let priceStackView = UIStackView()
    private let containerStackView = UIStackView()
    
    public init(
        price: String? = nil,
        leadingText: String? = nil,
        previousPrice: String? = nil,
        trailingText: String? = nil,
        alignment: Alignment = .leading,
        size: Size = .large
    ) {
        self.price = price
        self.leadingText = leadingText
        self.previousPrice = previousPrice
        self.trailingText = trailingText
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
    
    private func setupView() {
        stylePriceLabel()
        styleAccessoryLabels()
        styleTopTextStackView()
        stylePriceStackView()
        styleContainerStackView()
        
        leadingTextLabel.text = leadingText
        separatorLabel.text = "•"
        priceLabel.text = price
        trailingTextLabel.text = trailingText
        
        previousPriceLabel.text = previousPrice
        applyLineThroughStyling()
        
        [
            priceStackView,
            containerStackView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        previousPriceLabel.isHidden = previousPrice == nil
        leadingTextLabel.isHidden = leadingText == nil
        trailingTextLabel.isHidden = trailingText == nil
        separatorLabel.isHidden = previousPriceLabel.isHidden || leadingTextLabel.isHidden
        
        updateAlignmentPositioning()
        
        containerStackView.addSubview(priceStackView)
        addSubview(containerStackView)
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
            priceStackView.spacing = BPKSpacingSm
        case .trailing:
            containerStackView.alignment = .trailing
            
            if size == .small {
                priceStackView.axis = .vertical
                priceStackView.spacing = BPKSpacingNone
            }
        }
    }
    
    private func accessoryFontStyle() -> BPKFontStyle {
        return size == .large ? .textFootnote : .textCaption
    }
    
    private func applyLineThroughStyling() {
        guard let previousPrice = previousPrice else {
            previousPriceLabel.attributedText = nil
            return
        }
        let attributedString = NSAttributedString(string: previousPrice, attributes: strikeThroughTextAttributes())
        previousPriceLabel.attributedText = attributedString
    }
    
    private func stylePriceLabel() {
        priceLabel.fontStyle = size == .large ? .textHeading2 : .textHeading4
        priceLabel.textColor = BPKColor.textPrimaryColor
    }
    
    private func styleAccessoryLabels() {
        [
            trailingTextLabel,
            previousPriceLabel,
            separatorLabel,
            leadingTextLabel
        ].forEach {
            $0.fontStyle = accessoryFontStyle()
            $0.textColor = BPKColor.textSecondaryColor
        }
    }
    
    private func styleTopTextStackView() {
        [previousPriceLabel, separatorLabel, leadingTextLabel].forEach {
            topTextStackView.addArrangedSubview($0)
        }
        topTextStackView.axis = .horizontal
        topTextStackView.spacing = BPKSpacingSm
    }
    
    private func stylePriceStackView() {
        [priceLabel, trailingTextLabel].forEach {
            priceStackView.addArrangedSubview($0)
        }
        priceStackView.axis = .horizontal
        priceStackView.spacing = BPKSpacingSm
        priceStackView.alignment = .firstBaseline
    }
    
    private func styleContainerStackView() {
        [topTextStackView, priceStackView].forEach {
            containerStackView.addArrangedSubview($0)
        }
        containerStackView.axis = .vertical
    }
    
    private func strikeThroughTextAttributes() -> [NSAttributedString.Key: Any] {
        [
            .foregroundColor: BPKColor.textSecondaryColor,
            .font: BPKFont.makeFont(fontStyle: accessoryFontStyle()),
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: BPKColor.textSecondaryColor
        ]
    }
}
