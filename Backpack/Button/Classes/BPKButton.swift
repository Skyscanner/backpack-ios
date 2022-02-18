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
    public var featuredContentColor: UIColor? {
        didSet {
            updateAppearance()
            updateTitle()
        }
    }
    public var featuredGradientStartColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    public var featuredGradientEndColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    public var primaryContentColor: UIColor? {
        didSet {
            updateAppearance()
            updateTitle()
        }
    }
    public var primaryGradientStartColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    public var primaryGradientEndColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    public var destructiveContentColor: UIColor? {
        didSet {
            updateAppearance()
            updateTitle()
        }
    }
    public var destructiveBackgroundColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    public var destructiveBorderColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    public var secondaryContentColor: UIColor? {
        didSet {
            updateAppearance()
            updateTitle()
        }
    }
    public var secondaryBackgroundColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    public var secondaryBorderColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    public var linkContentColor: UIColor = BPKColor.primaryColor {
        didSet {
            updateAppearance()
            updateTitle()
        }
    }
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
    private func dummyImage(withSize size: BPKButtonSize) -> UIImage? {
        let size = size == .large ? BPKIcon.concreteSizeForLargeIcon : BPKIcon.concreteSizeForSmallIcon
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        UIColor.black.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
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

fileprivate extension BPKButtonSize {
    var spinnerSize: BPKSpinnerSize {
        switch self {
        case .`default`: return .small
        case .large: return .`default`
        default:
            // Only here because size is an Obj-C NSUInteger enum
            fatalError("Unknown button size \(self)")
        }
    }
    
    func contentEdgeInsets(isIconOnly: Bool) -> UIEdgeInsets {
        switch self {
        case .`default`:
            return isIconOnly ? .with(equalInsets: BPKSpacingMd) : .with(
                sideInsets: BPKSpacingBase,
                topBottomInsets: BPKSpacingMd
            )
        case .large:
            return isIconOnly ? .with(
                equalInsets: BPKSpacingSm * 3
            ) : .with(
                sideInsets: BPKSpacingLg,
                topBottomInsets: BPKSpacingSm * 3
            )
        default:
            // Only here because size is an Obj-C NSUInteger enum
            fatalError("Unknown button size \(self)")
        }
    }
}

fileprivate extension BPKButtonStyle {
    var appearance: BPKButtonAppearanceSet {
        switch self {
        case .primary: return BPKButtonAppearanceSets.primary
        case .secondary: return BPKButtonAppearanceSets.secondary
        case .destructive: return BPKButtonAppearanceSets.destructive
        case .featured: return BPKButtonAppearanceSets.featured
        case .link: return BPKButtonAppearanceSets.link
        case .outline: return BPKButtonAppearanceSets.outline
        default:
            // Only here because style is an Obj-C NSUInteger enum
            fatalError("Unknown button style \(self)")
        }
    }
}

fileprivate extension BPKButtonAppearance {
    var hasGradientColor: Bool {
        let hasStart = self.gradientStartColor != nil
        let hasEnd = self.gradientEndColor != nil
        return hasStart && hasEnd
    }
    
    func gradient(traitCollection: UITraitCollection) -> BPKGradient? {
        guard hasGradientColor else { return nil }
        return gradientWith(
            topColor: gradientStartColor!,
            bottomColor: gradientEndColor!,
            traitCollection: traitCollection
        )
    }
    
    private func gradientWith(
        topColor top: UIColor,
        bottomColor bottom: UIColor,
        traitCollection: UITraitCollection
    ) -> BPKGradient {
        let direction = BPKGradientDirection.down
        return BPKGradient(
            colors: [
                top.resolvedColor(with: traitCollection),
                bottom.resolvedColor(with: traitCollection)
            ],
            start: BPKGradient.startPoint(for: direction),
            end: BPKGradient.endPointFor(for: direction)
        )
    }
}

extension UIColor {
    func highlighted(_ highlighted: Bool) -> UIColor {
        return highlighted ? self.dim : self
    }

    var dim: UIColor {
        BPKColor.blend(self, with: BPKColor.skyGray, weight: 0.85)
    }

    var reducedOpacity: UIColor {
        withAlphaComponent(0.8)
    }
}
