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
 
import SwiftUI

public struct BPKFont {
    static var fontDefinition: BPKFontDefinition?
    
    public static func setFontDefinition(_ fontDefinition: BPKFontDefinition) {
        BPKFont.fontDefinition = fontDefinition
    }
}

public protocol BPKFontDefinition {
    var fontFamily: String { get }
    var regularFontFace: String { get }
    var semiboldFontFace: String { get }
    var heavyFontFace: String { get }
}

private extension UIFont {
    static func customOrDefault(_ name: String?, size: CGFloat, weight: Weight) -> UIFont {
        guard let name = name, let font = UIFont(name: name, size: size) else {
            return .systemFont(ofSize: size, weight: weight)
        }
        return font
    }
}

public struct BPKRelativeFontDefinition: BPKFontDefinition {
    public var fontFamily = "SkyscannerRelativeiOS"
    public var regularFontFace = "SkyscannerRelativeiOS-Book"
    public var semiboldFontFace = "SkyscannerRelativeiOS-Bold"
    public var heavyFontFace = "SkyscannerRelativeiOS-Black"
    
    public init() {}
}

extension UIFont {
    static func regular(size: CGFloat) -> UIFont {
        return .customOrDefault(
            BPKFont.fontDefinition?.regularFontFace,
            size: size,
            weight: .regular
        )
    }
    
    static func semibold(size: CGFloat) -> UIFont {
        return .customOrDefault(
            BPKFont.fontDefinition?.semiboldFontFace,
            size: size,
            weight: .semibold
        )
    }
    
    static func heavy(size: CGFloat) -> UIFont {
        return .customOrDefault(
            BPKFont.fontDefinition?.heavyFontFace,
            size: size,
            weight: .heavy
        )
    }
}

public extension Text {
    func font(style: BPKFontStyle) -> some View {
        let font = style.font
        return self.font(Font(font))
            .tracking(style.letterSpacing)
            .lineSpacing(style.lineHeight - font.lineHeight)
    }
}
