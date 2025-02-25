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

extension BPKPoiMapMarker {
    public enum State {
        case unselected
        case selected
        
        var backgroundColor: BPKColor {
            switch self {
            case .unselected:
                return .mapPoiPinColor
            case .selected:
                return .corePrimaryColor
            }
        }
        
        var markerSize: CGSize {
            switch self {
            case .unselected: return CGSize(width: 20, height: BPKSpacing.lg.value)
            case .selected: return CGSize(width: BPKSpacing.lg.value, height: 29)
            }
        }
        
        var topPadding: CGFloat {
            switch self {
            case .unselected: return 2
            case .selected: return BPKSpacing.sm.value
            }
        }
    }
}
