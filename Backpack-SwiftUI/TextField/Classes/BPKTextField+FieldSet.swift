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

extension BPKTextField: BPKFieldSetContentView {
    public func inputState(_ state: BPKFieldSet<BPKTextField>.State) -> BPKTextField {
        switch state {
        case .default:
            return inputState(BPKTextField.State.default)
        case .error:
            return inputState(BPKTextField.State.error)
        }
    }
}

#Preview {
    BPKFieldSet(label: "Label", description: "Description") {
        BPKTextField(placeholder: "Enter text", .constant(""))
    }
    .inputState(.error(message: "Error Message"))
    .padding()
}
