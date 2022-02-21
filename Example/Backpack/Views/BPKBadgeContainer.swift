/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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
import Backpack

class BPKBadgeContainer: UIView {
    var label: BPKLabel!
    var badges = [BPKBadge]()
    let badgeMessages = ["Apples", "Bananas", "Strawberries"]
    var currentBadgeType = BPKBadgeType.success
    var badgesRequiringDarkBackground = [BPKBadgeType.light, BPKBadgeType.inverse, BPKBadgeType.outline]

    var badgeType: BPKBadgeType {
        get { return currentBadgeType }
        set {
            currentBadgeType = newValue
            for badge in badges {
                badge.type = newValue
            }
            label.text = getLegibleName(badgeType: newValue)
            label.sizeToFit()
            if badgesRequiringDarkBackground.contains(badgeType) {
                self.backgroundColor = BPKColor.skyGrayTint01
                self.label.textColor = BPKColor.white
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUp()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    func setUp() {
        label = BPKLabel(fontStyle: .textBodyDefault)
        label.text = getLegibleName(badgeType: currentBadgeType)
        label.sizeToFit()
        addSubview(label)

        populateBadges()

        let badgesStack = UIStackView(frame: .zero)
        badgesStack.alignment = .center
        badgesStack.distribution = .equalSpacing
        badgesStack.spacing = BPKSpacingMd
        for badge in badges {
//            badgesStack.addArrangedSubview(badge)
        }
        addSubview(badgesStack)
        let butt = AButton(frame: .zero)
        butt.title = "Create"
        badgesStack.addArrangedSubview(butt)
        label.translatesAutoresizingMaskIntoConstraints = false
        badgesStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            label.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            badgesStack.topAnchor.constraint(equalTo: label.bottomAnchor),
            badgesStack.widthAnchor.constraint(equalToConstant: 320),
            badgesStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            badgesStack.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
            ])
    }

    func populateBadges() {
        let badge = BPKBadge(message: badgeMessages[0])
        badge.type = currentBadgeType
        badges.append(badge)
        
        let badgeWithLeadingIcon = BPKBadge(
            icon: .init(position: .leading, iconName: .time),
            message: badgeMessages[1]
        )
        badgeWithLeadingIcon.type = currentBadgeType
        badges.append(badgeWithLeadingIcon)
        
        let badgeWithTrailingIcon = BPKBadge(
            icon: .init(position: .trailing, iconName: .time),
            message: badgeMessages[2]
        )
        badgeWithTrailingIcon.type = currentBadgeType
        badges.append(badgeWithTrailingIcon)
    }
    
    func getLegibleName(badgeType: BPKBadgeType) -> String {
        switch badgeType {
        case .success:
            return "Success"
        case .destructive:
            return "Destructive"
        case .warning:
            return "Warning"
        case .inverse:
            return "Inverse"
        case .light:
            return "Light"
        case .outline:
            return "Outline"
        }
    }
}

class AButton: UIControl {
    enum Size {
        case small, large
        
        var height: CGFloat {
            switch self {
            case .small: return 36
            case .large: return 48
            }
        }
        
        var font: BPKFontStyle {
            switch self {
            case .small: return  .textLabel2
            case .large: return  .textLabel1
            }
        }
    }
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = BPKSpacingMd
        stack.clipsToBounds = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var titleLabel = BPKLabel(fontStyle: size.font)
    private let imageView = UIImageView()
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    var image: UIImage? {
        get { imageView.image }
        set {
            imageView.image = newValue
            imageView.isHidden = newValue == nil
        }
    }
    let backgroundLayer = CALayer()
    private let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = BPKColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.isUserInteractionEnabled = false
        return view
    }()
    var size: Size = .small {
        didSet {
            updateSize()
        }
    }
    private lazy var heightConstraint = heightAnchor.constraint(equalToConstant: size.height)
    
    init(size: Size) {
        self.size = size
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override var isHighlighted: Bool {
        get { super.isHighlighted }
        set {
            super.isHighlighted = newValue
            backgroundLayer.backgroundColor = BPKColor.backgroundSecondaryDarkColor.cgColor
        }
    }
    
    private func setup () {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        layer.addSublayer(backgroundLayer)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundLayer.backgroundColor = BPKColor.primaryColor.cgColor
        
        addSubview(contentView)
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topAnchor.constraint(equalTo: contentView.topAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: BPKSpacingBase),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -BPKSpacingBase),
            stack.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            heightConstraint
        ])
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(imageView)
        imageView.isHidden = true
        updateSize()
    }
    private func updateSize() {
        titleLabel.fontStyle = size.font
        heightConstraint.constant = size.height
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = self.bounds
    }
}
