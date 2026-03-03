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
import Backpack_SwiftUI

struct SwapExampleView: View {
    @State private var swapCount = 0

    var body: some View {
        ScrollView {
            VStack(spacing: .xl) {
                // Canvas Default style
                VStack(alignment: .leading, spacing: .md) {
                    BPKText("Canvas Default", style: .heading5)
                    BPKText("Use on canvas default (white) backgrounds", style: .caption)
                        .foregroundColor(.textSecondaryColor)

                    HStack {
                        Spacer()
                        BPKSwap(
                            style: .canvasDefault,
                            accessibilityLabel: "Swap items"
                        ) {
                            swapCount += 1
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(.canvasColor)
                .cornerRadius(BPKSpacing.md.value)

                // Canvas Contrast style
                VStack(alignment: .leading, spacing: .md) {
                    BPKText("Canvas Contrast", style: .heading5)
                    BPKText("Use on canvas contrast (gray) backgrounds", style: .caption)
                        .foregroundColor(.textSecondaryColor)

                    HStack {
                        Spacer()
                        BPKSwap(
                            style: .canvasContrast,
                            accessibilityLabel: "Swap items"
                        ) {
                            swapCount += 1
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(.canvasContrastColor)
                .cornerRadius(BPKSpacing.md.value)

                // Surface Contrast style
                VStack(alignment: .leading, spacing: .md) {
                    BPKText("Surface Contrast", style: .heading5)
                        .foregroundColor(.textOnDarkColor)
                    BPKText("Use on surface contrast (dark) backgrounds", style: .caption)
                        .foregroundColor(.textOnDarkColor)

                    HStack {
                        Spacer()
                        BPKSwap(
                            style: .surfaceContrast,
                            accessibilityLabel: "Swap items"
                        ) {
                            swapCount += 1
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(.surfaceContrastColor)
                .cornerRadius(BPKSpacing.md.value)

                // Swap counter
                BPKText("Tap count: \(swapCount)", style: .bodyDefault)
                    .foregroundColor(.textSecondaryColor)
            }
            .padding()
        }
    }
}

struct SwapExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SwapExampleView()
    }
}
