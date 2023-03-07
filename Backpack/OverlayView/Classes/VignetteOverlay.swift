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

class VignetteOverlay: BPKOverlay {
    
    private let vignetteLayer: CAShapeLayer = {
        let shadowLayer = CAShapeLayer()
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowOpacity = 0.12
        shadowLayer.shadowRadius = 50
        shadowLayer.fillRule = .evenOdd
        return shadowLayer
    }()
    
    func getLayer() -> CALayer {
        return vignetteLayer
    }
    
    func updateBounds(withParentBounds bounds: CGRect) {
        let shadowPath = CGMutablePath()
        let inset = vignetteLayer.shadowRadius
        shadowPath.addRect(bounds.insetBy(dx: inset, dy: inset))
        shadowPath.addRect(bounds)
        vignetteLayer.shadowPath = shadowPath
    }
    
    var baseColor: UIColor {
        return BPKColor.textOnLightColor
    }
    
    private func setupLayer() {
        vignetteLayer.shadowColor = baseColor.cgColor
    }
}
