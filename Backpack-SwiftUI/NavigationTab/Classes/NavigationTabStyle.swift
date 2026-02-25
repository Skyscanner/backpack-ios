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

struct NavigationTabStyle: ButtonStyle {
    let style: BPKNavigationTabGroup.Style
    let selected: Bool
    let itemAlignment: BPKNavigationTabGroup.ItemAlignment

    init(
        style: BPKNavigationTabGroup.Style,
        selected: Bool,
        itemAlignment: BPKNavigationTabGroup.ItemAlignment = .horizontal
    ) {
        self.style = style
        self.selected = selected
        self.itemAlignment = itemAlignment
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minHeight: minHeight)
            .fixedSize(horizontal: true, vertical: false)
            .background(backgroundColor(configuration.isPressed))
            .foregroundColor(foregroundColor(configuration.isPressed))
            .outline(showOutline ? outlineColor(configuration.isPressed) : .clear, cornerRadius: cornerRadius)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .if(!BPKFont.enableDynamicType, transform: {
                $0.sizeCategory(.large)
            })
    }

    private var minHeight: BPKSpacing {
        itemAlignment == .vertical ? .xxl : .xl
    }

    private var cornerRadius: BPKCornerRadius {
        // Vertical uses pill shape (larger radius), horizontal uses standard lg
        itemAlignment == .vertical ? .lg : .sm
    }

    private var showOutline: Bool {
        itemAlignment == .horizontal
    }
    
    private func outlineColor(_ isPressed: Bool) -> BPKColor {
        switch style {
        case .`default`:
            if selected || isPressed {
                return .coreAccentColor
            }

            return .lineColor
        case .onDark, .onDarkAlternate:
            if selected {
                return .coreAccentColor
            } else if isPressed {
                return .chipOnDarkPressedStrokeColor
            } else {
                return .lineOnDarkColor
            }
        }
    }
    
    private func backgroundColor(_ isPressed: Bool) -> BPKColor {
        guard selected else { return .clear }
        switch style {
        case .default, .onDark:
            return .coreAccentColor
        case .onDarkAlternate:
            return .segmentedControlSurfaceContrastOnColor
        }
    }
    
    private func foregroundColor(_ isPressed: Bool) -> BPKColor {
        if selected {
            return .textOnDarkColor
        } else if isPressed {
            return style == .default ? .buttonLinkPressedForegroundColor : .buttonLinkOnDarkPressedForegroundColor
        } else {
            return style == .default ? .textPrimaryColor : .textOnDarkColor
        }
    }
}
