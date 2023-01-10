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

/// A view that displays one line of text with an optional icon
/// By default the style of BPKBadge is set to `.normal`
///
/// Use `badgeStyle(_ style: BPKBadge.Style)` to change the style of the badge
///
public struct BPKBadge: View {
    private let title: String
    private let icon: BPKIcon?
    private var style: BPKBadge.Style = .normal
    
    public init(_ title: String, icon: BPKIcon? = nil) {
        self.title = title
        self.icon = icon
    }
    
    public var body: some View {
        content
            .padding([.leading, .trailing], .md)
            .padding([.top, .bottom], .sm)
            .frame(height: 24)
            .background(style.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: .xs))
            .outline(style.borderColor, cornerRadius: .xs)
    }
    
    /// Sets the style of the badge
    ///
    /// - Parameter style: The `BPKBadge.Style` to change the appearance
    ///   view.
    ///
    /// - Returns: A BPKBadge that uses the style you supply.
    public func badgeStyle(_ style: BPKBadge.Style) -> BPKBadge {
        var result = self
        result.style = style
        return result
    }
    
    private var content: some View {
        HStack(spacing: BPKSpacing.sm.value) {
            if let icon = icon {
                BPKIconView(icon, size: .small)
                    .foregroundColor(style.foregroundColor)
            }
        
            BPKText(title, style: .caption)
                .foregroundColor(style.foregroundColor)
        }
    }
}

// Helper functions to apply the outline style
fileprivate struct Outline: ViewModifier {
    let color: BPKColor
    let cornerRadius: BPKCornerRadius
    
    func body(content: Content) -> some View {
        return content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(color))
            )
    }
}

fileprivate extension View {
    @ViewBuilder
    func outline(_ color: BPKColor?, cornerRadius: BPKCornerRadius) -> some View {
        if let color = color {
            ModifiedContent(
                content: self,
                modifier: Outline(color: color, cornerRadius: cornerRadius)
            )
        } else {
            self
        }
    }
}

struct BPKBadge_Previews: PreviewProvider {
    static var previews: some View {
        let styles: [(BPKBadge.Style, String, BPKIcon, Bool)] = [
            (.normal, "Normal", .tickCircle, false),
            (.strong, "Strong", .tickCircle, false),
            (.success, "Success", .tickCircle, false),
            (.warning, "Warning", .helpCircle, false),
            (.destructive, "Critical", .exclamation, false),
            (.inverse, "Inverse", .tickCircle, true),
            (.outline, "Outline", .tickCircle, true),
            (.brand, "Brand", .priceTag, false)
        ]
        return Group {
            ForEach([ColorScheme.light, ColorScheme.dark], id: \.self) { scheme in
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(styles, id: \.0) { style in
                        BPKBadge(style.1, icon: style.2)
                            .badgeStyle(style.0)
                            .padding(10)
                            .background(style.3 ? BPKColor.surfaceHighlightColor : BPKColor.surfaceDefaultColor)
                        
                    }
                    
                }
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(scheme)
            }
        }
    }
}
