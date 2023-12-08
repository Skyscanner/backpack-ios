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
import Backpack_Common

public protocol BPKCarouselDelegate: AnyObject {
    func onImageChange(index: Int)
}

public final class BPKCarousel: UIView {
    private let internalCarousel: BPKInternalCarousel
    
    public weak var delegate: BPKCarouselDelegate? {
        didSet {
            internalCarousel.delegate = self
        }
    }
    
    public var currentImage: Int { internalCarousel.currentImage }
    
    private let pageIndicator: BPKPageIndicator = {
        let pageIndicator = BPKPageIndicator(variant: .overImage, currentIndex: 0, totalIndicators: 0)
        pageIndicator.translatesAutoresizingMaskIntoConstraints = false
        return pageIndicator
    }()
    
    public init() {
        internalCarousel = BPKInternalCarousel(pageIndicator: pageIndicator)
        super.init(frame: .zero)
        
        internalCarousel.delegate = self
        internalCarousel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(internalCarousel)
        NSLayoutConstraint.activate([
            internalCarousel.topAnchor.constraint(equalTo: topAnchor),
            internalCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
            internalCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
            internalCarousel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(images: [UIView], animated: Bool = true) {
        pageIndicator.totalIndicators = images.count
        internalCarousel.set(images: images, animated: animated)
    }
    
    public func setCurrentImage(index: Int, animated: Bool = true) {
        pageIndicator.currentIndex = index
        internalCarousel.setCurrentImage(index: index, animated: animated)
    }
}

extension BPKCarousel: BPKInternalCarouselDelegate {
    public func onImageChange(index: Int) {
        pageIndicator.currentIndex = index
        delegate?.onImageChange(index: index)
    }
}
