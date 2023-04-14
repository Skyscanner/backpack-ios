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

struct ChipButtonStyle: ButtonStyle {
    let style: BPKChipStyle
    let selected: Bool
    let disabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, 7)
            .fixedSize(horizontal: true, vertical: false)
            .background(backgroundColor(configuration.isPressed))
            .foregroundColor(foregroundColor(configuration.isPressed))
            .clipShape(RoundedRectangle(cornerRadius: .sm))
            .outline(outlineColor(configuration.isPressed), cornerRadius: .sm)
            .if(style == .onImage) { $0.shadow(.sm) }
    }
    
    private func outlineColor(_ isPressed: Bool) -> BPKColor {
        if disabled {
            return .buttonDisabledBackgroundColor
        }
        switch style {
        case .`default`:
            return isPressed ? .corePrimaryColor : selected ? .corePrimaryColor : .lineColor
        case .onDark:
            return isPressed ? .chipOnDarkPressedStrokeColor : selected ? .surfaceDefaultColor : .lineOnDarkColor
        case .onImage:
            return isPressed ? .canvasContrastColor : selected ? .corePrimaryColor : .surfaceDefaultColor
        }
    }
    
    private func backgroundColor(_ isPressed: Bool) -> BPKColor {
        if disabled {
            return .chipDisabledBackgroundColor
        }
        switch style {
        case .`default`:
            return isPressed ? .clear : selected ? .corePrimaryColor : .clear
        case .onDark:
            return isPressed ? .clear : selected ? .chipOnDarkOnBackgroundColor : .clear
        case .onImage:
            return isPressed ? .canvasContrastColor : selected ? .corePrimaryColor : .surfaceDefaultColor
        }
    }
    
    private func foregroundColor(_ isPressed: Bool) -> BPKColor {
        if disabled {
            return .textDisabledColor
        }
        switch style {
        case .`default`:
            return isPressed ? .textPrimaryColor : selected ? .textOnDarkColor : .textPrimaryColor
        case .onDark:
            return isPressed ? .textOnDarkColor : selected ? .textPrimaryColor : .textOnDarkColor
        case .onImage:
            return isPressed ? .textPrimaryColor : selected ? .textOnDarkColor : .textPrimaryColor
        }
    }
}
