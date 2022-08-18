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

internal extension BPKSkeleton.Size {
    var imageSize: CGSize {
        return CGSize(width: BPKSpacing.xl.value * 3, height: BPKSpacing.xl.value * 3)
    }
    
    var circleDiameter: CGSize {
        switch self {
        case .small:
            return CGSize(width: BPKSpacing.xl.value, height: BPKSpacing.xl.value)
        default:
            return CGSize(width: BPKSpacing.lg.value * 2, height: BPKSpacing.lg.value * 2)
        }
    }
    
    var headlineSize: CGSize {
        switch self {
        case .small:
            return CGSize(width: BPKSpacing.xxl.value * 2, height: BPKSpacing.md.value)
        case .large:
            return CGSize(width: BPKSpacing.xxl.value * 2, height: BPKSpacing.xl.value)
        default:
            return CGSize(width: BPKSpacing.xxl.value * 2, height: BPKSpacing.base.value)
        }
    }
    
    var bodytextSize: CGSize {
        return CGSize(width: BPKSpacing.xxl.value * 5, height: BPKSpacing.sm.value * 11)
    }
}
