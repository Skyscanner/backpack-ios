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

public class BPKOverlay: UIView {
    
    public enum OverlayType {
        case solid, top, bottom, left, right
    }
    
    public enum OverlayLevel {
        case off, low, medium, high
    }
    
    public var type: OverlayType {
        didSet {
            updateLookAndFeel()
        }
    }
    
    public var level: OverlayLevel {
        didSet {
            updateLookAndFeel()
        }
    }
    
    private let tintLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.masksToBounds = true
        return gradientLayer
    }()
    
    private var backgroundView: UIView?
    
    public init(withType type: OverlayType, andLevel level: OverlayLevel) {
        self.type = type
        self.level = level
        super.init(frame: .zero)
        
        layer.addSublayer(tintLayer)
        updateLookAndFeel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not available")
    }
    
    @available(*, unavailable)
    override init(frame: CGRect) {
        fatalError("init(frame:) is not available")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.tintLayer.frame = self.bounds
    }
        
    public func setBackground(view: UIImageView?) {
        if let backgroundView = self.backgroundView {
            backgroundView.removeFromSuperview()
        }
        
        self.backgroundView = view
        
        guard let backgroundView = self.backgroundView else {
            return
        }
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(backgroundView, at: 0)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setNeedsLayout()
    }
    
    private func updateLookAndFeel() {
        tintLayer.colors = colors
        tintLayer.locations = [0, 1]
        tintLayer.startPoint = startPoint
        tintLayer.endPoint = endPoint
    }
}

// MARK: Overlay customization
private extension BPKOverlay {
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
    
    var baseColor: UIColor {
        return BPKColor.textOnLightColor
    }
    
    var colors: [CGColor] {
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
    
    var startPoint: CGPoint {
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
        }
    }
    
    var endPoint: CGPoint {
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
        }
    }
}
