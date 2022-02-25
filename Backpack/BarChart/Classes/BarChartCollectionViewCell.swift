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
@objc(BPKBarChartCollectionViewCell)
internal final class BPKBarChartCollectionViewCell: UICollectionViewCell {

    /// The BPKBarChartBar instance displayed inside the cell
    lazy public var barChartBar: BPKBarChartBar = {
        let view: BPKBarChartBar = BPKBarChartBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()

    public override var isSelected: Bool {
        didSet {
            barChartBar.isSelected = isSelected
        }
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupViews()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    fileprivate func setupViews() {
        contentView.addSubview(barChartBar)

        NSLayoutConstraint.activate([
            barChartBar.topAnchor.constraint(equalTo: contentView.topAnchor),
            barChartBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: barChartBar.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: barChartBar.bottomAnchor)
        ])
    }

}
