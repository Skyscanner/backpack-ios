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

/// A control that displays an text and an icon.
public struct BPKSearchControlInput: View {
    
    private let label: String
    private let icon: BPKIcon
    private var isOnContrast: Bool
    
    /// Creates a `BPKSearchControlInput`.
    ///
    /// - Parameters:
    ///   - label: The displayed text.
    ///   - icon: The displayed icon.
    ///   - isOnContrast: Indicating whether the view is displayed on a contrasting background or not. Default is false.
    public init(
        label: String,
        icon: BPKIcon,
        isOnContrast: Bool = false
    ) {
        self.label = label
        self.icon = icon
        self.isOnContrast = isOnContrast
    }
    
    public var body: some View {
        HStack(spacing: .md) {
            BPKIconView(icon)
                .foregroundColor(.textSecondaryColor)
            BPKText(label)
                .foregroundColor(.textPrimaryColor)
        }
        .frame(minHeight: 48.0)
        .padding(.horizontal, BPKSpacing.base)
        .background(isOnContrast ? .surfaceDefaultColor : .canvasContrastColor)
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
