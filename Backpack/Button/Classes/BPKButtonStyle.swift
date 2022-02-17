//
//  BPKButtonStyle.swift
//  Backpack
//
//  Created by Nicolas Frugoni on 17/02/2022.
//

import Foundation

/**
 * Enum values for specifying button style
 */
@objc
public enum BPKButtonStyle: NSInteger {
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

extension BPKButtonStyle {
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
