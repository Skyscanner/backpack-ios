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

import Backpack_Common

internal extension BPKBadge.Style {
    func backgroundColor(_ config: BpkConfiguration?) -> BPKColor {
        switch self {
        case .success, .warning, .destructive, .normal:
            return config?.badgeConfig == nil ? BPKColor.badgeBackgroundNormalColor : BPKColor.clear
        case .inverse:
            return BPKColor.surfaceDefaultColor
        case .outline:
            return BPKColor.clear
        case .strong:
            return BPKColor.corePrimaryColor
        case .brand:
            return BPKColor.coreAccentColor
        case .subtle:
            return BPKColor.badgeBackgroundNormalColor
        }
    }
    
    func foregroundColor(_ config: BpkConfiguration?) -> BPKColor {
        switch self {
        case .success, .warning, .destructive, .normal, .inverse, .subtle:
            return BPKColor.textPrimaryColor
        case .outline, .strong:
            return BPKColor.textOnDarkColor
        case .brand:
            return BPKColor.textPrimaryInverseColor
        }
    }
    
    func borderColor(_ config: BpkConfiguration?) -> BPKColor? {
        switch self {
        case .outline:
            return config?.badgeConfig == nil ? BPKColor.textOnDarkColor : BPKColor.clear
        default:
            return nil
        }
    }
    
    func iconColor(_ config: BpkConfiguration?) -> BPKColor {
        switch self {
        case .success:
            return BPKColor.statusSuccessSpotColor
        case .warning:
            return BPKColor.statusWarningSpotColor
        case .destructive:
            return BPKColor.statusDangerSpotColor
        case .normal, .strong, .inverse, .outline, .brand:
            return foregroundColor(config)
        case .subtle:
            return BPKColor.textPrimaryColor
        }
    }

    func horizontalPadding(_ config: BpkConfiguration?) -> BPKSpacing {
        switch self {
        case .strong, .brand, .inverse, .outline, .subtle:
            return .md
        default:
            return config?.badgeConfig == nil ? .md : .none
        }
    }
}
