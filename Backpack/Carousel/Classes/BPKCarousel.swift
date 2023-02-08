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

@objcMembers
@objc
public final class BPKCarousel: UIView {
    
    private var initialLayoutComplete = false
    private let images: [UIView]
    private let currentImage: Int?
    private let onImageChanged: ((Int) -> Void)?
    private let reuseIdentifier = String(describing: BPKCarouselImageCell.self)
    
    private var selectedRow: Int? {
        guard let cell = collectionView.visibleCells.first else { return nil }
        return collectionView.indexPath(for: cell)?.row
    }
    
    private lazy var tempPageIndicator: UIView = { // TO BE REPLACED
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var collectionViewDatasource = CarouselCollectionViewDataSource(
        collectionView: collectionView,
        reuseIdentifier: reuseIdentifier
    )
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(BPKCarouselImageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    public init(
        images: [UIView],
        currentImage: Int? = nil,
        onImageChanged: ((Int) -> Void)? = nil
    ) {
        self.images = images
        self.currentImage = currentImage
        self.onImageChanged = onImageChanged
        super.init(frame: .zero)
        
        setupViews()
        collectionViewDatasource.render(with: images)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [
            collectionView,
            tempPageIndicator
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                tempPageIndicator.widthAnchor.constraint(equalToConstant: 150), // TO BE REPLACED
                tempPageIndicator.heightAnchor.constraint(equalToConstant: 30), // TO BE REPLACED
                
                tempPageIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
                tempPageIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
            ]
        )
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let selectedRow = selectedRow else { return }
        onImageChanged?(selectedRow)
    }// TODO: selected row is not correct when scrolling back / forward from edges
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let currentImageRow = currentImage {
            scrollTo(row: currentImageRow, animated: false)
        }
        initialLayoutComplete = true
    }
}

// MARK: Scroll handling
extension BPKCarousel {
    private func scrollTo(row: Int, animated: Bool = true) {
        let indexPath = IndexPath(row: row, section: 0)
        collectionView.selectItem(
            at: indexPath,
            animated: animated,
            scrollPosition: .centeredHorizontally
        )
    }
    
    /// Handling scrolling:
    /// - to beginning when attempting to scroll past last item
    /// - to end when attempting to scroll before the first item
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Need to wait for initial scroll from init to complete before handling scrolling
        guard initialLayoutComplete else { return }
        let offset: CGFloat = 70.0
        
        let contentOffsetX = scrollView.contentOffset.x
        if contentOffsetX >= (scrollView.contentSize.width - scrollView.bounds.width) + offset {
            scrollTo(row: 0)
        } else if contentOffsetX <= -offset {
            scrollTo(row: images.count - 1)
        }
    }
}

extension BPKCarousel: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize { collectionView.frame.size }
}
