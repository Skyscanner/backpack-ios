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
import Backpack

class ChipsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var icons: Bool = false
    var shadow: Bool = true
    var colorUnselectedState: Bool = false
    var backgroundTint: UIColor?
    var style: BPKChipStyle?
    fileprivate static var chips = [
        (title: "Afghanistan", selected: false, enabled: false, iconName: BPKIconName.award),
        (title: "Belgium", selected: false, enabled: true, iconName: BPKIconName.account),
        (title: "Canada", selected: false, enabled: true, iconName: BPKIconName.adult),
        (title: "Denmark", selected: false, enabled: true, iconName: BPKIconName.airline),
        (title: "Ethiopia", selected: true, enabled: true, iconName: BPKIconName.arrowUp),
        (title: "Fiji", selected: false, enabled: true, iconName: BPKIconName.alertAdd),
        (title: "Germany", selected: false, enabled: true, iconName: BPKIconName.accountIdCard),
        (title: "Honduras", selected: false, enabled: true, iconName: BPKIconName.alertActive),
        (title: "India", selected: true, enabled: true, iconName: BPKIconName.baggageAdd),
        (title: "Jamaica", selected: false, enabled: true, iconName: BPKIconName.calendar),
        (title: "Kosovo", selected: false, enabled: false, iconName: BPKIconName.cafe),
        (title: "Lesotho", selected: false, enabled: true, iconName: BPKIconName.close),
        (title: "Madagascar", selected: true, enabled: true, iconName: BPKIconName.camera)
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

        let (title, selected, enabled, icon) = ChipsViewController.chips[indexPath.row]
        cell.title = title
        cell.isSelected = selected
        cell.enabled = enabled
        cell.shadow = shadow
        if icons {
            cell.icon = icon
        }
        if backgroundTint != nil {
            cell.backgroundTint = backgroundTint
        }
        if style == style {
            cell.style = style
        }
        cell.colorUnselectedState = colorUnselectedState

        return cell
    }
}
