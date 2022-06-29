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
        case .normal:
            return .skyGrayTint07.darkVariant(.blackTint02)
        case .strong:
            return .skyGray.darkVariant(.white)
        case .success:
            return .glencoe
        case .warning:
            return .erfoud
        case .destructive:
            return .panjin
        case .inverse:
            return .white
        case .outline:
            return .clear
        }
    }
    
    var foregroundColor: BPKColor {
        switch self {
        case .normal:
            return .textPrimaryColor
        case .strong:
            return .white.darkVariant(.skyGray)
        case .destructive, .outline:
            return .white
        default:
            return .skyGray
        }
    }
    
    var borderColor: BPKColor? {
        switch self {
        case .outline:
            return .white
        default:
            return nil
        }
    }
}
