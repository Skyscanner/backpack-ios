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

    /// The title to display at the top of the bar chart
    public var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    /// The bar chart delegate which can be used to respond to interaction with the bar chart
    public var barChartDelegate: BPKBarChartCollectionViewDelegate? {
        get {
            return barChartCollectionView.barChartDelegate
        }
        set {
            barChartCollectionView.barChartDelegate = newValue
        }
    }

    /// The bar chart data source which will infom how the bar chart should be rendered
    public var barChartDataSource: BPKBarChartCollectionViewDataSource? {
        get {
            return barChartCollectionView.barChartDataSource
        }
        set {
            barChartCollectionView.barChartDataSource = newValue
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupViews()
    }

    func setupViews() {
        clipsToBounds = true

        addSubview(titleLabel)
        addSubview(barChartCollectionView)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BPKSpacingMd),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: BPKSpacingXl),
            barChartCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barChartCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            barChartCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: BPKSpacingMd),
            bottomAnchor.constraint(equalTo: barChartCollectionView.bottomAnchor, constant: 2*BPKSpacingMd)
        ])
    }

    lazy fileprivate var titleLabel: BPKLabel = {
        let titleLabel: BPKLabel = BPKLabel(fontStyle: .textBaseEmphasized)
        titleLabel.textColor = BPKColor.textSecondaryColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    lazy fileprivate var barChartCollectionView: BPKBarChartCollectionView = {

        let barChartCollectionView: BPKBarChartCollectionView = BPKBarChartCollectionView(frame: CGRect.zero,
                                                                collectionViewLayout: UICollectionViewLayout())
        barChartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        barChartCollectionView.backgroundColor = BPKColor.clear
        barChartCollectionView.clipsToBounds = false
        return barChartCollectionView
    }()
}
