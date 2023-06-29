/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

fileprivate struct ScaledFont: ViewModifier {
    // This makes the font update when dynamic type changes
    @Environment(\.sizeCategory) var sizeCategory
    var style: BPKFontStyle
    
    func body(content: Content) -> some View {
        return content.font(style.scaledFont())
            .lineSpacing(style.lineHeight - style.lineHeight)
    }
}

fileprivate struct FixedFont: ViewModifier {
    var style: BPKFontStyle
    
    func body(content: Content) -> some View {
        return content.font(style.font())
            .lineSpacing(style.lineHeight - style.lineHeight)
    }
}

extension Text {
    func font(style: BPKFontStyle, fixed: Bool = false) -> some View {
        return self
            .tracking(style.letterSpacing)
            .if(fixed, transform: { item in
                item.modifier(FixedFont(style: style))
            })
            .if(!fixed, transform: { item in
                item.modifier(ScaledFont(style: style))
            })
    }
}

extension BPKFontStyle {
    func scaledFont() -> Font {
        let scaledValue = UIFontMetrics(forTextStyle: textStyle).scaledValue(for: size)
        return font(size: scaledValue)
    }
    
    func font() -> Font {
        return font(size: size)
    }
    
    private func font(size: CGFloat) -> Font {
        switch style {
        case .regular:
            return Font.regular(size: size)
        case .semibold:
            return Font.semibold(size: size)
        }
    }
}
