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

    var body: some View {
        VStack(spacing: .md) {
            BPKSelect(
                placeholder: "Select Layout",
                options: ["Horizontal", "Vertical"],
                selectedIndex: Binding(
                    get: { isHorizontal ? 0 : 1 },
                    set: { isHorizontal = $0 == 0 }
                )
            )
            .padding()

            BPKDynamicStack(
                horizontalAlignment: .leading,
                verticalAlignment: .center,
                spacing: .md,
                threshold: isHorizontal ? .accessibility1 : .medium
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
