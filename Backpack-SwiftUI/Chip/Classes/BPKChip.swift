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

public struct BPKChip: View {
    let text: String
    let icon: BPKIcon?
    let style: BPKChipStyle
    let selected: Bool
    let config: BPKConfigSet?
    let onClick: () -> Void
    
    private var disabled = false
    
    public init(
        _ text: String,
        icon: BPKIcon? = nil,
        configOverride: BPKConfigSet? = nil,
        selected: Bool = false,
        style: BPKChipStyle = .default,
        onClick: @escaping () -> Void
    ) {
        self.text = text
        self.icon = icon
        self.style = style
        self.selected = selected
        self.onClick = onClick
        self.config = BPKConfigSet.setFor(.bpkChip, override: configOverride)
    }
    
    public var body: some View {
        Button(action: onClick) {
            HStack(spacing: .md) {
                if let icon {
                    BPKIconView(icon)
                }
                Text(text)
                    .font(style: .footnote)
            }
            .padding(.horizontal, .base)
            .padding(.vertical, config.spacing(for: "vertical_space", BPKSpacing.none.value))
        }
        .buttonStyle(
            ChipButtonStyle(
                style: style,
                selected: selected,
                disabled: disabled,
                config: config
            )
        )
        .accessibilityAddTraits(selected ? [.isSelected] : [])
        .disabled(disabled)
        .if(!BPKFont.enableDynamicType, transform: {
            $0.sizeCategory(.large)
        })
    }
    
    public func disabled(_ disabled: Bool) -> BPKChip {
        var chip = self
        chip.disabled = disabled
        return chip
    }
}

struct BPKChip_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKChip("Option", icon: .accessibility) {}
            HStack {
                BPKChip("Option") {}
                BPKChip("Option", selected: true) {}
                BPKChip("Option") {}
                    .disabled(true)
            }
            HStack {
                BPKChip("Option", style: .onDark) {}
                BPKChip("Option", selected: true, style: .onDark) {}
                BPKChip("Option", style: .onDark) {}
                    .disabled(true)
            }
            .padding()
            .background(.surfaceContrastColor)
            HStack {
                BPKChip("Option", style: .onImage) {}
                BPKChip("Option", selected: true, style: .onImage) {}
                BPKChip("Option", style: .onImage) {}
                    .disabled(true)
            }
            .padding()
            .background(.statusSuccessSpotColor)
        }
    }
}
