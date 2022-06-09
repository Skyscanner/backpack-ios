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

    public var iconName: BPKSmallIconName? {
        didSet {
            updateLookAndFeel()
        }
    }
    
    /**
     * The primary color of the reciever. This is used to control the
     * selected background colour.
     *
     * @warning This is not intended to be used directly, it exists to support theming only.
     */
    public var primaryColor: UIColor? {
        didSet {
            updateLookAndFeel()
        }
    }
    
    /**
     * Style of the chip. Default is BPKChipStyleOutline.
     */
    public var style: BPKChipStyle = .outline {
        didSet {
            updateLookAndFeel()
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            if !isEnabled && isSelected {
                isSelected = false
            }
            if isSelected {
                accessibilityTraits.insert(.selected)
            }
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
            if !isEnabled {
                accessibilityTraits.insert(.notEnabled)
            }
            updateLookAndFeel()
        }
    }
    
    private var colors: BPKChipAppearanceSets.Colors {
        let appearance = BPKChipAppearanceSets.appearance(fromStyle: style)
        if !isEnabled { return appearance.disabled }
        if isSelected { return appearance.on }
        return appearance.off
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
    
    /**
     * Creates a `BPKChip` with the title and icon given.
     *
     * @param title String to use as the title.
     * @param icon BPKChip.Icon to use as the icon
     */
    public convenience init(title: String, icon: BPKSmallIconName? = nil) {
        self.init(frame: .zero)
        self.title = title
        self.iconName = icon
        
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
        backgroundColor = colors.background
        iconView.image = iconName.orNil(withColor: colors.content)
        label.textColor = colors.content
        
        accessibilityTraits = .button
        
        accessibilityLabel = title
        
        placeElements()
        updateOutline()
    }
    
    @available(*, deprecated, message: "Will be removed when outline style is removed")
    private func updateOutline() {
        if isSelected && isEnabled {
            layer.borderWidth = 0
            layer.borderColor = nil
            return
        }
        
        if style == .outline {
            layer.borderWidth = 1
            let borderColor = isEnabled ? outlineColor : disabledOutlineColor
            layer.borderColor = borderColor.cgColor
            return
        }
        layer.borderWidth = 0
        layer.borderColor = nil
    }
    
    private func placeElements() {
        let subviews = containerStackView.arrangedSubviews
        subviews.forEach(containerStackView.removeArrangedSubview)
        subviews.forEach { $0.removeFromSuperview() }
        if iconName != nil {
            containerStackView.addArrangedSubview(iconView)
        }
        containerStackView.addArrangedSubview(label)
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
    
    private var outlineColor: UIColor {
        return BPKColor.dynamicColor(withLightVariant: BPKColor.skyGrayTint03, darkVariant: BPKColor.blackTint06)
    }

    private var disabledOutlineColor: UIColor {
        return BPKColor.dynamicColor(withLightVariant: BPKColor.skyGrayTint05, darkVariant: BPKColor.blackTint06)
    }
}

fileprivate extension Optional where Wrapped == BPKSmallIconName {
    func orNil(withColor color: UIColor) -> UIImage? {
        guard let icon = self else { return nil }
        return BPKIcon.makeSmallIcon(name: icon, color: color)
    }
}
