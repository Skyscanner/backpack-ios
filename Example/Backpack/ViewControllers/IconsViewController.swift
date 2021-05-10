/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

class IconsViewController: UICollectionViewController {

    fileprivate static var iconList = Array(BPKIcon.iconMapping!.keys).map({ $0.rawValue }).sorted()
    fileprivate static var largeIconList = iconList.filter({ !$0.hasSuffix("-sm") })
    fileprivate static var smallIconList = iconList.filter({ $0.hasSuffix("-sm") })

    enum IconType {
        case small
        case large
    }

    fileprivate static var icons = [
        (heading: "Large icons", icons: largeIconList, iconType: IconType.large),
        (heading: "Small icons", icons: smallIconList, iconType: IconType.small)
    ]

    fileprivate static let smallCellIdentifier = "IconsPreviewCollectionViewCellSmall"
    fileprivate static let largeCellIdentifier = "IconsPreviewCollectionViewCellLarge"
    fileprivate static let headerIdentifier = "PreviewCollectionViewHeader"

    override func viewDidLoad() {
        collectionView?.register(
            IconsPreviewCollectionViewCell<BPKSmallIconName>.self,
            forCellWithReuseIdentifier: IconsViewController.smallCellIdentifier
        )
        collectionView?.register(
            IconsPreviewCollectionViewCell<BPKLargeIconName>.self,
            forCellWithReuseIdentifier: IconsViewController.largeCellIdentifier
        )
        #if swift(>=4.2)
            collectionView?.register(
                PreviewCollectionViewHeader.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: IconsViewController.headerIdentifier
            )
        #else
            collectionView?.register(
                PreviewCollectionViewHeader.self,
                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                withReuseIdentifier: IconsViewController.headerIdentifier
            )
        #endif

        collectionView?.delegate = self
        collectionView?.dataSource = self

        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("IconsViewController collectionView must be using UICollectionViewFlowLayout")
        }

        collectionView?.contentInset = UIEdgeInsets(
            top: BPKSpacingBase, left: BPKSpacingBase, bottom: BPKSpacingBase, right: BPKSpacingBase
        )
        layout.estimatedItemSize = BPKIcon.concreteSizeForLargeIcon
    }

}

extension IconsViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return IconsViewController.icons.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IconsViewController.icons[section].icons.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let iconSet = IconsViewController.icons[indexPath.section]

        var reuseIdentifier: String
        switch iconSet.iconType {
        case .small:
            reuseIdentifier = IconsViewController.smallCellIdentifier
        case .large:
            reuseIdentifier = IconsViewController.largeCellIdentifier
        }

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        )

        var icon = iconSet.icons[indexPath.row]

        if icon.hasSuffix("-sm") {
            icon.removeLast(3)
        }

        if iconSet.iconType == .small, let cell = cell as? IconsPreviewCollectionViewCell<BPKSmallIconName> {
            cell.icon = BPKSmallIconName(icon)
        } else if iconSet.iconType == .large, let cell = cell as? IconsPreviewCollectionViewCell<BPKLargeIconName> {
            cell.icon = BPKLargeIconName(icon)
        } else {
            fatalError("No cell registered for the icon type provided")
        }

        return cell
    }
    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        #if swift(>=4.2)
            let isExpectedHeader = kind == UICollectionView.elementKindSectionHeader
        #else
            let isExpectedHeader = kind == UICollectionElementKindSectionHeader
        #endif

        if isExpectedHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: IconsViewController.headerIdentifier,
                for: indexPath
            ) as? PreviewCollectionViewHeader else {
                fatalError("Icon View Headers are expected to be of type ColorPreviewCollectionViewHeader")
            }
            headerView.name = IconsViewController.icons[indexPath.section].heading

            return headerView
        }
        fatalError("Headers are the only supplimental elements available")
    }
}

extension IconsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return PreviewCollectionViewHeader.referenceSize(
            collectionView: collectionView, text: IconsViewController.icons[section].heading
        )
    }
}
