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
    var image: CGSize {
        switch self {
        case .custom(let customSize):
            return customSize;
        default:
            return CGSize(width: 96, height: 96)
        }
        
    }
    
    var circle: CGSize {
        switch self {
        case .custom(let customSize):
            return customSize;
        case .small:
            return CGSize(width: BPKSpacing.xl.value, height: BPKSpacing.xl.value)
        default:
            return CGSize(width: 48, height: 48)
        }
    }
    
    var headline: CGSize {
        switch self {
        case .custom(let customSize):
            return customSize;
        case .small:
            return CGSize(width: 80, height: BPKSpacing.md.value)
        case .large:
            return CGSize(width: 80, height: BPKSpacing.xl.value)
        default:
            return CGSize(width: 80, height: BPKSpacing.base.value)
        }
    }
    
    var bodytext: CGSize {
        switch self {
        case .custom(let customSize):
            return customSize;
        default:
            return CGSize(width: 200, height: 44)
        }
    }
}
