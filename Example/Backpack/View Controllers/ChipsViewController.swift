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

class ChipsViewController: UICollectionViewController {
    fileprivate static var chips = [
        ("Afghanistan", false, false), ("Belgium", false, true),
        ("Canada", false, true), ("Denmark", false, true), ("Ethiopia", true, true),
        ("Fiji", false, true), ("Germany", false, true), ("Honduras", false, true),
        ("India", true, true), ("Jamaica", false, true), ("Kosovo", false, false),
        ("Lesotho", false, true), ("Madagascar", true, true)
    ]

    fileprivate static let cellIdentifier = "ChipPreviewCollectionViewCell"
    fileprivate static let headerIdentifier = "PreviewCollectionViewHeader"

    override func viewDidLoad() {
        self.collectionView.allowsMultipleSelection = true

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

        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("ChipsViewController collectionView must be using UICollectionViewFlowLayout")
        }

        collectionView?.contentInset = UIEdgeInsets(
            top: BPKSpacingBase, left: BPKSpacingBase, bottom: BPKSpacingBase, right: BPKSpacingBase
        )
        
//        layout.estimatedItemSize = ChipPreviewCollectionViewCell.estimatedSize()
    }
}

extension ChipsViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ChipsViewController.chips.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let (name, _, _) = ChipsViewController.chips[indexPath.row]
        let mockChip = Backpack.Chip(frame: CGRect.zero)
        mockChip.title = name
        mockChip.sizeToFit()
        print("mockChipWidth", mockChip.frame.width)
        print("mockChipHeight", mockChip.frame.height)

        return CGSize(width: mockChip.frame.width + 20, height: mockChip.frame.height + 11)
    }

    override func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ChipsViewController.cellIdentifier,
            for: indexPath) as? ChipPreviewCollectionViewCell
            else {
                fatalError("No cell registered for reuse with identifier \(ChipsViewController.cellIdentifier)")
        }

        let (name, selected, enabled) = ChipsViewController.chips[indexPath.row]
        cell.name = name
        cell.isSelected = selected
        cell.enabled = enabled

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
                withReuseIdentifier: ChipsViewController.headerIdentifier, for: indexPath
                ) as? PreviewCollectionViewHeader else {
                    fatalError("Chip View Headers are expected to be of type ChipPreviewCollectionViewHeader")
            }
            // Customize headerView here
            headerView.name = "Chips example"

            return headerView
        }
        fatalError("Headers are the only supplimental elements available")
    }
}

extension ChipsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
        ) -> CGSize {
        return PreviewCollectionViewHeader.referenceSize(collectionView: collectionView, text: "Chips example")
    }
}
