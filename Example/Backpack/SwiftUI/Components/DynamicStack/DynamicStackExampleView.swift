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
    @State var choices = ["Small", "Medium", "Large", "Extra Large"]
    @State var selectedTextSize: String = "Medium"

    private func fontStyle(for size: String) -> [Backpack_SwiftUI.BPKFontStyle] {
        switch size {
        case "Small":
            return [.heading3, .heading4, .heading5]
        case "Medium":
            return [.heading2, .heading4, .heading5]
        case "Large":
            return [.heading2, .heading3, .heading4]
        case "Extra Large":
            return [.heading1, .heading3, .heading4]
        default:
            return [.heading2, .heading4, .heading5]
        }
    }

    var dynamicStackTextSelect: BPKSelect {
        BPKSelect(
            placeholder: "Select Text Size",
            options: choices,
            selectedIndex: Binding(
                get: {
                    choices.firstIndex(of: selectedTextSize) ?? 1
                },
                set: { index in
                    if let index = index {
                        selectedTextSize = choices[index]
                    }
                }
            )
        )
    }

    var body: some View {
        dynamicStackTextSelect.padding()
        BPKDynamicStack {
            BPKText("First text", style: fontStyle(for: selectedTextSize)[0])
            BPKText("Middle text", style: fontStyle(for: selectedTextSize)[1])
            BPKText("Last text", style: fontStyle(for: selectedTextSize)[2])
        }.padding()
    }
}

#Preview {
    DynamicStackExampleView()
}
