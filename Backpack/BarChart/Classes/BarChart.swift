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
@objc(BPKBarChart)
public final class BPKBarChart: UIView {

    /// The label to display in the bar chart key for items with a value
    public var dataKeyText: String {
        didSet {
            dataKeyItem.text = dataKeyText
        }
    }

    /// The label to display in the bar chart key for items without a value
    public var noDataKeyText: String {
        didSet {
            noDataKeyItem.text = noDataKeyText
        }
    }

    /// The title to display at the top of the bar chart
    public var title: String {
        didSet {
            titleLabel.text = title
        }
    }

    /// The bar chart delegate which can be used to respond to interaction with the bar chart
    public weak var barChartDelegate: BPKBarChartCollectionViewDelegate?

    /// The bar chart data source which will infom how the bar chart should be rendered
    public weak var barChartDataSource: BPKBarChartCollectionViewDataSource? {
        didSet {
            barChartCollectionView.reloadData()
        }
    }

    /// The selected indexPath
    public var selectedIndexPath: IndexPath? {
        didSet {
            barChartCollectionView.selectItem(at: selectedIndexPath, animated: false,
                                              scrollPosition: .top)
        }
    }

    /// Create a new instance of BPKBarChart
    ///
    /// - parameter title: The title for the bar chart
    public init(title: String, dataKeyText: String, noDataKeyText: String) {
        self.title = title
        self.dataKeyText = dataKeyText
        self.noDataKeyText = noDataKeyText
        super.init(frame: CGRect.zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        clipsToBounds = true

        addSubview(titleLabel)
        addSubview(dataKeyItem)
        addSubview(noDataKeyItem)
        addSubview(barChartCollectionView)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BPKSpacingMd),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: BPKSpacingXl),
            barChartCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barChartCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            barChartCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: BPKSpacingMd),
            bottomAnchor.constraint(equalTo: barChartCollectionView.bottomAnchor, constant: 2*BPKSpacingMd),
            noDataKeyItem.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            dataKeyItem.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            noDataKeyItem.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -BPKSpacingSm),
            dataKeyItem.trailingAnchor.constraint(equalTo: noDataKeyItem.leadingAnchor, constant: -BPKSpacingMd)
        ])
    }

    lazy fileprivate var titleLabel: BPKLabel = {
        let titleLabel: BPKLabel = BPKLabel(fontStyle: .textBaseEmphasized)
        titleLabel.text = title
        titleLabel.textColor = BPKColor.textSecondaryColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    lazy fileprivate var dataKeyItem: BPKBarChartKeyItem = {
        let dataKeyItem: BPKBarChartKeyItem = BPKBarChartKeyItem(text: dataKeyText)
        dataKeyItem.backgroundColor = BPKColor.primaryColor
        dataKeyItem.textColor = BPKColor.dynamicColor(withLightVariant: BPKColor.white, darkVariant: BPKColor.black)
        dataKeyItem.translatesAutoresizingMaskIntoConstraints = false
        return dataKeyItem
    }()

    lazy fileprivate var noDataKeyItem: BPKBarChartKeyItem = {
        let noDataKeyItem: BPKBarChartKeyItem = BPKBarChartKeyItem(text: noDataKeyText)
        noDataKeyItem.backgroundColor = BPKColor.skyGrayTint03
        noDataKeyItem.textColor = BPKColor.dynamicColor(withLightVariant: BPKColor.white, darkVariant: BPKColor.black)
        noDataKeyItem.translatesAutoresizingMaskIntoConstraints = false
        return noDataKeyItem
    }()

    lazy fileprivate var barChartCollectionView: BPKBarChartCollectionView = {
        let barChartCollectionView: BPKBarChartCollectionView = BPKBarChartCollectionView(barChart: self)
        barChartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        barChartCollectionView.backgroundColor = BPKColor.clear
        barChartCollectionView.clipsToBounds = false
        barChartCollectionView.dataSource = self
        barChartCollectionView.delegate = self
        return barChartCollectionView
    }()
}

extension BPKBarChart: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return barChartDataSource?.barChart(self, numberOfBarsInSection: section) ?? 0
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return barChartDataSource?.numberOfSections(in: self) ?? 0
    }

    public func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = barChartCollectionView.dequeueReusableCell(
            withReuseIdentifier: BPKBarChartCollectionView.cellIdentifier,
            for: indexPath) as? BPKBarChartCollectionViewCell
            else {
                fatalError("No cell registered for reuse with identifier \(BPKBarChartCollectionView.cellIdentifier)")
        }
        cell.barChartBar.title = barChartDataSource?.barChart(self, titleForBarAtIndex: indexPath)
        cell.barChartBar.subtitle = barChartDataSource?.barChart(self, subtitleForBarAtIndex: indexPath)
        cell.barChartBar.fillValue = barChartDataSource?.barChart(self, fillValueForBarAtIndex: indexPath)
        cell.barChartBar.valueDescription = barChartDataSource?.barChart(self, valueDescriptionForBarAtIndex: indexPath)
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
        headerView.text = barChartDataSource?.barChart(self, titleForSection: indexPath.section)
        return headerView
    }
}

extension BPKBarChart: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        barChartDelegate?.barChart(self, didSelectBarAt: indexPath)
    }
}

extension BPKBarChart: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionName = barChartDataSource?.barChart(self, titleForSection: section) ?? ""
        let height = BPKBarChartCollectionViewHeader.referenceSize(text: sectionName).height
        // We use a width of 10 here instead of the actual header width as we do not want space between sections
        return CGSize(width: 10, height: height)
    }
}
