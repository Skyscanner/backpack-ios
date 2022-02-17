//
//  BPKButton.swift
//  Backpack
//
//  Created by Nicolas Frugoni on 15/02/2022.
//

import UIKit


/**
 * Enum values for specifying button style
 */
@objc(BPKButtonStyle)
public enum ButtonStyle: NSInteger {
    /**
     * Primary button style, suitable for use as the primary call to action
     */
    case primary

    /**
     * Secondary button style, suitable for secondary call to actions.
     */
    case secondary

    /**
     * Destructive button style, suitable for actions that are destructive.
     * Should typically be paired with a confirmation.
     */
    case destructive

    /**
     * Featured button style, suitable for soem specific cases to differentiate from
     * the primary style.
     */
    case featured

    /**
     * Link button style, suitable for inline display and de-emphasized actions.
     */
    case link

    /**
     * Outline button style, suitable for use on coloured backgrounds.
     */
    case outline
};


@objc(BPKButtonSize)
public enum ButtonSize: NSInteger {
    case `default`
    case large
}

@objc(BPKButtonImagePosition)
public enum ButtonImagePosition: NSInteger {
    case leading
    case trailing
}

@objcMembers
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
    public var size = ButtonSize.default {
        didSet { updateTitle() }
    }
    public var style = ButtonStyle.primary {
        didSet {
            updateAppearance()
            updateTitle()
            updateEdgeInsets()
        }
    }
    public var imagePosition = ButtonImagePosition.trailing {
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
    
    public init(size: ButtonSize, style: ButtonStyle) {
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
    
    private func themedAppearance(_ appearance: BPKButtonAppearance, highlighted: Bool) -> BPKButtonAppearance {
        var foreground: UIColor?
        var gradientStart: UIColor?
        var gradientEnd: UIColor?
        var border: UIColor?
        
        let themedAppearance = appearance.clone()
        switch style {
        case .primary:
            foreground = primaryContentColor?.highlighted(highlighted)
            gradientStart = primaryGradientStartColor?.highlighted(highlighted)
            gradientEnd = primaryGradientEndColor?.highlighted(highlighted)
        case .secondary:
            foreground = secondaryContentColor?.highlighted(highlighted)
            border = secondaryBorderColor?.highlighted(highlighted)
            gradientStart = secondaryBackgroundColor?.highlighted(highlighted)
            gradientEnd = gradientStart
        case .destructive:
            foreground = destructiveContentColor?.highlighted(highlighted)
            border = destructiveBorderColor?.highlighted(highlighted)
            gradientStart = destructiveBackgroundColor?.highlighted(highlighted)
            gradientEnd = gradientStart
        case .featured:
            foreground = featuredContentColor?.highlighted(highlighted)
            gradientStart = featuredGradientStartColor?.highlighted(highlighted)
            gradientEnd = featuredGradientEndColor?.highlighted(highlighted)
        case .link:
            foreground = highlighted ? .reduceOpacity(of: linkContentColor) : linkContentColor
        default:
            break
        }
        themedAppearance.foregroundColor = foreground
        themedAppearance.gradientStartColor = gradientStart
        themedAppearance.gradientEndColor = gradientEnd
        themedAppearance.borderColor = border
        return themedAppearance
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
    
    func setup(size: ButtonSize, style: ButtonStyle) {
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
    
    private func trailingImageInsets(
        with spacing: CGFloat
    ) -> (title: UIEdgeInsets, image: UIEdgeInsets) {
        let textSideInsets = imageView!.bounds.width + spacing / 2
        let iconSidesInsets = titleLabel!.bounds.width + spacing / 2
        
        let titleEdgeInsets = bpk_makeRTLAwareEdgeInsets(
            withTop: 0,
            leading: -textSideInsets,
            bottom: 0,
            trailing: textSideInsets
        )
        let imageEdgeInsets = bpk_makeRTLAwareEdgeInsets(
            withTop: 0,
            leading: iconSidesInsets,
            bottom: 0,
            trailing: -iconSidesInsets
        )
        return (titleEdgeInsets, imageEdgeInsets)
    }
    
    private func leadingImageInsets(
        with spacing: CGFloat
    ) -> (title: UIEdgeInsets, image: UIEdgeInsets) {
        let sidesInsets = spacing / 2
        let titleEdgeInsets = bpk_makeRTLAwareEdgeInsets(
            withTop: 0,
            leading: sidesInsets,
            bottom: 0,
            trailing: -sidesInsets
        )
        let imageEdgeInsets = bpk_makeRTLAwareEdgeInsets(
            withTop: 0,
            leading: -sidesInsets,
            bottom: 0,
            trailing: sidesInsets
        )
        return (titleEdgeInsets, imageEdgeInsets)
    }
    
    private var justTextInsets: (title: UIEdgeInsets, image: UIEdgeInsets) {
        return (.zero, .zero)
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
    
    func contentEdgeInset(size: ButtonSize, style: ButtonStyle) -> UIEdgeInsets {
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

private extension ButtonStyle {
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

private extension UIColor {
    func highlighted(_ highlighted: Bool) -> UIColor {
        return highlighted ? .dim(self) : self
    }
}

private extension ButtonSize {
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

private extension BPKButton {
    func dummyImage(withSize size: ButtonSize) -> UIImage? {
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

private extension BPKButtonAppearance {
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
    static func dim(_ color: UIColor) -> UIColor {
        BPKColor.blend(color, with: BPKColor.skyGray, weight: 0.85)
    }

    static func reduceOpacity(of color: UIColor) -> UIColor {
        color.withAlphaComponent(0.8)
    }
}
