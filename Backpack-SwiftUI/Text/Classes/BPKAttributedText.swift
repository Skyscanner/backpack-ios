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

fileprivate extension Text {
    /// This extension is specially made for the attributed text, so we can use the `+` operator
    /// on several Text views.
    /// We do not include the custom linespacing, as this will not make sense for
    /// a view that combines multiple different styles.
    func font(style: BPKFontStyle) -> Text {
        let font = style.font
        return self.font(Font(font))
            .tracking(style.letterSpacing)
    }
    
    func foregroundColor(_ color: BPKColor) -> Text {
        foregroundColor(Color(color.value))
    }
}

/// A view that displays a variety of Text items based on the styles and colors provided during creation
/// Set the `items` when creating this view.
public struct BPKAttributedText: View {
    public struct Item {
        let text: String
        let style: BPKFontStyle
        let color: BPKColor
        
        public init(_ text: String, style: BPKFontStyle = .bodyDefault, color: BPKColor = .textPrimaryColor) {
            self.text = text
            self.style = style
            self.color = color
        }
    }
    
    private let items: [Item]
    
    public init(items: [Item]) {
        self.items = items
    }
    
    public var body: some View {
        items.reduce(Text(""), {
            $0 + Text($1.text)
                .font(style: $1.style)
                .foregroundColor($1.color)
        })
    }
}

struct BPKAttributedText_Previews: PreviewProvider {
    static var previews: some View {
        BPKAttributedText(items: [])
    }
}
