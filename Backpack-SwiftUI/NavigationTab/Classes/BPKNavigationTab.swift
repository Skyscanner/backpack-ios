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

struct BPKNavigationTab: View {

    let text: String
    let icon: BPKIcon?
    let selected: Bool
    let style: BPKNavigationTabGroup.Style
    let itemAlignment: BPKNavigationTabGroup.ItemAlignment
    let onClick: () -> Void

    init(
        _ text: String,
        icon: BPKIcon? = nil,
        selected: Bool = false,
        style: BPKNavigationTabGroup.Style = .default,
        itemAlignment: BPKNavigationTabGroup.ItemAlignment = .horizontal,
        onClick: @escaping () -> Void
    ) {
        self.text = text
        self.icon = icon
        self.selected = selected
        self.style = style
        self.itemAlignment = itemAlignment
        self.onClick = onClick
    }

    var body: some View {
        Button(action: onClick) {
            content
        }
        .buttonStyle(
            NavigationTabStyle(
                style: style,
                selected: selected,
                itemAlignment: itemAlignment
            )
        )
        .accessibilityAddTraits(selected ? [.isSelected] : [])
        .if(!BPKFont.enableDynamicType, transform: {
            $0.sizeCategory(.large)
        })
    }

    @ViewBuilder
    private var content: some View {
        switch itemAlignment {
        case .horizontal:
            HStack(spacing: .md) {
                if let icon {
                    BPKIconView(icon)
                }
                Text(text)
                    .font(BPKFontStyle.label2.font)
                    .lineLimit(1)
            }
            .padding(.horizontal, .base)
        case .vertical:
            VStack(spacing: .md) {
                if let icon {
                    BPKIconView(icon)
                }
                Text(text)
                    .font(BPKFontStyle.label3.font)
                    .lineLimit(1)
            }
            .padding(.horizontal, .base)
            .padding(.vertical, .md)
        }
    }
}

struct BPKNavigationTab_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .lg) {
            // Horizontal alignment (default)
            VStack(alignment: .leading) {
                BPKText("Horizontal (default)", style: .caption)
                HStack {
                    BPKNavigationTab("Explore", icon: .explore, selected: true) {}
                    BPKNavigationTab("Flights", icon: .flight) {}
                }
            }

            // Horizontal on dark
            VStack(alignment: .leading) {
                BPKText("Horizontal on dark", style: .caption)
                    .foregroundColor(.textOnDarkColor)
                HStack {
                    BPKNavigationTab("Explore", icon: .explore, selected: true, style: .onDark) {}
                    BPKNavigationTab("Flights", icon: .flight, style: .onDark) {}
                }
            }
            .padding()
            .background(.surfaceContrastColor)

            // Vertical alignment
            VStack(alignment: .leading) {
                BPKText("Vertical", style: .caption)
                HStack {
                    BPKNavigationTab("Explore", icon: .explore, selected: true, itemAlignment: .vertical) {}
                    BPKNavigationTab("Flights", icon: .flight, itemAlignment: .vertical) {}
                }
            }

            // Vertical on dark
            VStack(alignment: .leading) {
                BPKText("Vertical on dark", style: .caption)
                    .foregroundColor(.textOnDarkColor)
                HStack {
                    BPKNavigationTab("Explore", icon: .explore, selected: true, style: .onDark, itemAlignment: .vertical) {}
                    BPKNavigationTab("Flights", icon: .flight, style: .onDark, itemAlignment: .vertical) {}
                }
            }
            .padding()
            .background(.surfaceContrastColor)
        }
        .padding()
    }
}
