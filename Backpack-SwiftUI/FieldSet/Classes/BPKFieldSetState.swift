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

extension BPKFieldSet {
    /// The state of the text area.
    public enum State {
        case `default`
        case error(message: String)
        
        var labelColor: BPKColor {
            switch self {
            case .default: return .textPrimaryColor
            case .error: return .textErrorColor
            }
        }
        
        var descriptionColor: BPKColor {
            switch self {
            case .default: return .textSecondaryColor
            case .error: return .textSecondaryColor
            }
        }
    }
}
