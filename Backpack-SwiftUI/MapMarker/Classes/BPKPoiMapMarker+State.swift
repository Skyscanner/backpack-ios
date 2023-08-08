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
        case `default`
        case focused
        case viewed
        
        var foregroundColor: BPKColor {
            switch self {
            case .default:
                return .surfaceDefaultColor
            case .viewed:
                return .coreEcoColor
            case .focused:
                return .statusSuccessSpotColor
            }
        }
        
        var backgroundColor: BPKColor {
            switch self {
            case .default:
                return .statusSuccessSpotColor
            case .viewed:
                return .statusSuccessFillColor
            case .focused:
                return .surfaceDefaultColor
            }
        }
        
        var markerSize: CGSize {
            switch self {
            case .focused: return CGSize(width: 32, height: 40)
            default: return CGSize(width: 26, height: 32)
            }
        }
        
        var topPadding: CGFloat {
            switch self {
            case .focused: return BPKSpacing.md.value
            default: return 6
            }
        }
    }
}
