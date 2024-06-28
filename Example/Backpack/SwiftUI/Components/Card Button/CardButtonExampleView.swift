//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
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
import Backpack_SwiftUI

struct CardButtonExampleView: View {
    var body: some View {
        HStack(spacing: .base) {
            makeColumn(style: .default)
            makeColumn(style: .contained)
            makeColumn(style: .onDark)
        }
        .background(.canvasColor)
    }
    
    private func makeColumn(style: Backpack_SwiftUI.BPKCardButtonStyle) -> some View {
        VStack {
            BPKText(style.previewTitle)
            VStack(spacing: .base) {
                shareButtonGroup(style: style)
                saveButtonGroup(style: style)
            }
            .padding()
            .background(style.previewBackgroudColor)
        }
    }
    
    @ViewBuilder
    private func shareButtonGroup(style: Backpack_SwiftUI.BPKCardButtonStyle) -> some View {
        BPKShareCardButton(
            size: .small,
            style: style,
            accessibilityLabel: "share",
            action: { }
        )
        BPKShareCardButton(
            size: .default,
            style: style,
            accessibilityLabel: "share",
            action: { }
        )
    }
    
    @ViewBuilder
    private func saveButtonGroup(style: Backpack_SwiftUI.BPKCardButtonStyle) -> some View {
        BPKSaveCardButtonInteractiveDemo(
            size: .small,
            style: style,
            checked: false
        )
        BPKSaveCardButtonInteractiveDemo(
            size: .default,
            style: style,
            checked: false
        )
        
        BPKSaveCardButtonInteractiveDemo(
            size: .small,
            style: style,
            checked: true
        )
        BPKSaveCardButtonInteractiveDemo(
            size: .default,
            style: style,
            checked: true
        )
    }
}

private extension Backpack_SwiftUI.BPKCardButtonStyle {
    var previewTitle: String {
        switch self {
        case .default:
            return "default"
        case .contained:
            return "contained"
        case .onDark:
            return "onDark"
        }
    }
    
    var previewBackgroudColor: Backpack_SwiftUI.BPKColor {
        switch self {
        case .default:
            return .surfaceDefaultColor
        case .contained:
            return .surfaceHighlightColor
        case .onDark:
            return .black
        }
    }
}

private struct BPKSaveCardButtonInteractiveDemo: View {
    let size: Backpack_SwiftUI.BPKCardButtonSize
    let style: Backpack_SwiftUI.BPKCardButtonStyle
    @State var checked: Bool
    
    var body: some View {
        BPKSaveCardButton(
            size: size,
            style: style,
            checked: checked,
            accessibilityLabel: checked ? "remove from saved" : "save",
            action: {
                checked.toggle()
            }
        )
    }
}

struct CardButtonExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CardButtonExampleView()
    }
}
