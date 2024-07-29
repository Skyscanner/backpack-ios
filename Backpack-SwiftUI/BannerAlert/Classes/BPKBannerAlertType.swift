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

extension BPKBannerAlert {
    /// The type of the banner, which controls the default icon to display and its color.
    public enum AlertType {
        case info(accessibilityLabel: String? = nil)
        case success(accessibilityLabel: String? = nil)
        case warning(accessibilityLabel: String? = nil)
        case error(accessibilityLabel: String? = nil)
        
        var iconDetails: IconDetails {
            switch self {
            case .info(let accessibilityLabel):
                return IconDetails(
                    icon: .informationCircle,
                    color: .textSecondaryColor,
                    accessibilityLabel: accessibilityLabel
                )
            case .success(let accessibilityLabel):
                return IconDetails(
                    icon: .tickCircle,
                    color: .statusSuccessSpotColor,
                    accessibilityLabel: accessibilityLabel
                )
            case .warning(let accessibilityLabel):
                return IconDetails(
                    icon: .informationCircle,
                    color: .statusWarningSpotColor,
                    accessibilityLabel: accessibilityLabel
                )
            case .error(let accessibilityLabel):
                return IconDetails(
                    icon: .closeCircle,
                    color: .statusDangerSpotColor,
                    accessibilityLabel: accessibilityLabel
                )
            }
        }
    }
}

extension BPKBannerAlert {
    struct IconDetails {
        let icon: BPKIcon
        let color: BPKColor
        let accessibilityLabel: String?
    }
}
