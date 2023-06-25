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

extension Font {
    static func customOrDefault(
        _ name: String?,
        size: CGFloat,
        weight: Weight,
        textStyle: TextStyle,
        fontProvider: (String, CGFloat, TextStyle) -> Font? = Font.custom(_:size:relativeTo:)
    ) -> Font {
        guard let name = name, let font = fontProvider(name, size, textStyle) else {
            return .system(size: size, weight: weight)
        }
        
        return font
    }
    
    static func regular(size: CGFloat, textStyle: TextStyle) -> Font {
        return customOrDefault(BPKFont.fontDefinition?.regularFontFace, size: size, weight: .regular, textStyle: textStyle)
    }
    
    static func semibold(size: CGFloat, textStyle: TextStyle) -> Font {
        return customOrDefault(BPKFont.fontDefinition?.semiboldFontFace, size: size, weight: .semibold, textStyle: textStyle)
    }
}
