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
        case left, right
    }
    
    public var price: String {
        didSet {
            priceLabel.text = price
        }
    }
    
    public var leadingText: String? {
        didSet {
            leadingTextLabel.text = leadingText
        }
    }
    
    public var lineThroughText: String? {
        didSet {
            applyLineThroughStyling()
        }
    }
    
    public var alignment: Alignment
    public let size: Size
    
    public var trailingText: String? {
        didSet {
            trailingTextLabel.text = trailingText
        }
    }
    
    private lazy var strikeThroughTextAttributes: [NSAttributedString.Key: Any] = {
        [
            .foregroundColor: BPKColor.textSecondaryColor,
            .font: BPKFont.makeFont(fontStyle: footnoteOrCaptionFontStyle()),
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: BPKColor.textSecondaryColor
        ]
    }()
    
    private lazy var priceLabel: BPKLabel = {
        let label = BPKLabel(fontStyle: size == .large ? .textHeading2 : .textHeading4)
        return label
    }()
    
    private lazy var trailingTextLabel: BPKLabel = {
        let label = BPKLabel(fontStyle: footnoteOrCaptionFontStyle())
        label.textColor = BPKColor.textSecondaryColor
        return label
    }()
    
    private lazy var lineThroughTextLabel: BPKLabel = {
        let label = BPKLabel(fontStyle: footnoteOrCaptionFontStyle())
        label.textColor = BPKColor.textSecondaryColor
        return label
    }()
    
    private lazy var separatorLabel: BPKLabel = {
        let label = BPKLabel(fontStyle: footnoteOrCaptionFontStyle())
        label.textColor = BPKColor.textSecondaryColor
        return label
    }()
    
    private lazy var leadingTextLabel: BPKLabel = {
        let label = BPKLabel(fontStyle: footnoteOrCaptionFontStyle())
        label.textColor = BPKColor.textSecondaryColor
        return label
    }()
    
    private lazy var topTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lineThroughTextLabel, separatorLabel, leadingTextLabel])
        stackView.axis = .horizontal
        stackView.spacing = BPKSpacingSm
        return stackView
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, trailingTextLabel])
        stackView.axis = .horizontal
        stackView.spacing = BPKSpacingSm
        stackView.alignment = .firstBaseline
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topTextStackView, priceStackView])
        stackView.axis = .vertical
        return stackView
    }()
    
    public init(
        price: String,
        leadingText: String? = nil,
        lineThroughText: String? = nil,
        trailingText: String? = nil,
        alignment: Alignment = .left,
        size: Size = .large
    ) {
        self.price = price
        self.leadingText = leadingText
        self.lineThroughText = lineThroughText
        self.trailingText = trailingText
        self.alignment = alignment
        self.size = size
        
        super.init(frame: .zero)
        
        leadingTextLabel.text = leadingText
        separatorLabel.text = "•"
        priceLabel.text = price
        trailingTextLabel.text = trailingText
        
        lineThroughTextLabel.text = lineThroughText
        applyLineThroughStyling()
        
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [
            priceStackView,
            containerStackView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        lineThroughTextLabel.isHidden = lineThroughText == nil
        leadingTextLabel.isHidden = leadingText == nil
        trailingTextLabel.isHidden = trailingText == nil
        separatorLabel.isHidden = lineThroughTextLabel.isHidden || leadingTextLabel.isHidden
        
        switch alignment {
        case .left:
            containerStackView.alignment = .leading
            priceStackView.axis = .horizontal
            priceStackView.spacing = BPKSpacingSm
        case .right:
            containerStackView.alignment = .trailing
            
            if size == .small {
                priceStackView.axis = .vertical
                priceStackView.spacing = BPKSpacingNone
            }
        }
        
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
    
    private func footnoteOrCaptionFontStyle() -> BPKFontStyle {
        return size == .large ? .textFootnote : .textCaption
    }
    
    private func applyLineThroughStyling() {
        guard let lineThroughText = lineThroughText else {
            lineThroughTextLabel.attributedText = nil
            return
        }
        let attributedString = NSAttributedString(string: lineThroughText, attributes: strikeThroughTextAttributes)
        lineThroughTextLabel.attributedText = attributedString
    }
}
