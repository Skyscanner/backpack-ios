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

import QuartzCore

final class GradientOverlay: CAGradientLayer {
    enum OverlayType {
        case solid, top, bottom, left, right
    }

    enum OverlayLevel {
        case off, low, medium, high
    }
    
    private let overlayType: OverlayType
    private let overlayLevel: OverlayLevel
    private let baseColor = BPKColor.textOnLightColor
    
    init(type: OverlayType, level: OverlayLevel) {
        self.overlayType = type
        self.overlayLevel = level
        
        super.init()

        initGradient()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initGradient() {
        masksToBounds = true
        shouldRasterize = true
        
        colors = gradientColors
        locations = [0, 1]
        startPoint = gradientStartPoint
        endPoint = gradientEndPoint
    }
}

fileprivate extension GradientOverlay {
    var gradientColors: [CGColor] {
        switch overlayType {
        case .solid:
            return [
                baseColor.withAlphaComponent(gradientOpacity).cgColor,
                baseColor.withAlphaComponent(gradientOpacity).cgColor
            ]
        default:
            return [
                baseColor.withAlphaComponent(gradientOpacity).cgColor,
                baseColor.withAlphaComponent(0).cgColor
            ]
        }
    }
    
    var gradientStartPoint: CGPoint {
        switch overlayType {
        case .solid:
            return CGPoint(x: 0, y: 0)
        case .top:
            return CGPoint(x: 0, y: 0)
        case .bottom:
            return CGPoint(x: 0, y: 1)
        case .left:
            return CGPoint(x: 0, y: 0)
        case .right:
            return CGPoint(x: 1, y: 0)
        }
    }
    
    var gradientEndPoint: CGPoint {
        switch overlayType {
        case .solid:
            return CGPoint(x: 1, y: 1)
        case .top:
            return CGPoint(x: 0, y: 1)
        case .bottom:
            return CGPoint(x: 0, y: 0)
        case .left:
            return CGPoint(x: 1, y: 0)
        case .right:
            return CGPoint(x: 0, y: 0)
        }
    }
    
    var gradientOpacity: CGFloat {
        switch (overlayType, overlayLevel) {
        case (_, .off):
            return 0
        case (_, .low):
            return 0.15
        case (_, .medium):
            return 0.30
        case (.solid, .high):
            return 0.4
        case (_, .high):
            return 0.45
        }
    }
}
