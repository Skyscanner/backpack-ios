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
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                BPKCheckbox("Regular", selected: true, onTap: {})
                BPKCheckbox("Unchecked", onTap: {})
                BPKCheckbox("Error", status: .error, onTap: {})
                BPKCheckbox("Intermediate", selected: true, status: .intermediate, onTap: {})
                BPKCheckbox("Disabled", onTap: {}).disabled(true)
            }

            VStack(alignment: .leading, spacing: 10) {
                BPKCheckbox("Regular", selected: true, style: .onContrast, onTap: {})
                BPKCheckbox("Unchecked", style: .onContrast, onTap: {})
                BPKCheckbox("Error", style: .onContrast, status: .error, onTap: {})
                BPKCheckbox("Intermediate", selected: true, style: .onContrast, status: .intermediate, onTap: {})
                BPKCheckbox("Disabled", style: .onContrast, onTap: {}).disabled(true)
            }
            .padding()
            .background(Color(.surfaceContrastColor))
        }
    }
}

#Preview {
    CheckboxExampleView()
}
