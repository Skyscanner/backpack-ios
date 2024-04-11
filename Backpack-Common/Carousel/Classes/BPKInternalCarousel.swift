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

public protocol BPKInternalCarouselDelegate: AnyObject {
    func onImageChange(index: Int)
}

public class BPKInternalCarousel: UIView {
    public enum PageIndicatorVisibility {
        case hidden
        case visible(_ paddingBottom: CGFloat)
    }
    
    private let pageViewController: CarouselPageViewController = {
        let viewController = CarouselPageViewController()
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    private let pageIndicator: UIView?
    
    public weak var delegate: BPKInternalCarouselDelegate?
    public var currentImage: Int { pageViewController.currentIndex }
    
    public init(pageIndicator: UIView?, pageIndicatorVisibility: PageIndicatorVisibility) {
        self.pageIndicator = pageIndicator
        super.init(frame: .zero)
        pageViewController.carouselDelegate = self
        addSubview(pageViewController.view)
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        if let pageIndicator, case .visible(let paddingBottom) = pageIndicatorVisibility {
            addSubview(pageIndicator)
            
            NSLayoutConstraint.activate([
                pageIndicator.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -paddingBottom
                ),
                pageIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(images: [UIView], animated: Bool = true) {
        pageViewController.set(images: images, animated: animated)
    }
    
    public func setCurrentImage(index: Int, animated: Bool = true) {
        pageViewController.setCurrentImage(index: index, animated: animated)
    }
}

extension BPKInternalCarousel: BPKInternalCarouselDelegate {
    public func onImageChange(index: Int) {
        delegate?.onImageChange(index: index)
    }
}
