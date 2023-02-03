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
    /**
     * The title to display inside the chip.
     */
    public var title: String? {
        get { label.text }
        set {
            label.text = newValue
            updateLookAndFeel()
        }
    }

    public var icon: BPKSmallIconName? {
        didSet {
            updateLookAndFeel()
        }
    }
        
    /**
     * Style of the chip. Default is BPKChipStyleDefault.
     */
    public var style: BPKChipStyle = .default {
        didSet {
            updateLookAndFeel()
        }
    }
    
    public var type: BPKChipType = .option {
        didSet {
            updateLookAndFeel()
        }
    }
    
    /**
     *  Set this to false, if you want to manipulate the selected state yourself by setting the `isSelected` value.
     */
    public var isAutomaticSelectionEnabled: Bool = true

    public override var isSelected: Bool {
        didSet {
            updateLookAndFeel()
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            CATransaction.begin()
            CATransaction.setAnimationDuration(isHighlighted ? 0.2 : 0)
            let appearance = BPKChipAppearanceSets.appearance(fromStyle: style)
            let tintLayerColor =  isSelected ? appearance.selected.background : appearance.highlighted.background
            tintLayer.backgroundColor = tintLayerColor.cgColor
            tintLayer.opacity = isHighlighted ? 1 : 0
            updateLookAndFeel()
            CATransaction.commit()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            updateLookAndFeel()
        }
    }
    
    private var colors: BPKChipAppearanceSets.Colors {
        let appearance = BPKChipAppearanceSets.appearance(fromStyle: style)
        if !isEnabled { return appearance.disabled }
        if isSelected || type == .dismiss { return appearance.selected }
        return appearance.normal
    }
    
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
    
    private let accessoryIconView: UIImageView = {
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
        stack.alignment = .center
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    private var trailingConstraint: NSLayoutConstraint?
    
    private lazy var tintLayer: CALayer = {
        let layer = CALayer()
        layer.opacity = 0
        
        return layer
    }()
    
    /**
     * Creates a `BPKChip` with the title and icon given.
     *
     * @param title String to use as the title.
     * @param icon BPKChip.Icon to use as the icon
     */
    public convenience init(title: String, icon: BPKSmallIconName? = nil) {
        self.init(frame: .zero)
        self.title = title
        self.icon = icon
        
        updateLookAndFeel()
    }
    
    /**
     * Create a `BPKChip` with a given frame.
     *
     * @param frame The initial frame of the chip.
     * @return `BPKChip` instance.
     */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    /**
     * Creates a `BPKChip` with a decoder (typically when creating from Storyboards)
     *
     * @param aDecoder Decoder object to extract parameters from
     * @return `BPKChip` instance.
     */
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        tintLayer.frame = self.bounds
        tintLayer.cornerRadius = BPKSpacingMd
        self.layer.cornerRadius = BPKSpacingMd
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            updateLookAndFeel()
        }
    }
}

// MARK: - Private API
extension BPKChip {
    private func setup() {
        layer.addSublayer(tintLayer)
        addSubview(containerStackView)
        
        updateAccessibility()
        
        trailingConstraint = containerStackView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -chipTrailingSpacing
        )
                
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: chipLeadingSpacing),
            trailingConstraint!,
            containerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            heightAnchor.constraint(equalToConstant: BPKSpacingXl),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        addTarget(self, action: #selector(handleSingleTap), for: .touchUpInside)
    }
    
    @objc
    private func handleSingleTap(sender: UITapGestureRecognizer) {
        guard isEnabled else { return }
        guard isAutomaticSelectionEnabled else { return }
        guard type != .dismiss else { return }
                
        isSelected.toggle()
    }
    
    private func updateLookAndFeel() {
        updateOutlineStroke()
        backgroundColor = self.colors.background
        label.textColor = self.colors.content

        iconView.image = self.icon.orNil(withColor: self.colors.content)
        
        accessoryIconView.image = self.accessoryIcon.orNil(withColor: self.accessoryColor)
        
        updateAccessibility()
        placeElements()
        
        trailingConstraint?.constant = -self.chipTrailingSpacing
        setNeedsUpdateConstraints()
        
        if let shadow = self.shadow {
            shadow.apply(to: layer)
        } else {
            layer.shadowOpacity = 0
        }
    }
    
    private func updateAccessibility() {
        isAccessibilityElement = true
        accessibilityTraits = .button
        
        if isSelected && type != .dismiss {
            accessibilityTraits.insert(.selected)
        } else {
            accessibilityTraits.remove(.selected)
        }
        
        if !isEnabled {
            accessibilityTraits.insert(.notEnabled)
        } else {
            accessibilityTraits.remove(.notEnabled)
        }
        
        accessibilityLabel = title
    }
    
    private func updateOutlineStroke() {
        let appearance = BPKChipAppearanceSets.appearance(fromStyle: style)
        let strokeColor = isHighlighted ? appearance.highlighted.stroke : colors.stroke
        if let stroke = strokeColor {
            layer.borderColor = stroke.cgColor
            layer.borderWidth = 1
        } else {
            layer.borderWidth = 0
        }
    }
    
    private func placeElements() {
        let subviews = containerStackView.arrangedSubviews
        subviews.forEach(containerStackView.removeArrangedSubview)
        subviews.forEach { $0.removeFromSuperview() }
        if icon != nil {
            containerStackView.addArrangedSubview(iconView)
        }
        containerStackView.addArrangedSubview(label)
        if accessoryIcon != nil {
            containerStackView.addArrangedSubview(accessoryIconView)
        }
    }

    private var accessoryIcon: BPKSmallIconName? {
        if type == .dismiss { return .closeCircle }
        if type == .dropdown { return .chevronDown }
        return nil
    }
    
    private var accessoryColor: UIColor {
        if !isEnabled {
            let appearance = BPKChipAppearanceSets.appearance(fromStyle: style)
            return appearance.disabled.content
        }
        
        if type == .dismiss && !isHighlighted {
            if style == .onDark {
                return BPKColor.chipOnDarkOnDismissIconColor
            } else {
                return BPKColor.textDisabledOnDarkColor
            }
        }
        
        return colors.content
    }
    
    private var shadow: BPKShadow? {
        if style == .onImage {
            return BPKShadow.shadowSm()
        }
        
        return nil
    }
}

// MARK: - Helpers
extension BPKChip {
    private var chipIconSpacing: CGFloat {
        return BPKSpacingIconText
    }
    
    private var chipLeadingSpacing: CGFloat {
        return BPKSpacingBase
    }
    
    private var chipTrailingSpacing: CGFloat {
        return accessoryIcon != nil ? BPKSpacingMd : BPKSpacingBase
    }
}

fileprivate extension Optional where Wrapped == BPKSmallIconName {
    func orNil(withColor color: UIColor) -> UIImage? {
        guard let icon = self else { return nil }
        return BPKIcon.makeSmallIcon(name: icon, color: color)
    }
}
