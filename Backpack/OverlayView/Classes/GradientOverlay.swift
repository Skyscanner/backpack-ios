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

import CoreGraphics

class GradientOverlay: BPKOverlay {
    
    private let type: BPKOverlayView.OverlayType
    private let level: BPKOverlayView.OverlayLevel
    
    private let tintLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.masksToBounds = true
        
        return gradientLayer
    }()
    
    init(type: BPKOverlayView.OverlayType, overlayLevel level: BPKOverlayView.OverlayLevel) {
        self.type = type
        self.level = level

        setupLayer()
    }
    
    func getLayer() -> CALayer {
        return tintLayer
    }
    
    func updateBounds(withParentBounds bounds: CGRect) {
        tintLayer.frame = bounds
    }
    
    private func setupLayer() {
        guard let startPoint = startPoint, let endPoint = endPoint else {
            return
        }
        
        tintLayer.colors = colors
        tintLayer.locations = [0, 1]
        tintLayer.startPoint = startPoint
        tintLayer.endPoint = endPoint
    }
    
    private var colors: [CGColor] {
        switch type {
        case .solid:
            return [
                baseColor.withAlphaComponent(opacity).cgColor,
                baseColor.withAlphaComponent(opacity).cgColor
            ]
        default:
            return [
                baseColor.withAlphaComponent(opacity).cgColor,
                baseColor.withAlphaComponent(0).cgColor
            ]
        }
    }
}

fileprivate extension GradientOverlay {
    var startPoint: CGPoint? {
        switch type {
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
        default:
            return nil
        }
    }
    
    var endPoint: CGPoint? {
        switch type {
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
        default:
            return nil
        }
    }
    
    var opacity: CGFloat {
        switch (type, level) {
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
