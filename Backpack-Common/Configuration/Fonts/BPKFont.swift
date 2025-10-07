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
    public static var fontDefinition: BPKFontDefinitionProtocol?
    public static var enableDynamicType: Bool = false
    
    public static func setFontDefinition(_ fontDefinition: BPKFontDefinitionProtocol) {
        BPKFont.fontDefinition = fontDefinition
    }
    
    public static func setDynamicType(enabled: Bool) {
        BPKFont.enableDynamicType = enabled
    }
}

extension Font {
    public static func customOrDefault(
        _ name: String?,
        size: CGFloat,
        weight: Weight,
        textStyle: TextStyle,
        fontProvider: (String, CGFloat, TextStyle) -> Font = Font.custom(_:size:relativeTo:)
    ) -> Font {

        guard let name else {
            if weight == .semibold {
                return fontProvider("HelveticaNeue-Medium", size, textStyle)
            }
            
            if weight == .black {
                return fontProvider("HelveticaNeue-Bold", size, textStyle)
            }
            
            return fontProvider("HelveticaNeue", size, textStyle)
        }
            
        return fontProvider(name, size, textStyle)
    }
    
    public static func regular(size: CGFloat, textStyle: TextStyle) -> Font {
        let regularFontFace = BPKFont.fontDefinition?.regularFontFace as String?
        return customOrDefault(
            regularFontFace,
            size: size,
            weight: .regular,
            textStyle: textStyle
        )
    }
    
    public static func regularFixed(size: CGFloat) -> Font {
        let regularFontFace = BPKFont.fontDefinition?.regularFontFace as String?
        return customOrDefault(
            regularFontFace,
            size: size,
            weight: .regular,
            textStyle: .body) { name, size, _ in
                Font.custom(name, fixedSize: size)
        }
    }
    
    public static func semibold(size: CGFloat, textStyle: TextStyle) -> Font {
        let semiboldFontFace = BPKFont.fontDefinition?.semiboldFontFace as String?
        return customOrDefault(
            semiboldFontFace,
            size: size,
            weight: .semibold,
            textStyle: textStyle
        )
    }
    
    public static func semiboldFixed(size: CGFloat) -> Font {
        let semiboldFontFace = BPKFont.fontDefinition?.semiboldFontFace as String?
        return customOrDefault(
            semiboldFontFace,
            size: size,
            weight: .semibold,
            textStyle: .body) { name, size, _ in
                Font.custom(name, fixedSize: size)
        }
    }
    
    public static func black(size: CGFloat, textStyle: TextStyle) -> Font {
        let blackFontFace = BPKFont.fontDefinition?.blackFontFace as String?
        return customOrDefault(
            blackFontFace,
            size: size,
            weight: .black,
            textStyle: textStyle
        )
    }
    
    public static func blackFixed(size: CGFloat) -> Font {
        let blackFontFace = BPKFont.fontDefinition?.blackFontFace as String?
        return customOrDefault(
            blackFontFace,
            size: size,
            weight: .black,
            textStyle: .body) { name, size, _ in
                Font.custom(name, fixedSize: size)
        }
    }
}
