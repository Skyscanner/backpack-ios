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

internal extension BPKBadge.Style {
    var backgroundColor: BPKColor {
        switch self {
        case .success, .warning, .destructive, .normal:
            return BPKColor.badgeBackgroundNormalColor
        case .inverse:
            return BPKColor.surfaceDefaultColor
        case .outline:
            return BPKColor.clear
        case .strong:
            return BPKColor.corePrimaryColor
        case .brand:
            return BPKColor.coreAccentColor
        }
    }
    
    var foregroundColor: BPKColor {
        switch self {
        case .success, .warning, .destructive, .normal, .inverse:
            return BPKColor.textPrimaryColor
        case .outline, .strong:
            return BPKColor.textOnDarkColor
        case .brand:
            return BPKColor.textPrimaryInverseColor
        }
    }
    
    var borderColor: BPKColor? {
        switch self {
        case .outline:
            return BPKColor.textOnDarkColor
        default:
            return nil
        }
    }
    
    var iconColor: BPKColor {
        switch self {
        case .success:
            return BPKColor.statusSuccessSpotColor
        case .warning:
            return BPKColor.statusWarningSpotColor
        case .destructive:
            return BPKColor.statusDangerSpotColor
        case .normal, .strong, .inverse, .outline, .brand:
            return foregroundColor
        }
    }
}
