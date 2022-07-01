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

internal extension BPKSpinner.Style {
    var foregroundColor: BPKColor {
        switch self {
        case .textPrimary:
            return .textPrimaryColor
        case .disabled:
            return .skyGrayTint04
        case .onDarkSurface:
            return .white
        }
    }
}

internal extension BPKSpinner.Size {
    var width: BPKSpacing {
        switch self {
        case .sm:
            return BPKSpacing.base
        case .lg:
            return BPKSpacing.lg
        case .xl:
            return BPKSpacing.xl
        }
    }
    
    var height: BPKSpacing {
        return width
    }
    
    var capsuleHeight: CGFloat {
        return 2
    }
    
    var capsuleWidth: CGFloat {
        switch self {
        case .sm:
            return 4
        case .lg:
            return 6
        case .xl:
            return 8
        }
    }
}
