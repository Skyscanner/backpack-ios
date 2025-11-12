/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd. All rights reserved.
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

import Backpack_SwiftUI
import SwiftUI

struct ConfigurationCardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                BPKCard() {
                    content(title: "Default")
                }
                BPKCard(elevation: .focus) {
                    content(title: "Focused")
                }
                BPKCard(padding: .none) {
                    content(title: "Not padded")
                }
                BPKCard(cornerStyle: .large) {
                    content(title: "Large Corner")
                }
            }
            .padding()
            .background(.surfaceContrastColor)

            VStack(spacing: 40) {
                BPKCard(cardStyle: .onDefault) {
                    content(title: "On Default")
                }
            }
            .padding()
            .background(.surfaceDefaultColor)
        }
        .previewLayout(.sizeThatFits)
        .onDisappear {
            BpkConfiguration.shared.reset()
        }
    }

    private func content(title: String) -> some View {
        VStack {
            BPKText(title, style: .heading3)
            BPKText(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                style: .bodyDefault
            ).lineLimit(2)
        }
    }
}
