//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2026 Skyscanner Ltd. All rights reserved.
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

struct CheckboxExampleView: View {
    @State private var regular = true
    @State private var unchecked = false
    @State private var error = false
    @State private var intermediate = true
    @State private var disabled = false

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                BPKCheckbox("Regular", checked: $regular)
                BPKCheckbox("Unchecked", checked: $unchecked)
                BPKCheckbox("Error", checked: $error, status: .error)
                BPKCheckbox("Intermediate", checked: $intermediate, status: .intermediate)
                BPKCheckbox("Disabled", checked: $disabled).disabled(true)
            }

            VStack(alignment: .leading, spacing: 10) {
                BPKCheckbox("Regular", checked: $regular, style: .onContrast)
                BPKCheckbox("Unchecked", checked: $unchecked, style: .onContrast)
                BPKCheckbox("Error", checked: $error, style: .onContrast, status: .error)
                BPKCheckbox("Intermediate", checked: $intermediate, style: .onContrast, status: .intermediate)
                BPKCheckbox("Disabled", checked: $disabled, style: .onContrast).disabled(true)
            }
            .padding()
            .background(Color(.surfaceContrastColor))
        }
    }
}

#Preview {
    CheckboxExampleView()
}
