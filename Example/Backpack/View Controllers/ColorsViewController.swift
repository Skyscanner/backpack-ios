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

class ColorsViewController: UICollectionViewController {
    fileprivate static var primaryColors = [
        ("primary color", { (view: UIView) -> UIColor in
            return Color.primaryColor
        }),
        ("blue700", { (view: UIView) -> UIColor in
            return Color.skyBlueShade02
        }),
        ("white", { (view: UIView) -> UIColor in
            return Color.white
        })
    ]
    fileprivate static var secondaryColors = [
        ("green500", { (view: UIView) -> UIColor in
            return Color.monteverde
        }),
        ("yellow500", { (view: UIView) -> UIColor in
            return Color.kolkata
        }),
        ("red500", { (view: UIView) -> UIColor in
            return Color.panjin
        })
    ]
    fileprivate static var grayColors = [
        ("skyGrayTint07", { (view: UIView) -> UIColor in
            return Color.skyGrayTint07
        }),
        ("skyGrayTint06", { (view: UIView) -> UIColor in
            return Color.skyGrayTint06
        }),
        ("skyGrayTint04", { (view: UIView) -> UIColor in
            return Color.skyGrayTint04
        }),
        ("skyGrayTint02", { (view: UIView) -> UIColor in
            return Color.skyGrayTint02
        }),
        ("skyGrayTint01", { (view: UIView) -> UIColor in
            return Color.skyGrayTint01
        }),
        ("skyGray", { (view: UIView) -> UIColor in
            return Color.skyGray
        })
    ]
    fileprivate static var blackColors = [
        ("black", { (view: UIView) -> UIColor in
            return Color.black
        }),
        ("blackTint01", { (view: UIView) -> UIColor in
            return Color.blackTint01
        }),
        ("blackTint02", { (view: UIView) -> UIColor in
            return Color.blackTint02
        }),
        ("blackTint03", { (view: UIView) -> UIColor in
            return Color.blackTint03
        })
    ]
    fileprivate static var dynamicColors = [
        ("backgroundColor", { (view: UIView) -> UIColor in
            return Color.backgroundColor
        }),
        ("backgroundSecondaryColor", { (view: UIView) -> UIColor in
            return Color.backgroundSecondaryColor
        }),
        ("backgroundTertiaryColor", { (view: UIView) -> UIColor in
            return Color.backgroundTertiaryColor
        }),
        ("textPrimaryColor", { (view: UIView) -> UIColor in
            return Color.textPrimaryColor
        }),
        ("textSecondaryColor", { (view: UIView) -> UIColor in
            return Color.textSecondaryColor
        }),
        ("textTertiaryColor", { (view: UIView) -> UIColor in
            return Color.textTertiaryColor
        }),
        ("textQuaternaryColor", { (view: UIView) -> UIColor in
            return Color.textQuaternaryColor
        })
    ]
    fileprivate static var allColors = [
        ("Primary colors", ColorsViewController.primaryColors),
        ("Secondary colors", ColorsViewController.secondaryColors),
        ("Grays", ColorsViewController.grayColors),
        ("Blacks", ColorsViewController.blackColors),
        ("Dynamic", ColorsViewController.dynamicColors)
    ]

    fileprivate static let cellIdentifier = "ColorPreviewCollectionViewCell"
    fileprivate static let headerIdentifier = "PreviewCollectionViewHeader"

    override func viewDidLoad() {
        collectionView?.register(
            ColorPreviewCollectionViewCell.self, forCellWithReuseIdentifier: ColorsViewController.cellIdentifier
        )

        #if swift(>=4.2)
            collectionView?.register(
                PreviewCollectionViewHeader.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: ColorsViewController.headerIdentifier
            )
        #else
            collectionView?.register(
                PreviewCollectionViewHeader.self,
                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                withReuseIdentifier: ColorsViewController.headerIdentifier
            )
        #endif

        collectionView?.backgroundColor = Color.backgroundColor

        collectionView?.delegate = self
        collectionView?.dataSource = self

        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("ColorsViewController collectionView must be using UICollectionViewFlowLayout")
        }

        collectionView?.contentInset = UIEdgeInsets(
            top: BPKSpacingBase, left: BPKSpacingBase, bottom: BPKSpacingBase, right: BPKSpacingBase
        )

        layout.estimatedItemSize = ColorPreviewCollectionViewCell.estimatedSize()
    }
}

extension ColorsViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  ColorsViewController.allColors.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let (_, sectionColors) = ColorsViewController.allColors[section]
        return sectionColors.count
    }

    override func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ColorsViewController.cellIdentifier,
            for: indexPath) as? ColorPreviewCollectionViewCell
            else {
                fatalError("No cell registered for reuse with identifier \(ColorsViewController.cellIdentifier)")
        }

        let (_, sectionColors) = ColorsViewController.allColors[indexPath.section]
        let (name, getColor) = sectionColors[indexPath.row]
        cell.name = name
        cell.color = getColor(collectionView)

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
                withReuseIdentifier: ColorsViewController.headerIdentifier, for: indexPath
            ) as? PreviewCollectionViewHeader else {
                fatalError("Color View Headers are expected to be of type ColorPreviewCollectionViewHeader")
            }
            // Customize headerView here
            let (sectionName, _) = ColorsViewController.allColors[indexPath.section]
            headerView.name = sectionName

            return headerView
        }
        fatalError("Headers are the only supplimental elements available")
    }
}

extension ColorsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let (sectionName, _) = ColorsViewController.allColors[section]
        return PreviewCollectionViewHeader.referenceSize(collectionView: collectionView, text: sectionName)
    }
}
