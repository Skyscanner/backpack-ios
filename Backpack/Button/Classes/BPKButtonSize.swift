//
//  BPKButtonSize.swift
//  Backpack
//
//  Created by Nicolas Frugoni on 17/02/2022.
//

import Foundation

@objc
public enum BPKButtonSize: NSInteger {
    case `default`
    case large
}

extension BPKButtonSize {
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
