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
    private let items: [String] = ["1", "2", "3", "4"]
    private let longerItems: [String] = ["Item 1", "Item 2", "Very long item 3", "Item 4"]

    var body: some View {
        VStack(spacing: 10) {
            Text("Default style")

            BPKSegmentedControl(
                items: longerItems,
                selectedIndex: $selectedIndex,
                accessibilityLabel: accessibilityLabel,
                style: .defaultStyle
            )
            
            Text("Custom style")
            BPKSegmentedControl(
                items: items,
                selectedIndex: $selectedIndex,
                accessibilityLabel: accessibilityLabel,
                style: .init(
                    bgColor: .surfaceContrastColor,
                    textColor: .textOnDarkColor,
                    selectedBgColor: .textOnDarkColor,
                    selectedTextColor: .surfaceContrastColor
                    )
            )

            Text("Selected index: \(selectedIndex)")
        }
    }
}

#Preview {
    SegmentedControlExampleView()
}
