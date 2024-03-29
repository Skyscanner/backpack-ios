/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

struct SectionHeaderExampleView: View {
    let style: BPKSectionHeader.Style

    var body: some View {
        ZStack {
            Color(BPKColor.surfaceHighlightColor)
            VStack(alignment: .leading, spacing: .base) {
                BPKSectionHeader(title: "Section title", style: style)
                .background(style == .default ? .canvasColor : .surfaceContrastColor)

                BPKSectionHeader(
                    title: "Section title",
                    description: "Description about this section",
                    style: style)
                .background(style == .default ? .canvasColor : .surfaceContrastColor)

                BPKSectionHeader(
                    title: "Section title",
                    description: "Description about this section",
                    style: style) {
                        BPKButton(icon: .addCircle, accessibilityLabel: "Add item") {
                            print("Tap add button")
                        }
                }
                .background(style == .default ? .canvasColor : .surfaceContrastColor)
            }
            .padding()
        }
    }
}
