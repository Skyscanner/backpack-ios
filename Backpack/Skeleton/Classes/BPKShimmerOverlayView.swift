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

class BPKShimmerOverlayView: UIView {
    
    private lazy var shimmer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        let duration = 1.0
        let delay = 0.2

        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.masksToBounds = true
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "locations")
        gradientChangeAnimation.beginTime = CACurrentMediaTime() + delay
        gradientChangeAnimation.duration = duration
        gradientChangeAnimation.fillMode = .removed
        gradientChangeAnimation.fromValue = [-0.6, -0.3, 0]
        gradientChangeAnimation.toValue = [1.0, 1.3, 1.6]
        gradientChangeAnimation.repeatCount = .infinity
        gradientChangeAnimation.autoreverses = false
        
        gradientLayer.add(gradientChangeAnimation, forKey: "shimmer")
        
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(shimmer)
        setShimmerColors()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            setShimmerColors()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shimmer.frame = self.frame
    }
    
    private func setShimmerColors() {
        let transparent = BPKColor.skeletonShimmerStartEndColor.cgColor
        let midColor = BPKColor.skeletonShimmerCenterColor.cgColor
        shimmer.colors = [transparent, midColor, transparent]
    }
}
