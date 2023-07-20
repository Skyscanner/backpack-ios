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

extension BPKSelect {
    
    /// The state of the Selector.
    public enum State {
        /// The default state.
        case `default`
        /// Disables the selector.
        case disabled
        /// Changes the border color to error.
        case error
        
        var borderColor: BPKColor {
            switch self {
            case .disabled: return .surfaceHighlightColor
            case .error: return .statusDangerSpotColor
            case .`default`: return .lineColor
            }
        }
        
        var isDisabled: Bool {
            self == .disabled
        }
        
        var textColor: BPKColor {
            self == .disabled ? .textDisabledColor : .textPrimaryColor
        }
    }
}
