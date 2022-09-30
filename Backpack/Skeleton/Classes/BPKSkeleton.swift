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

enum BPKSkeletonConstants {
    static let backgroundColor = BPKColor.surfaceHighlightColor
}

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
            updateStyle()
        }
    }
    
    private var skeletonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    public init(
        type: BPKSkeletonType,
        size: BPKSkeletonSize = .default,
        style: BPKSkeletonStyle = .default
    ) {
        super.init(frame: .zero)
        self.type = type
        self.size = size
        self.style = style
        
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func updateType() {
        switch self.type {
        case .bodytext:
            self.skeletonView = BPKTextSkeleton(size: viewSize)
            self.skeletonView.backgroundColor = .clear
        default:
            self.skeletonView = BPKCommonSkeleton()
        }
    }
    
    private func setup() {
        updateType()
        addSubview(skeletonView)
        updateSize()
        updateStyle()
    }
    
    private func updateStyle() {
        if type == .image {
            skeletonView.layer.cornerRadius = cornerStyle
        }
        if type == .headline {
            skeletonView.layer.cornerRadius = BPKCornerRadiusXs
        }
        if type == .circle {
            skeletonView.layer.cornerRadius = min(viewSize.height, viewSize.width) / 2.0
        }
    }
    
    private func updateSize() {
        NSLayoutConstraint.activate([
            skeletonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            skeletonView.topAnchor.constraint(equalTo: topAnchor),
            skeletonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            skeletonView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            skeletonView.widthAnchor.constraint(equalToConstant: viewSize.width),
            skeletonView.heightAnchor.constraint(equalToConstant: viewSize.height)
        ])
    }

    public static func startShimmer(view: UIView) {
        BPKSkeleton.removeShimmer(view: view)
        
        let shimmer = BPKShimmerOverlayView()
        shimmer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shimmer)
        
        NSLayoutConstraint.activate([
            shimmer.topAnchor.constraint(equalTo: view.topAnchor),
            shimmer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shimmer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shimmer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public static func removeShimmer(view: UIView) {
        view.subviews.filter { $0 is BPKShimmerOverlayView }.forEach { $0.removeFromSuperview() }
    }
}

extension BPKSkeleton {
    fileprivate var cornerStyle: CGFloat {
        switch style {
        case .rounded:
            return BPKCornerRadiusSm
        case .`default`:
            return 0
        }
    }
    
    fileprivate var viewSize: CGSize {
        switch type {
        case .image:
            return size.image
        case .circle:
            return size.circle
        case .bodytext:
            return size.bodytext
        case .headline:
            return size.headline
        }
    }
}
