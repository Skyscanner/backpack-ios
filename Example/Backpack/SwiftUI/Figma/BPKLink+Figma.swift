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

/// Figma Code Connect implementation for BPKLink
struct BPKLinkFigmaConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKLink.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10885-9743"

    @FigmaEnum(
        "Style",
        mapping: [
            "Default": .default,
            "On contrast": .onContrast
        ]
    )
    var style: BPKLinkStyle = .default

    @FigmaString("Text")
    var text: String = "This is a [link](https://www.skyscanner.net)"

    var body: some View {
        BPKLink(
            markdown: text,
            style: style,
            fontStyle: .bodyDefault
        )
    }
}
