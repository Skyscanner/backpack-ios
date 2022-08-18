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
    static internal var defaultColor: UIColor =
        BPKColor.dynamicColor(withLightVariant: BPKColor.white, darkVariant: BPKColor.black)
    private var customSize: CGSize = .zero
    
    public var type: BPKSkeletonType = .image {
        didSet {
            updateType()
        }
    }
    
    public var size: BPKSkeletonSize = .none
    
    public var style: BPKSkeletonStyle = .default {
        didSet {
            updateStyle()
        }
    }
    
    private var skeletonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    public convenience init(
        type: BPKSkeletonType,
        size: BPKSkeletonSize = .default,
        style: BPKSkeletonStyle = .default
    ) {
        self.init()
        self.type = type
        self.size = size
        self.style = style
//        self.viewSize = defaultSize
        updateType()
        setup()
    }
    
    public convenience init(
        type: BPKSkeletonType,
        size: CGSize,
        style: BPKSkeletonStyle = .default
    ) {
        self.init()
        self.type = type
        self.customSize = size
        self.style = style
        updateType()
        setup()
    }
    
    /**
     * Create a `BPKSkeleton` with a given frame.
     *
     * @param frame The initial frame of the Skeleton.
     * @return `BPKSkeleton` instance.
     */
    public override init(frame: CGRect) {
        super.init(frame: frame)
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
        switch self.type {
        case .bodytext:
            self.skeletonView = BPKTextSkeleton()
        default:
            self.skeletonView = BPKCommonSkeleton()
        }
    }
    
    internal func setup() {
        addSubview(skeletonView)
        if size == .none {
            NSLayoutConstraint.activate([
                skeletonView.leadingAnchor.constraint(equalTo: leadingAnchor),
                skeletonView.topAnchor.constraint(equalTo: topAnchor),
                skeletonView.trailingAnchor.constraint(equalTo: trailingAnchor),
                skeletonView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                skeletonView.widthAnchor.constraint(equalToConstant: customSize.width),
                skeletonView.heightAnchor.constraint(equalToConstant: customSize.height)
            ])
        } else {
            NSLayoutConstraint.activate([
                skeletonView.leadingAnchor.constraint(equalTo: leadingAnchor),
                skeletonView.topAnchor.constraint(equalTo: topAnchor),
                skeletonView.trailingAnchor.constraint(equalTo: trailingAnchor),
                skeletonView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                skeletonView.widthAnchor.constraint(equalToConstant: viewSize.width),
                skeletonView.heightAnchor.constraint(equalToConstant: viewSize.height)
            ])
        }
        updateStyle()
    }
    
    private func updateStyle() {
        if type == .image {
            skeletonView.layer.cornerRadius = cornerStyle
        }
        if type == .headline {
            skeletonView.layer.cornerRadius = BPKCornerRadiusXs
        }
        if type == .circle && size != .none {
            skeletonView.layer.cornerRadius = viewSize.height / 2.0
        }
        if type == .circle && size == .none {
            skeletonView.layer.cornerRadius = min(customSize.height, customSize.width) / 2.0
        }
    }

    public static func startShimmer(view: UIView) {
        let gradientLayer = CAGradientLayer()
        let transperant = BPKSkeleton.defaultColor.withAlphaComponent(0).cgColor
        let midColor = BPKSkeleton.defaultColor.withAlphaComponent(0.6).cgColor
        let duration = 1.0
        let delay = 0.2
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [transperant, midColor, transperant]
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
        view.layer.addSublayer(gradientLayer)
    }
}

extension BPKSkeleton {
    fileprivate var cornerStyle: CGFloat {
        switch style {
        case .rounded:
            return BPKCornerRadiusSm
        default:
            return 0
        }
    }
    
    fileprivate var viewSize: CGSize {
        switch type {
        case .image:
            return CGSize(width: size.imageSize, height: size.imageSize)
        case .circle:
            return CGSize(width: size.circleDiameter, height: size.circleDiameter)
        case .bodytext:
            return CGSize(width: BPKSpacingXxl * 5, height: BPKSpacingMd * 3 + BPKSpacingSm * 5)
        case .headline:
            return CGSize(width: size.headlineWidth, height: size.headlineHeight)
        }
    }
}
