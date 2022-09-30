//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

struct ColorExampleToken: Identifiable {
    let color: Backpack_SwiftUI.BPKColor
    let name: String
    
    // swiftlint:disable:next identifier_name
    let id = UUID()
}

struct ColorSection: Identifiable {
    let name: String
    let colors: [ColorExampleToken]
    
    // swiftlint:disable:next identifier_name
    let id = UUID()
}

struct ColorTokens {
    let tokens: [ColorSection]
    
    static var backpackTokens = ColorTokens(tokens: [
        .init(name: "Text", colors: [
            .init(color: .textPrimaryColor, name: ".textPrimaryColor"),
            .init(color: .textSecondaryColor, name: ".textSecondaryColor"),
            .init(color: .textDisabledColor, name: ".textDisabledColor"),
            .init(color: .textLinkColor, name: ".textLinkColor"),
            .init(color: .textErrorColor, name: ".textErrorColor"),
            .init(color: .textPrimaryInverseColor, name: ".textPrimaryInverseColor"),
            .init(color: .textOnDarkColor, name: ".textOnDarkColor"),
            .init(color: .textOnLightColor, name: ".textOnLightColor")
        ]),
        .init(name: "Core", colors: [
            .init(color: .corePrimaryColor, name: ".corePrimaryColor"),
            .init(color: .coreAccentColor, name: ".coreAccentColor"),
            .init(color: .coreEcoColor, name: ".coreEcoColor")
        ]),
        .init(name: "Status", colors: [
            .init(color: .statusSuccessSpotColor, name: ".statusSuccessSpotColor"),
            .init(color: .statusSuccessFillColor, name: ".statusSuccessFillColor"),
            .init(color: .statusWarningSpotColor, name: ".statusWarningSpotColor"),
            .init(color: .statusWarningFillColor, name: ".statusWarningFillColor"),
            .init(color: .statusDangerSpotColor, name: ".statusDangerSpotColor"),
            .init(color: .statusDangerFillColor, name: ".statusDangerFillColor")
        ]),
        .init(name: "Surface", colors: [
            .init(color: .surfaceDefaultColor, name: ".surfaceDefaultColor"),
            .init(color: .surfaceElevatedColor, name: ".surfaceElevatedColor"),
            .init(color: .surfaceContrastColor, name: ".surfaceContrastColor"),
            .init(color: .surfaceHighlightColor, name: ".surfaceHighlightColor")
        ]),
        .init(name: "Canvas", colors: [
            .init(color: .canvasColor, name: ".canvasColor"),
            .init(color: .canvasContrastColor, name: ".canvasContrastColor")
        ]),
        .init(name: "Other", colors: [
            .init(color: .lineColor, name: ".lineColor"),
            .init(color: .scrimColor, name: ".scrimColor")
        ])
    ])
}

struct ColorTokensView: View {
    var body: some View {
        ZStack {
            Color(BPKColor.canvasColor)
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(alignment: .leading, spacing: BPKSpacing.base.value) {
                    ForEach(ColorTokens.backpackTokens.tokens) { item in
                        BPKText(item.name, style: .heading3)
                        ForEach(item.colors) { color in
                            ColorChipView(color: color.color, name: color.name)
                        }
                    }
                }
                .padding([.leading, .trailing, .bottom], .lg)
            }
        }
    }
}

struct ColorTokensView_Previews: PreviewProvider {
    static var previews: some View {
        ColorTokensView()
    }
}
