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
