/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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
public final class BPKBarChartCollectionView: UICollectionView {

    /// The BPKBarChartDataSource which will infom how the bar chart should be rendered
    public var barChartDataSource: BPKBarChartCollectionViewDataSource? {
        didSet {
            layout.barChartDataSource = barChartDataSource
        }
    }

    /// The BPKBarChartDelegate which can be used to respond to interaction with the bar chart
    public weak var barChartDelegate: BPKBarChartCollectionViewDelegate?

    /// The selected indexPath
    var selectedIndexPath: IndexPath? {
        didSet {
            updateSelectedMarkerPosition()
        }
    }

    fileprivate static let cellIdentifier: String = "BPKBarChartCollectionView_CellIdentifier"
    fileprivate static let headerIdentifier: String = "BPKBarChartCollectionView_HeaderIdentifier"
    fileprivate var selectedMarkerBottomConstraint: NSLayoutConstraint = NSLayoutConstraint()

    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
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

        register(BPKBarChartCollectionViewCell.self,
                 forCellWithReuseIdentifier: BPKBarChartCollectionView.cellIdentifier)

        register(BPKBarChartCollectionViewHeader.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: BPKBarChartCollectionView.headerIdentifier)

        collectionViewLayout = layout
        dataSource = self
        delegate = self
        allowsSelection = true
    }

    lazy fileprivate var layout: BPKBarChartCollectionViewFlowLayout = {
        let layout = BPKBarChartCollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: BPKSpacingXxl, height: max(0, bounds.height - layout.sectionInset.top))
        layout.scrollDirection = .horizontal
        layout.barChartDataSource = barChartDataSource
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

    fileprivate func updateSelectedMarkerPosition() {
        var selectedBarTopPosition = selectedMarkerBottomConstraint.constant
        var selectedBarOpacity: Float = 1.0
        if selectedIndexPath == nil {
            selectedMarker.isHidden = true
            selectedBarTopPosition = 0
        } else {
            selectedMarker.isHidden = false

            guard let selectedCell: BPKBarChartCollectionViewCell =
                cellForItem(at: selectedIndexPath!) as? BPKBarChartCollectionViewCell
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

extension BPKBarChartCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return barChartDataSource?.numberOfBarsInSection(barChartCollectionView: self, section: section) ?? 0
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return barChartDataSource?.numberOfSectionsInChart(barChartCollectionView: self) ?? 0
    }

    public func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: BPKBarChartCollectionView.cellIdentifier,
            for: indexPath) as? BPKBarChartCollectionViewCell
            else {
                fatalError("No cell registered for reuse with identifier \(BPKBarChartCollectionView.cellIdentifier)")
        }
        cell.barChartBar.title = barChartDataSource?.titleForBar(barChartCollectionView: self,
                                                                 atIndex: indexPath)
        cell.barChartBar.subtitle = barChartDataSource?.subtitleForBar(barChartCollectionView: self,
                                                                       atIndex: indexPath)
        cell.barChartBar.fillValue = barChartDataSource?.fillValueForBar(barChartCollectionView: self,
                                                                         atIndex: indexPath)
        cell.barChartBar.valueDescription = barChartDataSource?.valueDescriptionForBar(barChartCollectionView: self,
                                                                                       atIndex: indexPath)
        cell.isSelected = selectedIndexPath == indexPath
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: BPKBarChartCollectionView.headerIdentifier, for: indexPath
            ) as? BPKBarChartCollectionViewHeader else {
                fatalError("No cell registered for reuse with identifier \(BPKBarChartCollectionView.headerIdentifier)")
        }
        headerView.text = barChartDataSource?.titleForSection(barChartCollectionView: self, section: indexPath.section)
        return headerView
    }
}

extension BPKBarChartCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        barChartDelegate?.didSelect(barChart: self, index: indexPath)
    }
}

extension BPKBarChartCollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionName = barChartDataSource?.titleForSection(barChartCollectionView: self, section: section) ?? ""
        let height = BPKBarChartCollectionViewHeader.referenceSize(text: sectionName).height
        // We use a width of 10 here instead of the actual header width as we do not want space between sections
        return CGSize(width: 10, height: height)
    }
}
