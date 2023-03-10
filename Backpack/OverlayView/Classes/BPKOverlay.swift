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

public class BPKOverlay: UIView {

    private let content: UIView
    private let overlay: Overlay
    private let foregroundContent: UIView?
    
    public init(overlayType: BPKOverlayType = .solidLow, content: UIView, foregroundContent: UIView? = nil) {
        self.overlay = overlayType.value
        self.content = content
        self.foregroundContent = foregroundContent
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
        
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not available")
    }
    
    @available(*, unavailable)
    override init(frame: CGRect) {
        fatalError("init(frame:) is not available")
    }
    
    private func setupViews() {
        addSubview(content)
        content.layer.addSublayer(overlay.getLayer())
        
        if let foregroundContent = foregroundContent {
            addSubview(foregroundContent)
        }
    }
    
    private func setupConstraints() {
        content.translatesAutoresizingMaskIntoConstraints = false
        foregroundContent?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: leadingAnchor),
            content.topAnchor.constraint(equalTo: topAnchor),
            content.trailingAnchor.constraint(equalTo: trailingAnchor),
            content.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
//        setNeedsLayout()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        overlay.updateBounds(withParentBounds: self.bounds)
    }
}
