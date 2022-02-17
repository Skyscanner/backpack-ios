//
//  BPKButton.swift
//  Backpack
//
//  Created by Nicolas Frugoni on 15/02/2022.
//

import UIKit

@objcMembers
// noop
public class BPKButton: UIButton {
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            updateAppearance()
            updateTitle()
        }
    }
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = BPKSpinner(style: .primary, size: self.size.spinnerSize)
        addSubview(spinner)
        return spinner
    }()
    public var title: String? {
        didSet { updateTitle() }
    }
    public var isLoading = false {
        didSet {
            if isLoading != oldValue {
                updateLoadingState()
            }
        }
    }
    public var size = BPKButtonSize.default {
        didSet { updateTitle() }
    }
    public var style = BPKButtonStyle.primary {
        didSet {
            updateAppearance()
            updateTitle()
            updateEdgeInsets()
        }
    }
    public var imagePosition = BPKButtonImagePosition.trailing {
        didSet { setNeedsLayout() }
    }
    private var gradientLayer = BPKGradientLayer()
    public override var isHighlighted: Bool {
        get { super.isHighlighted }
        set {
            let changed = isHighlighted != newValue
            super.isHighlighted = newValue
            if changed {
                updateAppearance()
                updateTitle()
            }
        }
    }
    
    public init(size: BPKButtonSize, style: BPKButtonStyle) {
        super.init(frame: .zero)
        setup(size: size, style: style)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup(size: .default, style: .primary)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(size: .default, style: .primary)
    }
    
    public func setImage(_ image: UIImage?) {
        super.setImage(image, for: .normal)
        updateAppearance()
        updateTitle()
        updateEdgeInsets()
    }
    
    public override var isEnabled: Bool {
        get { super.isEnabled }
        set {
            let changed = isEnabled != newValue
            super.isEnabled = newValue
            if changed {
                updateAppearance()
                updateTitle()
            }
        }
    }
    
    public override var isSelected: Bool {
        get { super.isSelected }
        set {
            assert(false, "The Backpack button does not support selected")
            super.isSelected = newValue
        }
    }
    
    private func updateLoadingState() {
        isEnabled = !isLoading
        spinner.isHidden = !isLoading
        if isLoading {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
        
        guard isTextOnly else { return }
        if isLoading {
            setImage(dummyImage(withSize: size))
            imageView?.layer.opacity = 0
            return
        }
        setImage(nil)
        imageView?.layer.opacity = 1
    }
    
    private var currentAppearance: BPKButtonAppearance {
        let appearanceSet = style.appearance
        if isLoading {
            return appearanceSet.loadingAppearance!
        }
        if !isEnabled {
            return appearanceSet.disabledAppearance!
        }
        if isHighlighted {
            return themedAppearance(appearanceSet.highlightedAppearance!, highlighted: true)
        }
        return themedAppearance(appearanceSet.regularAppearance!, highlighted: false)
    }
    
    private var currentContentColor: UIColor {
        currentAppearance.foregroundColor!
    }
    
    func setup(size: BPKButtonSize, style: BPKButtonStyle) {
        layer.masksToBounds = true
        adjustsImageWhenHighlighted = false
        adjustsImageWhenDisabled = false
        titleLabel?.textAlignment = .center
        titleLabel?.tintAdjustmentMode = .normal
        title = titleLabel?.text
        self.size = size
        self.style = style
        imagePosition = .trailing
        layer.insertSublayer(gradientLayer, at: 0)
        updateEdgeInsets()
        updateAppearance()
        updateTitle()
    }
    
    private var hasTitle: Bool {
        titleLabel?.text?.count ?? 0 > 0 && currentAttributedTitle != nil
    }
    
    private var hasIcon: Bool {
        currentImage != nil
    }
    
    private var isIconOnly: Bool {
        currentImage != nil && !hasTitle
    }
    
    private var isTextOnly: Bool {
        hasTitle && !hasIcon
    }
    
    private var isTextAndIcon: Bool {
        hasIcon && hasTitle
    }
    
    private func setIconInsets() {
        let buttonTitleIconSpacing = BPKSpacingIconText
        let insets = imagePosition == .trailing ?
        trailingImageInsets(with: buttonTitleIconSpacing)
        : leadingImageInsets(with: buttonTitleIconSpacing)
        titleEdgeInsets = insets.title
        imageEdgeInsets = insets.image
    }
    
    private func setOnlyTextInsets() {
        titleEdgeInsets = .zero
        imageEdgeInsets = .zero
        contentEdgeInsets = contentEdgeInset(size: size, style: style)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = layer.bounds
        layer.cornerRadius = style != .link ? cornerRadiusForLink : 0
        if isTextAndIcon || (isLoading && isTextOnly) {
            setIconInsets()
        } else {
            setOnlyTextInsets()
        }
        if let imageView = imageView {
            spinner.center = imageView.center
            imageView.alpha = isLoading ? 0 : 1
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        if isIconOnly || isTextOnly {
            return superSize
        }
        return CGSize(
            width: superSize.width + BPKSpacingIconText,
            height: superSize.height
        )
    }
    
    private var cornerRadiusForLink: CGFloat {
        isIconOnly ? bounds.height / 2 : BPKCornerRadiusSm
    }
    
    private func updateEdgeInsets() {
        if isIconOnly {
            imageEdgeInsets = .zero
            titleEdgeInsets = .zero
        }
        contentEdgeInsets = contentEdgeInset(size: size, style: style)
        setNeedsDisplay()
    }
    
    private func updateAppearance() {
        let appearance = currentAppearance
        tintColor = appearance.foregroundColor
        imageView?.tintColor = appearance.foregroundColor
        spinner.tintColor = appearance.foregroundColor
        
        gradientLayer.gradient = appearance.gradient(traitCollection: traitCollection)
        if appearance.borderColor != nil {
            layer.borderColor = appearance.borderColor?.cgColor
            layer.borderWidth = 2
        } else {
            layer.borderWidth = 0
        }
        setNeedsDisplay()
    }
    
    private func updateTitle() {
        if let title = title {
            let attributedTitle = BPKFont.makeAttributedString(
                fontStyle: currentFontStyle,
                content: title,
                textColor: currentContentColor
            )
            setAttributedTitle(attributedTitle, for: .normal)
        } else {
            setAttributedTitle(nil, for: .normal)
            setAttributedTitle(nil, for: .highlighted)
        }
        updateFont()
        updateEdgeInsets()
    }
    
    private func updateFont() {
        if isIconOnly {
            titleLabel?.font = .systemFont(ofSize: 0)
            setAttributedTitle(nil, for: .normal)
        }
        setNeedsDisplay()
    }
    
    func contentEdgeInset(size: BPKButtonSize, style: BPKButtonStyle) -> UIEdgeInsets {
        switch style {
        case .link: return .zero
        default: return size.contentEdgeInsets(isIconOnly: isIconOnly)
        }
    }
    
    var currentFontStyle: BPKFontStyle {
        switch size {
        case .`default`: return .textLabel2
        case .large: return .textHeading4
        default:
            // Only here because size is an Obj-C NSUInteger enum
            fatalError("Unknown button size \(size)")
        }
    }
}

private extension UIEdgeInsets {
    static func with(equalInsets inset: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(
            top: inset,
            left: inset,
            bottom: inset,
            right: inset
        )
    }
    
    static func with(sideInsets side: CGFloat, topBottomInsets topBottom: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(
            top: topBottom,
            left: side,
            bottom: topBottom,
            right: side
        )
    }
}
