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

public enum BPKOverlayType {
    case solidLow, solidMedium, solidHigh
    
    case topLow, topMedium, topHigh
    
    case bottomLow, bottomMedium, bottomHigh
    
    case leftLow, leftMedium, leftHigh
    
    case rightLow, rightMedium, rightHigh
    
    case vignette
}

extension BPKOverlayType {
    var value: CALayer {
        switch self {
        case .solidLow:
            return GradientOverlay(type: .solid, level: .low)
        case .solidMedium:
            return GradientOverlay(type: .solid, level: .medium)
        case .solidHigh:
            return GradientOverlay(type: .solid, level: .high)
        case .topLow:
            return GradientOverlay(type: .top, level: .low)
        case .topMedium:
            return GradientOverlay(type: .top, level: .medium)
        case .topHigh:
            return GradientOverlay(type: .top, level: .high)
        case .bottomLow:
            return GradientOverlay(type: .bottom, level: .low)
        case .bottomMedium:
            return GradientOverlay(type: .bottom, level: .high)
        case .bottomHigh:
            return GradientOverlay(type: .bottom, level: .high)
        case .leftLow:
            return GradientOverlay(type: .left, level: .low)
        case .leftMedium:
            return GradientOverlay(type: .left, level: .medium)
        case .leftHigh:
            return GradientOverlay(type: .left, level: .high)
        case .rightLow:
            return GradientOverlay(type: .right, level: .low)
        case .rightMedium:
            return GradientOverlay(type: .right, level: .medium)
        case .rightHigh:
            return GradientOverlay(type: .right, level: .high)
        case .vignette:
            return VignetteOverlay()
        }
    }
}
