//
//  ConfigurationExtensions.swift
//  Pods
//
//  Created by Kynan Song on 28/10/2025.
//

import SwiftUI

// As we are not adding the new colours to Foundations yet, this is to handle the new colouring.
extension UIColor {
    private static var dynamicColorsCache = NSCache<NSString, UIColor>()

    public static func dynamicColorTest(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return light
        }

        let key = "\(light.cacheKey)_\(dark.cacheKey)" as NSString

        if let cached = dynamicColorsCache.object(forKey: key) {
            return cached
        }

        let dynamicColour = UIColor { traits -> UIColor in
            traits.userInterfaceStyle == .dark ? dark : light
        }

        dynamicColorsCache.setObject(dynamicColour, forKey: key)
        return dynamicColour
    }

    private var cacheKey: String {
        guard let components = cgColor.components else { return description }
        return components.map(String.init).joined(separator: "_")
    }
}

extension Font {
    
    public static func toUIFont(
        font: Font,
        face: String? = nil,
        size: CGFloat,
        weight: UIFont.Weight
    ) -> UIFont {
        if let face = face, let custom = UIFont(name: face, size: size) {
            return custom
        } else {
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }

    public static func blackUIFont(size: CGFloat, style: TextStyle) -> UIFont {
        let face = BPKFont.fontDefinition?.blackFontFace as String?
        return toUIFont(
            font: .black(
                size: size,
                textStyle: style
            ),
            face: face,
            size: size,
            weight: .black
        )
    }
}
