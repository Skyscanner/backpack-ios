/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

/// This button is for internal use only and used in the BottomSheet and AppSearchModal
/// Anywhere where there is a need for a close button, this should be used in our code.
struct BPKCloseButton: View {
    var accessibilityLabel: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            BPKIconView(.close, size: .large)
        }
        .foregroundColor(.textPrimaryColor)
        .contentShape(Rectangle())
        .accessibilityLabel(accessibilityLabel)
    }
}

struct BPKCloseButton_Previews: PreviewProvider {
    static var previews: some View {
        BPKCloseButton(accessibilityLabel: "Close", action: { print("Tap close") })
    }
}
