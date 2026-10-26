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
import Backpack_Common

/// A view that displays one line of text with an optional icon
/// By default the style of BPKBadge is set to `.normal`
///
/// Use `badgeStyle(_ style: BPKBadge.Style)` to change the style of the badge
///
/// Use `interactive(_ interactive: Bool = true)` to show a fixed trailing information
/// icon that signals the badge can be tapped for more information. This glyph is not a
/// configurable `BPKIcon` and is not part of Backpack's public icon set - it exists only
/// to give interactive badges a consistent affordance across the system. BPKBadge remains
/// purely presentational

public struct BPKBadge: View {
    private static let interactiveIcon = BPKIcon(name: "information-circle-outline")
    private static let interactiveIconDimension: CGFloat = 12

    private let text: String
    private let icon: BPKIcon?
    private var style: BPKBadge.Style = .normal
    private var isInteractive = false

    public init(_ text: String, icon: BPKIcon? = nil) {
        self.text = text
        self.icon = icon
    }
    
    public var body: some View {
        content
            .padding(.leading, style.horizontalPadding())
            .padding(.trailing, .md)
            .padding([.top, .bottom], .sm)
            .frame(minHeight: 24)
            .background(style.backgroundColor())
            .clipShape(RoundedRectangle(cornerRadius: .xs))
            .outline(style.borderColor(), cornerRadius: .xs)
            .accessibilityElement()
            .accessibilityLabel(text)
            .if(!BPKFont.enableDynamicType, transform: {
                $0.sizeCategory(.large)
            })
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

    /// Shows a fixed trailing information glyph/icon to signal that the badge can be tapped
    /// for more information.
    ///
    /// BPKBadge does not handle taps itself. If you want the badge to be tappable, wrap it
    /// in your own `Button` or `.onTapGesture` to drive navigation
    ///
    /// - Parameter interactive: Whether to show the trailing information glyph.
    ///   Defaults to `true`.
    ///
    /// - Returns: A BPKBadge configured as interactive.
    public func interactive(_ interactive: Bool = true) -> BPKBadge {
        var result = self
        result.isInteractive = interactive
        return result
    }
    
    private func createBadgeIconView(icon: BPKIcon?) -> BPKIconView? {
        guard let badgeIcon = icon else {
            switch style {
            case .success:
                return BPKIconView(BPKIcon.tickCircle, size: .small)
            case .warning:
                return BPKIconView(BPKIcon.informationCircle, size: .small)
            case .destructive:
                return BPKIconView(BPKIcon.exclamation, size: .small)
            default:
                return nil
            }
        }
        return BPKIconView(badgeIcon, size: .small)
    }

    private var interactiveIconView: BPKIconView? {
        guard isInteractive else { return nil }
        return BPKIconView(Self.interactiveIcon, size: .small)
            .overrideDimension(Self.interactiveIconDimension)
    }
    
    private var content: some View {
        HStack(spacing: .sm) {
            if let badgeIconView = createBadgeIconView(icon: icon) {
                badgeIconView.foregroundColor(style.iconColor())
            }
            BPKText(text, style: .footnote)
                .foregroundColor(style.foregroundColor())
            if let interactiveIconView {
                interactiveIconView.foregroundColor(style.iconColor())
            }
        }
    }
}

struct BPKBadge_Previews: PreviewProvider {
    static var previews: some View {
        let styles: [(BPKBadge.Style, String, BPKIcon, Bool)] = [
            (.normal, "Normal", .tickCircle, false),
            (.strong, "Strong", .tickCircle, false),
            (.success, "Success", .tickCircle, false),
            (.warning, "Warning", .informationCircle, false),
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
                    BPKBadge("Interactive", icon: .tickCircle)
                        .badgeStyle(.success)
                        .interactive()
                        .padding(10)
                }
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(scheme)
            }
        }
    }
}
