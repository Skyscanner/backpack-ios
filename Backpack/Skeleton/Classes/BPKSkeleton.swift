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
import SwiftUI

public class BPKSkeleton: UIView {
    static internal var bgColor: UIColor =
        BPKColor.dynamicColor(withLightVariant: BPKColor.skyGrayTint06, darkVariant: BPKColor.blackTint02)
    static fileprivate var overlayColor: UIColor =
        BPKColor.dynamicColor(withLightVariant: BPKColor.skyGrayTint06, darkVariant: BPKColor.blackTint02)
    
    public var type: BPKSkeletonType = .image {
        didSet {
            updateType()
        }
    }
    
    public var size: BPKSkeletonSize = .default {
        didSet {
            updateSize()
        }
    }
    
    public var style: BPKSkeletonStyle = .default {
        didSet {
            updateStyle()
        }
    }
    
    private var skeletonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var shimmerOverlay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        let transperant = overlayColor.withAlphaComponent(0)
//        let midColor = overlayColor.withAlphaComponent(0.6)
//        let gradientLayer = CAGradientLayer()
//
//        gradientLayer.colors = [transperant, midColor, transperant]
//        gradientLayer.locations = [0, 0.5, 1]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//        view.layer.insertSublayer(gradientLayer, at: 0)
        view.backgroundColor = .blue
        return view
    }()
    
    public convenience init(type: BPKSkeletonType) {
        self.init()
        self.type = type
        updateType()
        setup()
    }
    
    /**
     * Create a `BPKSkeleton` with a given frame.
     *
     * @param frame The initial frame of the chip.
     * @return `BPKSkeleton` instance.
     */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    /**
     * Creates a `BPKSkeleton` with a decoder (typically when creating from Storyboards)
     *
     * @param aDecoder Decoder object to extract parameters from
     * @return `BPKSkeleton` instance.
     */
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func updateType() {
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        switch self.type {
        case .image:
            self.skeletonView = BPKImageSkeleton()
        case .headline:
            self.skeletonView = BPKHeadlineSkeleton()
        case .circle:
            self.skeletonView = BPKCircleSkeleton()
        case .bodytext:
            self.skeletonView = BPKTextSkeleton()
        case .shimmeroverlay:
            self.skeletonView = BPKImageSkeleton()
        }
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    internal func setup() {
        addSubview(skeletonView)
        skeletonView.addSubview(shimmerOverlay)
        NSLayoutConstraint.activate([
            skeletonView.centerXAnchor.constraint(equalTo: centerXAnchor),
            skeletonView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            shimmerOverlay.leadingAnchor.constraint(equalTo: skeletonView.leadingAnchor, constant: -BPKSpacingXl),
            shimmerOverlay.topAnchor.constraint(equalTo: skeletonView.topAnchor),
            shimmerOverlay.heightAnchor.constraint(equalTo: skeletonView.heightAnchor),
            shimmerOverlay.widthAnchor.constraint(equalToConstant: BPKSpacingXl)
        ])

        setupSubviews()
        startShimmer()
    }
    
    internal func updateSize() {
    }
    
    internal func updateStyle() {
    }
    
    internal func setupSubviews() {
    }
    
    private func startShimmer() {
        UIView.animate(withDuration: 1, delay: 0.2, options: .repeat) {
            self.shimmerOverlay.transform = self.shimmerOverlay.transform.translatedBy(x: 100+BPKSpacingXl, y: 0)
        } completion: {_ in
            self.shimmerOverlay.transform = self.shimmerOverlay.transform.translatedBy(x: -(100+BPKSpacingXl*2), y: 0)
            self.startShimmer()
        }

    }
}
