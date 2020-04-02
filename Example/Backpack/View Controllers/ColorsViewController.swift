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
            return BPKColor.primaryColor
        }),
        ("blue700", { (view: UIView) -> UIColor in
            return BPKColor.skyBlueShade02
        }),
        ("white", { (view: UIView) -> UIColor in
            return BPKColor.white
        })
    ]
    fileprivate static var secondaryColors = [
        ("green500", { (view: UIView) -> UIColor in
            return BPKColor.monteverde
        }),
        ("yellow500", { (view: UIView) -> UIColor in
            return BPKColor.kolkata
        }),
        ("red500", { (view: UIView) -> UIColor in
            return BPKColor.panjin
        })
    ]
    fileprivate static var grayColors = [
        ("skyGrayTint07", { (view: UIView) -> UIColor in
            return BPKColor.skyGrayTint07
        }),
        ("skyGrayTint06", { (view: UIView) -> UIColor in
            return BPKColor.skyGrayTint06
        }),
        ("skyGrayTint04", { (view: UIView) -> UIColor in
            return BPKColor.skyGrayTint04
        }),
        ("skyGrayTint02", { (view: UIView) -> UIColor in
            return BPKColor.skyGrayTint02
        }),
        ("skyGrayTint01", { (view: UIView) -> UIColor in
            return BPKColor.skyGrayTint01
        }),
        ("skyGray", { (view: UIView) -> UIColor in
            return BPKColor.skyGray
        })
    ]
    fileprivate static var blackColors = [
        ("black", { (view: UIView) -> UIColor in
            return BPKColor.black
        }),
        ("blackTint01", { (view: UIView) -> UIColor in
            return BPKColor.blackTint01
        }),
        ("blackTint02", { (view: UIView) -> UIColor in
            return BPKColor.blackTint02
        }),
        ("blackTint03", { (view: UIView) -> UIColor in
            return BPKColor.blackTint03
        }),
        ("blackTint04", { (view: UIView) -> UIColor in
            return BPKColor.blackTint04
        }),
        ("blackTint05", { (view: UIView) -> UIColor in
            return BPKColor.blackTint05
        }),
        ("blackTint06", { (view: UIView) -> UIColor in
            return BPKColor.blackTint06
        })
    ]
    fileprivate static var dynamicColors = [
        ("backgroundColor", { (view: UIView) -> UIColor in
            return BPKColor.backgroundColor
        }),
        ("backgroundSecondaryColor", { (view: UIView) -> UIColor in
            return BPKColor.backgroundSecondaryColor
        }),
        ("backgroundTertiaryColor", { (view: UIView) -> UIColor in
            return BPKColor.backgroundTertiaryColor
        }),
        ("backgroundAlternativeColor", { (view: UIView) -> UIColor in
            return BPKColor.backgroundAlternativeColor
        }),
        ("backgroundAlternativeSecondaryColor", { (view: UIView) -> UIColor in
            return BPKColor.backgroundAlternativeSecondaryColor
        }),
        ("textPrimaryColor", { (view: UIView) -> UIColor in
            return BPKColor.textPrimaryColor
        }),
        ("textSecondaryColor", { (view: UIView) -> UIColor in
            return BPKColor.textSecondaryColor
        }),
        ("textTertiaryColor", { (view: UIView) -> UIColor in
            return BPKColor.textTertiaryColor
        }),
        ("textQuaternaryColor", { (view: UIView) -> UIColor in
            return BPKColor.textQuaternaryColor
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

        collectionView?.backgroundColor = BPKColor.backgroundColor

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
                fatalError("BPKColor View Headers are expected to be of type ColorPreviewCollectionViewHeader")
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
