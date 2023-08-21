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

public struct BPKDropdownChip: View {
    let text: String
    let icon: BPKIcon?
    let style: BPKChipStyle
    let selected: Bool
    let onClick: () -> Void
    
    private var disabled = false
    
    public init(
        _ text: String,
        icon: BPKIcon? = nil,
        selected: Bool = false,
        style: BPKChipStyle = .default,
        onClick: @escaping () -> Void
    ) {
        self.text = text
        self.icon = icon
        self.selected = selected
        self.style = style
        self.onClick = onClick
    }
    
    public var body: some View {
        Button(action: onClick) {
            HStack(spacing: .md) {
                if let icon {
                    BPKIconView(icon)
                }
                Text(text)
                    .font(style: .footnote)
                BPKIconView(.chevronDown)
            }
            .padding(.trailing, .md)
            .padding(.leading, .base)
        }
        .buttonStyle(
            ChipButtonStyle(
                style: style,
                selected: selected,
                disabled: disabled
            )
        )
        .accessibilityAddTraits(selected ? [.isSelected] : [])
        .disabled(disabled)
        .if(!BPKFont.enableDynamicType, transform: {
            $0.sizeCategory(.large)
        })
    }
    
    public func disabled(_ disabled: Bool) -> BPKDropdownChip {
        var chip = self
        chip.disabled = disabled
        return chip
    }
}

struct BPKDropdownChip_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKDropdownChip("Dropdown", icon: .account) {}
            HStack {
                BPKDropdownChip("Dropdown") {}
                BPKDropdownChip("Dropdown", selected: true) {}
                BPKDropdownChip("Dropdown") {}
                    .disabled(true)
            }
            HStack {
                BPKDropdownChip("Dropdown", style: .onDark) {}
                BPKDropdownChip("Dropdown", selected: true, style: .onDark) {}
                BPKDropdownChip("Dropdown", style: .onDark) {}
                    .disabled(true)
            }
            .padding()
            .background(.surfaceContrastColor)
            HStack {
                BPKDropdownChip("Dropdown", style: .onImage) {}
                BPKDropdownChip("Dropdown", selected: true, style: .onImage) {}
                BPKDropdownChip("Dropdown", style: .onImage) {}
                    .disabled(true)
            }
            .padding()
            .background(.statusSuccessSpotColor)
        }
    }
}
