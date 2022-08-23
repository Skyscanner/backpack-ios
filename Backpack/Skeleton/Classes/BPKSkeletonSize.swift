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

import Foundation
import UIKit

public enum BPKSkeletonSize: Equatable {
    case small, `default`, large, custom(size: CGSize)
}

internal extension BPKSkeletonSize {
    var image: CGSize {
        switch self {
        case .custom(let customSize):
            return customSize
        default:
            return CGSize(width: BPKSpacingXl * 3, height: BPKSpacingXl * 3)
        }
    }
    
    var circle: CGSize {
        switch self {
        case .custom(let customSize):
            let minLength = min(customSize.height, customSize.width)
            return CGSize(width: minLength, height: minLength)
        case .small:
            return CGSize(width: BPKSpacingXl, height: BPKSpacingXl)
        default:
            return CGSize(width: BPKSpacingLg * 2, height: BPKSpacingLg * 2)
        }
    }
    
    var headline: CGSize {
        switch self {
        case .custom(let customSize):
            return customSize
        case .small:
            return CGSize(width: BPKSpacingXxl * 2, height: BPKSpacingMd)
        case .`default`:
            return CGSize(width: BPKSpacingXxl * 2, height: BPKSpacingBase)
        case .large:
            return CGSize(width: BPKSpacingXxl * 2, height: BPKSpacingXl)
        }
    }
    
    var bodytext: CGSize {
        switch self {
        case .custom(let customSize):
            return customSize
        default:
            return CGSize(width: BPKSpacingXxl * 5, height: BPKSpacingMd * 3 + BPKSpacingSm * 5)
        }
    }
}
