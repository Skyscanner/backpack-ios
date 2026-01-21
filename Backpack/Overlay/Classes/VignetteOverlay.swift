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

import UIKit
import QuartzCore
#if SWIFT_PACKAGE
import BackpackTokens
#endif

final class VignetteOverlay: CAShapeLayer {
    override init() {
        super.init()
        initShadow()
    }
    
    override public init(layer: Any) {
        super.init(layer: layer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initShadow()
    }
    
    override public var shadowOffset: CGSize {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public var shadowOpacity: Float {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public var shadowRadius: CGFloat {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public var shadowColor: CGColor? {
        didSet {
            setNeedsLayout()
        }
    }
    
    private func initShadow() {
        masksToBounds = true
        shouldRasterize = true
        
        fillRule = CAShapeLayerFillRule.evenOdd
        borderColor = BPKColor.clear.cgColor
        shadowOffset = CGSize.zero
        shadowColor = BPKColor.textOnLightColor.cgColor
        shadowOpacity = 0.12
        shadowRadius = 50
    }
    
    override public func layoutSublayers() {
        super.layoutSublayers()
        generateShadowPath()
    }
    
    private func generateShadowPath() {
        let top = shadowRadius - shadowOffset.height
        let bottom = shadowRadius + shadowOffset.height
        let left = shadowRadius - shadowOffset.width
        let right = shadowRadius + shadowOffset.width
        let shadowRect = CGRect(
            x: bounds.origin.x - left,
            y: bounds.origin.y - top,
            width: bounds.width + left + right,
            height: bounds.height + top + bottom
        )
        
        let path = CGMutablePath()
        let delta: CGFloat = 1
        let rect = CGRect(
            x: bounds.origin.x - delta,
            y: bounds.origin.y - delta,
            width: bounds.width + delta * 2,
            height: bounds.height + delta * 2
        )
        
        let bezier: UIBezierPath = {
            if cornerRadius > 0 {
                return UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            } else {
                return UIBezierPath(rect: rect)
            }
        }()
        path.addPath(bezier.cgPath)
        path.addRect(shadowRect)
        path.closeSubpath()
        self.path = path
    }
}
