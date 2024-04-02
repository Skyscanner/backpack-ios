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

struct BPKNavigationTab: View {
    
    let text: String
    let icon: BPKIcon?
    let selected: Bool
    let style: BPKNavigationTabGroup.Style
    let onClick: () -> Void
    
    init(
        _ text: String,
        icon: BPKIcon? = nil,
        selected: Bool = false,
        style: BPKNavigationTabGroup.Style = .default,
        onClick: @escaping () -> Void
    ) {
        self.text = text
        self.icon = icon
        self.selected = selected
        self.style = style
        self.onClick = onClick
    }
    
    var body: some View {
        
        Button(action: onClick) {
            HStack(spacing: .md) {
                if let icon {
                    BPKIconView(icon)
                }
                Text(text)
                    .font(style: .footnote)
            }
            .padding(.horizontal, .base)
        }
        .buttonStyle(
            NavigationTabStyle(
                style: style,
                selected: selected
            )
        )
        .accessibilityAddTraits(selected ? [.isSelected] : [])
        .if(!BPKFont.enableDynamicType, transform: {
            $0.sizeCategory(.large)
        })
    }
}

struct BPKNavigationTab_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                BPKNavigationTab("Explore", icon: .explore, selected: true) {}
                BPKNavigationTab("Flights", icon: .flight) {}
            }
            HStack {
                BPKNavigationTab("Explore", icon: .explore, selected: true, style: .onDark) {}
                BPKNavigationTab("Flights", icon: .flight, style: .onDark) {}
            }
            .padding()
            .background(.surfaceContrastColor)
        }
    }
}
