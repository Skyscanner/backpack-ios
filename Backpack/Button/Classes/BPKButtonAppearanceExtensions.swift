//
//  BPKButtonAppearanceExtensions.swift
//  Backpack
//
//  Created by Nicolas Frugoni on 17/02/2022.
//

import Foundation

extension BPKButtonAppearance {
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

extension BPKButton {
    func themedAppearance(_ appearance: BPKButtonAppearance, highlighted: Bool) -> BPKButtonAppearance {
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
    
    func trailingImageInsets(
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
    
    func leadingImageInsets(
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
    
    var justTextInsets: (title: UIEdgeInsets, image: UIEdgeInsets) {
        return (.zero, .zero)
    }
}
