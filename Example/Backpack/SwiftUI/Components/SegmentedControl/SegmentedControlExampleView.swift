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

import SwiftUI
import Backpack_SwiftUI

struct SegmentedControlExampleView: View {
    @State var selectedIndex = 0
    private let accessibilityLabel = "bpk_segmented_control_example"
    private let items: [String] = ["1", "2", "3"]

    @State private var favoriteColor = 0

    var body: some View {
        VStack {
            BPKSegmentedControl(
                items: items,
                selectedIndex: $selectedIndex,
                accessibilityLabel: accessibilityLabel,
                style: .defaultStyle
            )

            BPKSegmentedControl(
                items: items,
                selectedIndex: $selectedIndex,
                accessibilityLabel: accessibilityLabel,
                style: .init(
                    bgColor: .black, textColor: .white, selectedBgColor: .white, selectedTextColor: .black
                    )
            )

            VStack {
                Picker("What is your favorite color?", selection: $favoriteColor) {
                    Text("Red").tag(0)
                    Text("Green").tag(1)
                    Text("Blue").tag(2)
                }
                .pickerStyle(.segmented)

                Text("Value: \(favoriteColor)")
            }
        }
    }
}

#Preview {
    SegmentedControlExampleView()
}
