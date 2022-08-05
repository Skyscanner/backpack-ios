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


public class BPKSkeleton: UIView {
    
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
            updateType()
        }
    }
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    private var skeletonView: UIView = {
        let view = UIView(frame: .zero)
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
    }
    
    internal func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerStackView)
        containerStackView.addSubview(skeletonView)
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            skeletonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            skeletonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            skeletonView.topAnchor.constraint(equalTo: topAnchor),
            skeletonView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setupSubviews()
    }
    
    internal func updateSize() {
    }
    
    internal func updateStyle() {
    }
    
    internal func setupSubviews() {
    }
    
    internal func placeElements() {
    }
}

extension BPKSkeleton {
    internal var bgColor: UIColor {
        return BPKColor.dynamicColor(withLightVariant: BPKColor.skyGrayTint06, darkVariant: BPKColor.blackTint02)
    }
}
