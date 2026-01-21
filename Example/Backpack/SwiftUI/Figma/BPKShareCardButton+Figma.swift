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
import Figma
import Backpack_SwiftUI

/// Figma Code Connect implementation for BPKShareCardButton
struct BPKShareCardButtonFigmaConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKShareCardButton.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10858-50721"

    @FigmaEnum(
        "Size",
        mapping: [
            "Default": .default,
            "Small": .small
        ]
    )
    var size: Backpack_SwiftUI.BPKCardButtonSize = .default

    @FigmaEnum(
        "Style",
        mapping: [
            "Default": .default,
            "Contained": .contained,
            "On dark": .onDark
        ]
    )
    var style: Backpack_SwiftUI.BPKCardButtonStyle = .default

    var body: some View {
        BPKShareCardButton(
            size: size,
            style: style,
            accessibilityLabel: "Share",
            action: {}
        )
    }
}
