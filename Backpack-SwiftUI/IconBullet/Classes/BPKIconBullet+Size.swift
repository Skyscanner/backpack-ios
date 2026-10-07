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

internal extension BPKIconBullet.Size {

    var padding: BPKSpacing {
        switch self {
        case .small:
            return .sm
        case .medium, .large:
            return .md
        }
    }
    
    /// The `BPKIcon` asset to render. There is no dedicated 8pt icon asset,
    /// so `.small` reuses the 16pt `.small` asset and relies on `iconScale`
    /// to render it down to its 8pt visible size.
    var iconSize: BPKIcon.Size {
        switch self {
        case .small:
            return .small
        case .medium:
            return .small
        case .large:
            return .large
        }
    }

    /// Additional scale applied on top of the `BPKIconView`'s native
    /// rendered size, used to shrink the 16pt `.small` icon asset down to
    /// the 8pt visible size required for `.small` icon bullets.
    var iconScale: CGFloat {
        switch self {
        case .small:
            return 0.5
        case .medium, .large:
            return 1
        }
    }
}
