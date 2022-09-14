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

    public override var isSelected: Bool {
        didSet {
            updateLookAndFeel()
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            CATransaction.begin()
            CATransaction.setAnimationDuration(isHighlighted ? 0.2 : 0)
            tintLayer.opacity = isHighlighted ? 1 : 0
            let appearance = BPKChipAppearanceSets.appearance(fromStyle: style)
            label.textColor = isHighlighted ? appearance.highlighted.content : colors.content
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
        if isSelected { return appearance.selected }
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
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    private lazy var tintLayer: CALayer = {
        let layer = CALayer()
        let appearance = BPKChipAppearanceSets.appearance(fromStyle: style)
        layer.backgroundColor = appearance.highlighted.background.cgColor
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
        tintLayer.cornerRadius = self.bounds.height / 2.0
        self.layer.cornerRadius = self.bounds.height / 2.0
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
        
        isAccessibilityElement = true
        accessibilityTraits = .button
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: chipHorizontalSpacing),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -chipHorizontalSpacing),
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: chipVerticalSpacing),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -chipVerticalSpacing)
        ])
        
        addTarget(self, action: #selector(handleSingleTap), for: .touchUpInside)
    }
    
    @objc
    private func handleSingleTap(sender: UITapGestureRecognizer) {
        if isEnabled {
            isSelected.toggle()
        }
    }
    
    private func updateLookAndFeel() {
        backgroundColor = colors.background
        iconView.image = icon.orNil(withColor: colors.content)
        label.textColor = colors.content
        accessoryIconView.image = accessoryIcon.orNil(withColor: colors.content)
        accessibilityTraits = .button
        
        accessibilityLabel = title
        
        placeElements()
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
        if type == .select { return .tick }
        if type == .dismiss { return .closeCircle }
        return nil
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
}

fileprivate extension Optional where Wrapped == BPKSmallIconName {
    func orNil(withColor color: UIColor) -> UIImage? {
        guard let icon = self else { return nil }
        return BPKIcon.makeSmallIcon(name: icon, color: color)
    }
}
