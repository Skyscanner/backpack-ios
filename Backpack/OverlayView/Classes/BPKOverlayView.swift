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

public class BPKOverlayView: UIView {
    public enum OverlayType {
        case solid, top, bottom, left, right, vignette
    }
    
    public enum OverlayLevel {
        case off, low, medium, high
    }
        
    private var overlay: BPKOverlay
    private var backgroundView: UIView?
    
    public init(withType type: OverlayType, andLevel level: OverlayLevel) {
        if type == .vignette {
            self.overlay = VignetteOverlay()
        } else {
            self.overlay = GradientOverlay(type: type, overlayLevel: level)
        }
        
        super.init(frame: .zero)
        
        layer.addSublayer(overlay.getLayer())
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
        overlay.updateBounds(withParentBounds: self.bounds)
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
}
