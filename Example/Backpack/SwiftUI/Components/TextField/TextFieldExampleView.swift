//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

struct TextFieldExampleView: View {
    @State var text1 = ""
    @State var text2 = "Value"
    @State var validationFieldText = ""
    
    var body: some View {
        ScrollView {
            VStack {
                BPKTextField($text2)
                BPKTextField(placeholder: "Placeholder", $text2)
                BPKTextField($text1)
                BPKTextField($text1)
                    .inputState(.disabled)
                BPKTextField($text1)
                    .inputState(text1.isEmpty ? .default : .clear(accessibilityLabel: "Clear Field") { text1 = "" })
                BPKTextField($text1)
                    .inputState(.valid)
                BPKTextField($text1)
                    .inputState(.error)
                BPKTextField(placeholder: "At least 6 characters", $validationFieldText)
                    .inputState(validateState())
                BPKTextField(prefixState: .text("To"), $text2)
                BPKTextField(prefixState: .text("From"), $text2)
                BPKTextField(prefixState: .searchIcon, $text2)
            }
            .padding()
        }
    }
    
    private func validateState() -> Backpack_SwiftUI.BPKTextField.State {
        switch validationFieldText.count {
        case 0: return .default
        case 1...5: return .error
        default: return .valid
        }
    }
}

struct TextFieldExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldExampleView()
    }
}
