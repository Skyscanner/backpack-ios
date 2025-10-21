/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd
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

public enum BPKLinkStyle {
    case `default`
    case onContrast

    var textColor: Color {
        switch self {
        case .default:
            return Color(BPKColor.textPrimaryColor)
        case .onContrast:
            return Color(BPKColor.textOnDarkColor)
        }
    }

    var linkColor: Color {
        switch self {
        case .default:
            return Color(BPKColor.buttonLinkNormalForegroundColor)
        case .onContrast:
            return Color(BPKColor.buttonLinkOnDarkNormalForegroundColor)
        }
    }
}

/// Inline rich text that can contain multiple links. Links are styled and routed as:
/// http/https → system, anything else → onCustomLink(URL)
public struct BPKLink: View {
    private let styled: AttributedString
    private let onCustomLink: (URL) -> Void
    private let fontStyle: BPKFontStyle

    public init(
        markdown: String,
        style: BPKLinkStyle = .default,
        fontStyle: BPKFontStyle = .bodyDefault,
        textColor: BPKColor? = nil,
        onCustomLink: @escaping (URL) -> Void = { _ in }
    ) {
        self.onCustomLink = onCustomLink
        self.fontStyle = fontStyle

        let parsedMarkdown = try? AttributedString(markdown: markdown)
        var attributed = parsedMarkdown ?? AttributedString(markdown)
        if let textColor {
            attributed.foregroundColor = Color(textColor)
        } else {
            attributed.foregroundColor = style.textColor
        }

        for run in attributed.runs {
            guard run.link != nil else { continue }
            attributed[run.range].foregroundColor = style.linkColor
            attributed[run.range].underlineStyle = Text.LineStyle(pattern: .solid)
            attributed[run.range].baselineOffset = 0
        }

        styled = attributed
    }

    public var body: some View {
        BPKText(styled, style: fontStyle, preservesForegroundColors: true)
            .lineLimit(nil)
            .environment(\.openURL, openURLAction)
            .accessibilityHint("Double tap to activate link")
    }

    private var openURLAction: OpenURLAction {
        OpenURLAction { url in
            if let scheme = url.scheme?.lowercased(), scheme == "http" || scheme == "https" {
                return .systemAction
            }

            onCustomLink(url)
            return .handled
        }
    }
}
