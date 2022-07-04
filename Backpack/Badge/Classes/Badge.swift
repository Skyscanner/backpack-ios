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
public class BPKBadge: UIView {
    public var message: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
    public var type: BPKBadgeType = .success {
        didSet { updateLookAndFeel() }
    }
    
    public var icon: Icon? {
        didSet {
            updateLookAndFeel()
        }
    }
    
    private let label: BPKLabel = {
        let label = BPKLabel(fontStyle: .textCaption)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let iconView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let containerStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = BPKSpacingSm
        return stack
    }()

    public convenience init(type: BPKBadgeType = .success, icon: Icon? = nil, message: String) {
        self.init(frame: .zero)
        self.message = message
        self.type = type
        self.icon = icon
        updateLookAndFeel()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func updateLookAndFeel() {
        layer.borderWidth = 0
        backgroundColor = type.backgroundColor
        label.textColor = type.textColor
        
        if type == .outline {
            layer.borderColor = BPKColor.white.cgColor
            layer.borderWidth = BPKBorderWidthSm
        }
        
        iconView.image = icon.orNil(forType: type)
        placeElements()
    }
    
    private func removeStackViewSubviews() {
        let subviews = containerStackView.arrangedSubviews
        subviews.forEach(containerStackView.removeArrangedSubview)
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func placeElements() {
        removeStackViewSubviews()
        containerStackView.addArrangedSubview(label)
        guard let icon = icon else { return }
        if icon.position == .leading {
            containerStackView.insertArrangedSubview(iconView, at: 0)
        } else {
            containerStackView.addArrangedSubview(iconView)
        }
    }
    
    private func setup() {
        addSubview(containerStackView)
        
        layer.cornerRadius = BPKCornerRadiusXs
        layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: BPKSpacingLg),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BPKSpacingMd),
            trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor, constant: BPKSpacingMd),
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: BPKSpacingSm),
            bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: BPKSpacingSm)
        ])
        
        updateLookAndFeel()
    }
    
    func changeContent(color: UIColor) {
        guard type == .outline else { return }
        backgroundColor = BPKColor.clear
        layer.borderColor = color.cgColor
        label.textColor = color
    }
}

fileprivate extension BPKBadgeType {
    var textColor: UIColor {
        switch self {
        case .outline, .destructive:
            return BPKColor.white
        case .normal:
            return BPKColor.textPrimaryColor
        case .strong:
            return BPKColor.dynamicColor(withLightVariant: BPKColor.white, darkVariant: BPKColor.skyGray)
        default:
            return BPKColor.skyGray
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .success:
            return BPKColor.glencoe
        case .warning:
            return BPKColor.erfoud
        case .destructive:
            return BPKColor.panjin
        case .light:
            return BPKColor.skyGrayTint07
        case .inverse:
            return BPKColor.white
        case .outline:
            return BPKColor.white.withAlphaComponent(0.2)
        case .normal:
            return BPKColor.dynamicColor(withLightVariant: BPKColor.skyGrayTint07, darkVariant: BPKColor.blackTint02)
        case .strong:
            return BPKColor.textPrimaryColor
        }
    }
}

fileprivate extension Optional where Wrapped == BPKBadge.Icon {
    func orNil(forType type: BPKBadgeType) -> UIImage? {
        guard let icon = self else { return nil }
        return BPKIcon.makeSmallIcon(name: icon.iconName, color: type.textColor)
    }
}
