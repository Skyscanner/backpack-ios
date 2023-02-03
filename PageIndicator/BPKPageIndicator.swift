import Foundation
import UIKit
import SwiftUI

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
    
    //    This is a label for screen readers on the indicators themselves
    public var indicatorLabel: String {
        didSet {
            pageControl.accessibilityLabel = indicatorLabel
        }
    }
    
    //    Switches between default and overImage style
    public let variant: Variant
    
    public init(variant: Variant,
                currentIndex: Int,
                totalIndicators: Int,
                indicatorLabel: String) {
        self.variant = variant
        self.currentIndex = currentIndex
        self.totalIndicators = totalIndicators
        self.indicatorLabel = indicatorLabel
        
        super.init(frame: .zero)
        setupPageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.hidesForSinglePage = true
        addSubview(pageControl)
        
        pageControl.currentPage = currentIndex
        pageControl.numberOfPages = totalIndicators
        pageControl.accessibilityLabel = indicatorLabel
        
        switch variant {
        case .`default`:
            pageControl.currentPageIndicatorTintColor = BPKColor.textSecondaryColor
            pageControl.pageIndicatorTintColor = BPKColor.lineColor
        case .overImage:
            pageControl.currentPageIndicatorTintColor = BPKColor.textOnDarkColor
            pageControl.pageIndicatorTintColor = BPKColor.lineOnDarkColor
        }
        
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.topAnchor.constraint(equalTo: topAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
