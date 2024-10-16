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

struct DynamicStackExampleView: View {
    @State private var isHorizontal = true
    @State var choices = ["Extra Small", "Small", "Medium", "Large", "Extra Large", "Extra Extra Large", "Extra Extra Extra Large", "Accessibility 1", "Accessibility 2", "Accessibility 3", "Accessibility 4", "Accessibility 5"]
    @State var selectedMagnificationSize: String = "Medium"

    private func getScreenMagnification(for size: String) -> ContentSizeCategory {
        switch size {
        case "Extra Small":
            return .extraSmall
        case "Small":
            return .small
        case "Medium":
            return .medium
        case "Large":
            return .large
        case "Extra Large":
            return .extraLarge
        case "Extra Extra Large":
            return .extraExtraLarge
        case "Extra Extra Extra Large":
            return .extraExtraExtraLarge
        case "Accessibility 1":
            return .accessibilityMedium
        case "Accessibility 2":
            return .accessibilityLarge
        case "Accessibility 3":
            return .accessibilityExtraLarge
        case "Accessibility 4":
            return .accessibilityExtraExtraLarge
        case "Accessibility 5":
            return .accessibilityExtraExtraExtraLarge
        default:
            return .medium
        }
    }

    var body: some View {
        VStack(spacing: .md) {
            BPKSelect(
                placeholder: "Select Magnification size",
                options: choices,
                selectedIndex: Binding(
                    get: {
                        choices.firstIndex(of: selectedMagnificationSize) ?? 1
                    },
                    set: { index in
                        if let index = index {
                            selectedMagnificationSize = choices[index]
                        }
                    }
                )
            )
            .padding()

            BPKDynamicStack(
                horizontalAlignment: .leading,
                verticalAlignment: .center,
                spacing: .md
            ) {
                BPKText("First text", style: .heading1)
                BPKText("Middle text", style: .heading4)
                BPKText("Last text", style: .heading5)
            }
            .padding()
        }
    }
}

#Preview {
    DynamicStackExampleView()
}
