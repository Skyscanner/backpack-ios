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

@objcMembers
@objc
public class BPKChip: UIControl {
    // MARK: - Public API
    public var title: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
    public var icon: Icon? {
        didSet {
            updateLookAndFeel()
        }
    }
    
    public var primaryColor: UIColor? {
        didSet {
            updateLookAndFeel()
        }
    }
    
    public var backgroundTint: UIColor? {
        didSet {
            updateLookAndFeel()
        }
    }
    
    public var style: BPKChipStyle = .outline {
        didSet {
            updateLookAndFeel()
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            updateLookAndFeel()
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            CATransaction.begin()
            CATransaction.setAnimationDuration(isHighlighted ? 0.2 : 0)
            tintLayer.opacity = isHighlighted ? 0.2 : 0
            CATransaction.commit()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            updateLookAndFeel()
        }
    }
    
    private var contentColor: UIColor = BPKColor.textPrimaryColor
    
    private let label: BPKLabel = {
        let label = BPKLabel(fontStyle: .textFootnote)
        label.textAlignment = .center
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
        stack.spacing = BPKSpacingIconText
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    private let tintLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = BPKColor.skyGrayTint02.cgColor
        layer.opacity = 0
        return layer
    }()
    
    public convenience init(title: String, icon: Icon? = nil) {
        self.init(frame: .zero)
        self.title = title
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        tintLayer.frame = self.bounds
        tintLayer.cornerRadius = self.bounds.height / 2.0
        self.layer.cornerRadius = self.bounds.height / 2.0
    }
    
    // This is required as the colours that are blended will not be dynamic values
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if self.traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            updateLookAndFeel()
        }
    }
}

// MARK: - Private API
extension BPKChip {
    private func setup() {
        layer.addSublayer(tintLayer)
        addSubview(containerStackView)
        
        isAccessibilityElement = true
        accessibilityTraits = .button
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: chipHorizontalSpacing),
            trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor, constant: chipHorizontalSpacing),
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: chipVerticalSpacing),
            bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: chipVerticalSpacing)
        ])
        
        addTarget(self, action: #selector(handleSingleTap), for: .touchUpInside)
    }
    
    @objc
    private func handleSingleTap(sender: UITapGestureRecognizer) {
        isSelected.toggle()
    }
    
    private func updateLookAndFeel() {
        if self.isSelected {
            backgroundColor = selectedBackgroundColor
            contentColor = BPKColor.white
        } else {
            backgroundColor = unselectedBackgroundColor
            contentColor = BPKColor.textPrimaryColor
        }
        
        if !self.isEnabled {
            backgroundColor = disabledBackgroundColor
            contentColor = disabledContentColor
        }
                
        iconView.image = icon.orNil(color: contentColor)
        label.textColor = contentColor
        
        accessibilityTraits = .button
        if isSelected {
            accessibilityTraits.insert(.selected)
        }
        
        if !isEnabled {
            accessibilityTraits.insert(.notEnabled)
        }
        
        accessibilityLabel = title
        
        placeElements()
        updateOutline()
    }
    
    private func updateOutline() {
        if isSelected {
            layer.borderWidth = 0
            layer.borderColor = nil
            return
        }
        
        switch style {
        case .filled:
            layer.borderWidth = 0
            layer.borderColor = nil
        case .outline:
            layer.borderWidth = 1
            let borderColor = isEnabled ? outlineColor : disabledOutlineColor
            layer.borderColor = borderColor.cgColor
        }
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
}

// MARK: - Updates
extension BPKChip {
    private var currentPrimaryColor: UIColor {
        guard let primaryColor = primaryColor else {
            return BPKColor.skyBlue
        }
        
        return primaryColor
    }
    
    private var selectedBackgroundColor: UIColor {
        guard let backgroundTint = backgroundTint else {
            return currentPrimaryColor
        }
        
        return backgroundTint
    }
    
    private var unselectedBackgroundColor: UIColor {
        guard let backgroundTint = backgroundTint else {
            switch style {
            case .filled:
                return BPKColor.dynamicColor(
                    withLightVariant: BPKColor.skyGrayTint07,
                    darkVariant: BPKColor.blackTint03
                )
            case .outline:
                return BPKColor.dynamicColor(withLightVariant: BPKColor.white, darkVariant: BPKColor.blackTint03)
            }
        }
        
        return BPKColor.blend(backgroundTint, with: BPKColor.backgroundTertiaryColor, weight: 0.2)
    }
    
    private var disabledBackgroundColor: UIColor {
        switch style {
        case .outline:
            return BPKColor.clear
        case .filled:
            var lightColor = BPKColor.skyGrayTint07
            let darkColor = BPKColor.blackTint03
            
            if let backgroundTint = backgroundTint {
                lightColor = BPKColor.blend(backgroundTint, with: BPKColor.backgroundTertiaryColor, weight: 0.2)
            }
            
            return BPKColor.dynamicColor(withLightVariant: lightColor, darkVariant: darkColor)
        }
    }
}

// MARK: - Helpers
extension BPKChip {
    private var chipIconSpacing: CGFloat {
        return BPKSpacingIconText
    }
    
    private var chipHorizontalSpacing: CGFloat {
        return BPKSpacingBase
    }
    
    private var chipVerticalSpacing: CGFloat {
        return BPKSpacingMd
    }
    
    private var disabledContentColor: UIColor {
        return BPKColor.dynamicColor(withLightVariant: BPKColor.skyGrayTint04, darkVariant: BPKColor.blackTint06)
    }
    
    private var outlineColor: UIColor {
        return BPKColor.dynamicColor(withLightVariant: BPKColor.skyGrayTint03, darkVariant: BPKColor.blackTint06)
    }
    
    private var disabledOutlineColor: UIColor {
        return BPKColor.dynamicColor(withLightVariant: BPKColor.skyGrayTint05, darkVariant: BPKColor.blackTint06)
    }
}

fileprivate extension Optional where Wrapped == BPKChip.Icon {
    func orNil(color: UIColor) -> UIImage? {
        guard let icon = self else { return nil }
        return BPKIcon.makeLargeIcon(name: icon.iconName, color: color)
    }
}
