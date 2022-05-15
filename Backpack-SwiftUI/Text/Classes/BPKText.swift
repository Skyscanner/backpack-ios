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
    func font(style: BPKFontStyle) -> some View {
        let font = style.font
        return self.font(Font(font))
            .tracking(style.letterSpacing)
            .lineSpacing(style.lineHeight - font.lineHeight)
    }
}

public struct BPKText: View {
    private var text: String
    private var style: BPKFontStyle
    
    
    private var textColor = Color(BPKColor.textPrimaryColor)
    private var lineLimit: Int? = 1
    
    public init(_ text: String, style: BPKFontStyle = .bodyDefault) {
        self.text = text
        self.style = style
    }
    
    public var body: some View {
        Text(text)
            .font(style: style)
            .foregroundColor(textColor)
            .lineLimit(lineLimit)
    }
    
    public func foregroundColor(_ color: BPKColor) -> BPKText {
        var view = self
        view.textColor = Color(color)
        return view
    }
    
    public func lineLimit(_ number: Int?) -> BPKText {
        var view = self
        view.lineLimit = number
        return view
    }
}

struct BPKText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKText("Hello world!")
                .foregroundColor(.skyBlue)
                .lineLimit(1)
            BPKText("Hello world!", style: .heading1)
        }
    }
}
