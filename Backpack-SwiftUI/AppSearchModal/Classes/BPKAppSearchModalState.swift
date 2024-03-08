/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2023 Skyscanner Ltd
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

extension BPKAppSearchModal {
    /// The state of the text field.
    public enum TextFieldState {
        /// The default state.
        case `default`
        /// Adds a clear button to the text field. The action is called when the button is tapped.
        case clear(accessibilityLabel: String, action: () -> Void)
        
        var inputState: BPKTextField.State {
            switch self {
            case .default:
                return BPKTextField.State.default
            case .clear(let accessibilityLabel, let action):
                return BPKTextField.State.clear(accessibilityLabel: accessibilityLabel, action: action)
            }
        }
    }
}
