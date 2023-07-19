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

public struct BPKSelectState {
    
    /// The state of the text field.
    public enum State {
        /// The default state.
        case `default`
        /// Disables the text field.
        case disabled
        /// Adds a clear button to the text field. The action is called when the button is tapped.
        case clear(accessibilityLabel: String, action: () -> Void)
        /// Adds a valid icon to the text field.
        case valid
        /// Adds an error icon to the text field and changes the border color to error.
        case error
        
        var borderColor: BPKColor {
            switch self {
            case .disabled: return .surfaceHighlightColor
            case .error: return .statusDangerSpotColor
            default: return .lineColor
            }
        }
        
        var isDisabled: Bool {
            switch self {
            case .disabled: return true
            default: return false
            }
        }
        
        var textColor: BPKColor {
            switch self {
            case .disabled: return .textDisabledColor
            default: return .textPrimaryColor
            }
        }
        
        var icon: BPKTextField.Icon? {
            switch self {
            case .clear: return BPKTextField.Icon(icon: .closeCircle, color: .textSecondaryColor)
            case .valid: return BPKTextField.Icon(icon: .tickCircle, color: .statusSuccessSpotColor)
            case .error: return BPKTextField.Icon(icon: .exclamationCircle, color: .statusDangerSpotColor)
            default: return nil
            }
        }
    }
}

extension BPKTextField {
    
    
}
