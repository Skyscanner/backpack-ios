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
import Backpack

struct ChipConfig {
    let title: String
    let selected: Bool
    let enabled: Bool
    let iconName: BPKSmallIconName
}

class ChipsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var icons: Bool = false
    var backgroundTint: UIColor?
    var style: BPKChipStyle?
    fileprivate static var chips: [ChipConfig] = [
        ChipConfig(title: "Afghanistan", selected: false, enabled: false, iconName: .award),
        ChipConfig(title: "Belgium", selected: false, enabled: true, iconName: .account),
        ChipConfig(title: "Canada", selected: false, enabled: true, iconName: .adult),
        ChipConfig(title: "Denmark", selected: false, enabled: true, iconName: .airline),
        ChipConfig(title: "Ethiopia", selected: true, enabled: true, iconName: .arrowUp),
        ChipConfig(title: "Fiji", selected: false, enabled: true, iconName: .alertAdd),
        ChipConfig(title: "Germany", selected: false, enabled: true, iconName: .accountIdCard),
        ChipConfig(title: "Honduras", selected: false, enabled: true, iconName: .alertActive),
        ChipConfig(title: "India", selected: true, enabled: true, iconName: .baggageAdd),
        ChipConfig(title: "Jamaica", selected: false, enabled: true, iconName: .calendar),
        ChipConfig(title: "Kosovo", selected: false, enabled: false, iconName: .cafe),
        ChipConfig(title: "Lesotho", selected: false, enabled: true, iconName: .close),
        ChipConfig(title: "Madagascar", selected: true, enabled: true, iconName: .camera)
    ]

    fileprivate static let cellIdentifier = "ChipPreviewCollectionViewCell"
    fileprivate static let headerIdentifier = "PreviewCollectionViewHeader"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.allowsMultipleSelection = true
        self.collectionView.isScrollEnabled = false

        collectionView?.register(
            ChipPreviewCollectionViewCell.self, forCellWithReuseIdentifier: ChipsViewController.cellIdentifier
        )
        #if swift(>=4.2)
            collectionView?.register(
                PreviewCollectionViewHeader.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: ChipsViewController.headerIdentifier
            )
        #else
            collectionView?.register(
                PreviewCollectionViewHeader.self,
                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                withReuseIdentifier: ChipsViewController.headerIdentifier
            )
        #endif

        collectionView?.delegate = self
        collectionView?.dataSource = self

        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewMasonryFlowLayout else {
            fatalError("ChipsViewController collectionView must be using UICollectionViewMasonryFlowLayout")
        }

        collectionView?.contentInset = UIEdgeInsets(
            top: BPKSpacingBase, left: BPKSpacingBase, bottom: BPKSpacingBase, right: BPKSpacingBase
        )

        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = BPKSpacingMd
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.heightConstraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
    }
}

extension ChipsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ChipsViewController.chips.count
    }
}

extension ChipsViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ChipsViewController.cellIdentifier,
            for: indexPath) as? ChipPreviewCollectionViewCell
            else {
                fatalError("No cell registered for reuse with identifier \(ChipsViewController.cellIdentifier)")
        }

        let config = ChipsViewController.chips[indexPath.row]
        cell.title = config.title
        cell.isSelected = config.selected
        cell.enabled = config.enabled
        if icons {
            cell.icon = config.iconName
        }
        if backgroundTint != nil {
            cell.backgroundTint = backgroundTint
        }
        if let style = style {
            cell.style = style
        }

        return cell
    }
}
