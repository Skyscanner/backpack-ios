/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

/// A control that displays an editable text interface for search inputs.
public struct BPKSearchControlInput: View {
    
    private let label: String
    private let icon: BPKIcon
    
    /// Creates a `BPKSearchControlInput`.
    ///
    /// - Parameters:
    ///   - label: The t text to display when the text field is empty.
    ///   - icon: The prefix which would be displayed on the left of text input
    public init(
        label: String,
        icon: BPKIcon
    ) {
        self.label = label
        self.icon = icon
    }
    
    public var body: some View {
        HStack(spacing: .md) {
            BPKIconView(icon)
                .foregroundColor(.textSecondaryColor)
            BPKText(label, style: .bodyDefault)
                .foregroundColor(.textPrimaryColor)
        }
        .frame(maxWidth: .infinity, minHeight: 48.0)
        .padding(.horizontal, BPKSpacing.base)
        .background(.segmentedControlCanvasDefaultColor)
        .accessibilityLabel(label)
        .accessibilityIdentifier("search_control_input")
    }
}

struct BPKSearchControlInput_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKSearchControlInput(label: "Input", icon: .calendar)
        }
        .padding()
        .background(.coreEcoColor)
    }
}
