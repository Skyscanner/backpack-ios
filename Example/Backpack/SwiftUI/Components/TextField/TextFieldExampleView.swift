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
    @State var text = "Value"
    @State var validationFieldText = ""
    
    var body: some View {
        ScrollView {
            VStack {
                BPKTextField(.constant(""))
                BPKTextField(placeholder: "Placeholder", .constant(""))
                BPKTextField($text)
                BPKTextField($text)
                    .inputState(.disabled)
                BPKTextField($text)
                    .inputState(text.isEmpty ? .default : .clear(accessibilityLabel: "Clear Field") { text = "" })
                BPKTextField($text)
                    .inputState(.valid)
                BPKTextField($text)
                    .inputState(.error)
                BPKTextField(placeholder: "At least 6 characters", $validationFieldText)
                    .inputState(validateState())
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
