/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

public final class BPKPageIndicator: UIView {
    public enum Variant {
        case `default`, overImage
    }
    
    private let pageControl = UIPageControl()
    
    //    This sets the current highlighted indicator
    public var currentIndex: Int {
        didSet {
            pageControl.currentPage = currentIndex
        }
    }
    
    //    This is the total number of indicators to be available
    public var totalIndicators: Int {
        didSet {
            pageControl.numberOfPages = totalIndicators
        }
    }
    
    //    Switches between default and overImage style
    public let variant: Variant
    
    public init(
        variant: Variant = .default,
        currentIndex: Int,
        totalIndicators: Int
    ) {
        self.variant = variant
        self.currentIndex = currentIndex
        self.totalIndicators = totalIndicators
        
        super.init(frame: .zero)
        setupPageControl()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.hidesForSinglePage = true
        pageControl.isUserInteractionEnabled = false
        addSubview(pageControl)
        
        pageControl.currentPage = currentIndex
        pageControl.numberOfPages = totalIndicators
        
        switch variant {
        case .`default`:
            pageControl.currentPageIndicatorTintColor = BPKColor.textSecondaryColor
            pageControl.pageIndicatorTintColor = BPKColor.lineColor
        case .overImage:
            pageControl.currentPageIndicatorTintColor = BPKColor.textOnDarkColor
            pageControl.pageIndicatorTintColor = BPKColor.lineOnDarkColor
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.topAnchor.constraint(equalTo: topAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
