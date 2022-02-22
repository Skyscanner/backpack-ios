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

@objcMembers
@objc(BPKBarChartCollectionView)
internal final class BPKBarChartCollectionView: UICollectionView {

    /// The BPKBarChart instance for the CollectionView
    public private(set) unowned var barChart: BPKBarChart

    /// The cell identifier string for creating instances of BarChartCollectionViewCell
    internal static let cellIdentifier: String = "BPKBarChartCollectionView_CellIdentifier"

    /// The cell identifier string for creating instances of BarChartCollectionViewHeader
    internal static let headerIdentifier: String = "BPKBarChartCollectionView_HeaderIdentifier"

    /// Create a new instance of BPKBarChartCollectionView
    ///
    /// - parameter barChart: The BPKBarChart for which the BPKBarChartCollectionView is being created
    public init(barChart: BPKBarChart) {
        self.barChart = barChart
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(selectedMarker)

        selectedMarkerBottomConstraint = selectedMarker.bottomAnchor.constraint(equalTo: topAnchor)
        NSLayoutConstraint.activate([
            selectedMarker.leadingAnchor.constraint(equalTo: frameLayoutGuide.leadingAnchor),
            selectedMarker.trailingAnchor.constraint(equalTo: frameLayoutGuide.trailingAnchor),
            selectedMarkerBottomConstraint,
            selectedMarker.heightAnchor.constraint(equalToConstant: 1.0)
        ])

        register(
            BPKBarChartCollectionViewCell.self,
            forCellWithReuseIdentifier: BPKBarChartCollectionView.cellIdentifier
        )

        #if swift(>=4.2)
        register(
            BPKBarChartCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: BPKBarChartCollectionView.headerIdentifier
        )
        #else
        register(
            BPKBarChartCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: BPKBarChartCollectionView.headerIdentifier
        )
        #endif

        collectionViewLayout = layout
        allowsSelection = true
    }

    fileprivate var selectedMarkerBottomConstraint: NSLayoutConstraint = NSLayoutConstraint()

    lazy fileprivate var layout: BPKBarChartCollectionViewFlowLayout = {
        let layout = BPKBarChartCollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: BPKSpacingXxl, height: max(0, bounds.height - layout.sectionInset.top))
        layout.scrollDirection = .horizontal
        layout.barChartCollectionView = self
        //  We would ideally use layout.sectionHeadersPinToVisibleBounds, but it currently breaks our custom layout
        return layout
    }()

    public override func layoutSubviews() {
        super.layoutSubviews()
        layout.estimatedItemSize = CGSize(width: BPKSpacingXxl, height: max(0, bounds.height - layout.sectionInset.top))
    }

    lazy fileprivate var selectedMarker: UIView = {
        let view = UIView()
        view.backgroundColor = BPKColor.monteverde
        view.layer.opacity = 0
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public func reloadData() {
        super.reloadData()
        updateSelectedMarkerPosition()
    }

    override public func selectItem(
        at indexPath: IndexPath?, animated: Bool,
        scrollPosition: UICollectionView.ScrollPosition
    ) {
        super.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
        updateSelectedMarkerPosition()
    }

    fileprivate func updateSelectedMarkerPosition() {
        var selectedBarTopPosition = selectedMarkerBottomConstraint.constant
        var selectedBarOpacity: Float = 1.0
        if barChart.selectedIndexPath == nil {
            selectedMarker.isHidden = true
            selectedBarTopPosition = 0
            selectedBarOpacity = 0
        } else {
            selectedMarker.isHidden = false

            guard let selectedCell: BPKBarChartCollectionViewCell =
                cellForItem(at: barChart.selectedIndexPath!) as? BPKBarChartCollectionViewCell
                else {
                    return
            }

            if selectedCell.barChartBar.fillValue == nil {
                selectedBarOpacity = 0
            } else {
                selectedBarTopPosition = selectedCell.barChartBar.barTopPosition + layout.sectionInset.top
                selectedBarOpacity = 1
            }
        }

        // If the bar is currently not visible, then there is no need to animate its position
        if selectedMarker.layer.opacity < 0.1 {
            selectedMarkerBottomConstraint.constant = selectedBarTopPosition
            layoutIfNeeded()
        }

        UIView.animate(withDuration: BPKDuration.animationDurationSm) {
            self.selectedMarkerBottomConstraint.constant = selectedBarTopPosition
            self.selectedMarker.layer.opacity = selectedBarOpacity
            self.layoutIfNeeded()
        }
    }
}
