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
        case .success:
            return BPKColor.statusSuccessFillColor
        case .warning:
            return BPKColor.statusWarningFillColor
        case .destructive:
            return BPKColor.statusDangerFillColor
        case .inverse:
            return BPKColor.surfaceDefaultColor
        case .outline:
            return BPKColor.white.withAlphaComponent(0)
        case .normal:
            return BPKColor.surfaceHighlightColor
        case .strong:
            return BPKColor.corePrimaryColor
        }
    }
    
    var foregroundColor: BPKColor {
        switch self {
        case .success, .warning, .destructive:
            return BPKColor.textOnLightColor
        case .outline, .strong:
            return BPKColor.textOnDarkColor
        case .normal, .inverse:
            return BPKColor.textPrimaryColor
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
}
