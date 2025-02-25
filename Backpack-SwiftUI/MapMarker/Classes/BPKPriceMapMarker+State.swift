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

extension BPKPriceMapMarker {
    public enum State {
        case selected
        case unselected
        case previousSelected
        
        var foregroundColor: BPKColor {
            switch self {
            case .selected:
                return .textOnDarkColor
            case .unselected:
                return .textPrimaryColor
            case .previousSelected:
                return .textOnLightColor
            }
        }
        
        var backgroundColor: BPKColor {
            switch self {
            case .selected:
                return .corePrimaryColor
            case .unselected:
                return .surfaceDefaultColor
            case .previousSelected:
                return .mapPreviousSelectionColor
            }
        }
    }
}
