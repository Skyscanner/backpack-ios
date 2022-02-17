//
//  BPKButtonColors.swift
//  Backpack
//
//  Created by Nicolas Frugoni on 17/02/2022.
//

import Foundation

public extension BPKButton {
    var featuredContentColor: UIColor? {
        didSet {
            updateAppearance()
            updateTitle()
        }
    }
    var featuredGradientStartColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    var featuredGradientEndColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    var primaryContentColor: UIColor? {
        didSet {
            updateAppearance()
            updateTitle()
        }
    }
    var primaryGradientStartColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    var primaryGradientEndColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    var destructiveContentColor: UIColor? {
        didSet {
            updateAppearance()
            updateTitle()
        }
    }
    var destructiveBackgroundColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    var destructiveBorderColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    var secondaryContentColor: UIColor? {
        didSet {
            updateAppearance()
            updateTitle()
        }
    }
    var secondaryBackgroundColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    var secondaryBorderColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    var linkContentColor: UIColor = BPKColor.primaryColor {
        didSet {
            updateAppearance()
            updateTitle()
        }
    }
}

extension UIColor {
    func highlighted(_ highlighted: Bool) -> UIColor {
        return highlighted ? .dim(self) : self
    }

    static func dim(_ color: UIColor) -> UIColor {
        BPKColor.blend(color, with: BPKColor.skyGray, weight: 0.85)
    }

    static func reduceOpacity(of color: UIColor) -> UIColor {
        color.withAlphaComponent(0.8)
    }
}

extension BPKButton {
    func dummyImage(withSize size: BPKButtonSize) -> UIImage? {
        let size = size == .large ? BPKIcon.concreteSizeForLargeIcon : BPKIcon.concreteSizeForSmallIcon
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        UIColor.black.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
