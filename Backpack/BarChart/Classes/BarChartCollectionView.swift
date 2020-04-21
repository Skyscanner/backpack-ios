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
    public var barChartDataSource: BPKBarChartCollectionViewDataSource?
    
    /// The BPKBarChartDelegate which can be used to respond to interaction with the bar chart
    public weak var barChartDelegate: BPKBarChartCollectionViewDelegate?

    /// The selected indexPath
    var selectedIndexPath: IndexPath? {
        didSet {
            updateSelectedMarkerPosition()
        }
    }
    
    fileprivate static let cellIdentifier: String = "BPKBarChartCollectionView_CellIdentifier"
    fileprivate var selectedMarkerBottomConstraint: NSLayoutConstraint?

    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews() {
        backgroundView = UIView() // <-- This is a bit hacky!
        addSubview(selectedMarker)
        
        selectedMarkerBottomConstraint = selectedMarker.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([
            selectedMarker.leftAnchor.constraint(equalTo: backgroundView!.leftAnchor),
            selectedMarker.trailingAnchor.constraint(equalTo: backgroundView!.trailingAnchor),
            selectedMarkerBottomConstraint!,
            selectedMarker.heightAnchor.constraint(equalToConstant: 1.0)
        ])
        
        register(BPKBarChartCollectionViewCell.self,
                 forCellWithReuseIdentifier: BPKBarChartCollectionView.cellIdentifier)

        collectionViewLayout = layout
        dataSource = self
        delegate = self
        allowsSelection = true
    }

    lazy fileprivate var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: BPKSpacingXxl, height: bounds.height)
        layout.scrollDirection = .horizontal
        return layout
    }()

    lazy fileprivate var selectedMarker: UIView = {
        let view = UIView()
        view.backgroundColor = BPKColor.monteverde
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate func updateSelectedMarkerPosition() {
        if selectedMarkerBottomConstraint != nil {
            selectedMarkerBottomConstraint?.isActive = false
            selectedMarkerBottomConstraint = nil
        }
        
        if selectedIndexPath == nil {
            selectedMarker.isHidden = true
        } else {
            selectedMarker.isHidden = false

            guard let selectedCell: BPKBarChartCollectionViewCell =
                cellForItem(at: selectedIndexPath!) as? BPKBarChartCollectionViewCell
            else {
                return
            }
            let selectedBarTopPosition: CGFloat = selectedCell.barChartBar.barTopPosition
            selectedMarkerBottomConstraint =
                selectedMarker.bottomAnchor.constraint(equalTo: topAnchor, constant: selectedBarTopPosition)
            selectedMarkerBottomConstraint?.isActive = true
        }
    }
}

extension BPKBarChartCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return barChartDataSource?.numberOfBarsInChart(barChartCollectionView: self) ?? 0
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
                                                                 atIndex: indexPath.item)
        cell.barChartBar.subtitle = barChartDataSource?.subtitleForBar(barChartCollectionView: self,
                                                                       atIndex: indexPath.item)
        cell.barChartBar.fillValue = barChartDataSource?.fillValueForBar(barChartCollectionView: self,
                                                                         atIndex: indexPath.item)
        cell.barChartBar.valueDescription = barChartDataSource?.valueDescriptionForBar(barChartCollectionView: self,
                                                                                       atIndex: indexPath.item)
        return cell
    }
}

extension BPKBarChartCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        if barChartDelegate != nil {
            barChartDelegate?.didSelect(barChart: self, index: indexPath.item)
        }
    }
}
