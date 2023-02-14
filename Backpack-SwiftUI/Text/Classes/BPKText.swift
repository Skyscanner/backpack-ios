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

extension Text {
    func font(style: BPKFontStyle) -> some View {
        let font = style.font
        return self.font(Font(font))
            .tracking(style.letterSpacing)
            .lineSpacing(style.lineHeight - font.lineHeight)
    }
}

/// A view that displays one or more lines of text
/// By default the color of BPKText is set to `BPKColor.textPrimary` with a lineLimit of 1
///
/// Use `foregroundColor(_ color: BPKColor)` to change the color of the text
/// Use `limeLimit(_ number: Int?)` to set the number of lines can be displayed. Pass in `nil` for unlimited lines
///
public struct BPKText: View {
    private var text: String
    private var style: BPKFontStyle
    
    private var textColor = Color(BPKColor.textPrimaryColor)
    private var lineLimit: Int? = 1
    private var strikethrough: Bool = false
    
    public init(_ text: String, style: BPKFontStyle = .bodyDefault) {
        self.text = text
        self.style = style
    }
    
    public var body: some View {
        Text(text)
            .strikethrough(strikethrough)
            .font(style: style)
            .foregroundColor(textColor)
            .lineLimit(lineLimit)
    }
    
    /// Sets the color of the text.
    ///
    /// - Parameter color: The foreground `BPKColor` to use when displaying this
    ///   view.
    ///
    /// - Returns: A BPKText that uses the foreground color you supply.
    public func foregroundColor(_ color: BPKColor) -> BPKText {
        var view = self
        view.textColor = Color(color)
        return view
    }
    
    /// Sets the maximum number of lines that text can occupy in the BPKText.
    /// - Parameter number: The line limit. If `nil`, no line limit applies.
    ///
    /// - Returns: A BPKText that limits the number of lines that this ``BPKText``
    ///   instance displays.
    public func lineLimit(_ number: Int?) -> BPKText {
        var view = self
        view.lineLimit = number
        return view
    }
    
    /// Sets the strikethrough of the text.
    /// - Parameter active: When true a line will be added in the middle of the text.
    /// - Returns: A BPKText that has a line through the text if active is true.
    public func strikethrough(_ active: Bool) -> BPKText {
        var view = self
        view.strikethrough = active
        return view
    }
}

struct BPKText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKText("Hello world!")
                .foregroundColor(.skyBlue)
            BPKText("Hello world!", style: .heading1)
        }
    }
}
