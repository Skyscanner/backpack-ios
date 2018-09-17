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

class ColorsViewController: UICollectionViewController {
    fileprivate static var primaryColors = [("blue500", BPKColor.blue500()), ("blue700", BPKColor.blue700()), ("white",BPKColor.white())]
    fileprivate static var secondaryColors = [("green500",BPKColor.green500()), ("yellow500",BPKColor.yellow500()), ("red500",BPKColor.red500())]
    fileprivate static var grayColors = [("gray50",BPKColor.gray50()),  ("gray100",BPKColor.gray100()), ("gray300",BPKColor.gray300()),
                                         ("gray500",BPKColor.gray500()), ("gray700",BPKColor.gray700()), ("gray900",BPKColor.gray900())]
    fileprivate static var allColors = [("Primary colors", ColorsViewController.primaryColors), ("Secondary colors", ColorsViewController.secondaryColors), ("Grays", ColorsViewController.grayColors)]
    
    fileprivate static let cellIdentifier = "ColorPreviewCollectionViewCell"
    fileprivate static let headerIdentifier = "ColorPreviewCollectionViewHeader"
    
    override func viewDidLoad() {
        collectionView?.register(ColorPreviewCollectionViewCell.self, forCellWithReuseIdentifier: ColorsViewController.cellIdentifier)
        collectionView?.register(ColorPreviewCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ColorsViewController.headerIdentifier)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("ColorsViewController collectionView must be using UICollectionViewFlowLayout")
        }
        
        collectionView?.contentInset = UIEdgeInsets(top: BPKSpacingBase, left: BPKSpacingBase, bottom: BPKSpacingBase, right: BPKSpacingBase)
        
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorsViewController.cellIdentifier, for: indexPath) as? ColorPreviewCollectionViewCell
            else {
                fatalError("No cell registered for reuse with identifier \(ColorsViewController.cellIdentifier)")
        }
        
        let (_, sectionColors) = ColorsViewController.allColors[indexPath.section]
        let (name, color) = sectionColors[indexPath.row]
        cell.name = name
        cell.color = color
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionElementKindSectionHeader) {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ColorsViewController.headerIdentifier, for: indexPath) as? ColorPreviewCollectionViewHeader else{
                fatalError("Color View Headers are expected to be of type ColorPreviewCollectionViewHeader")
            }
            // Customize headerView here
            let (sectionName, _) = ColorsViewController.allColors[indexPath.section]
            headerView.name = sectionName;
            
            return headerView
        }
        fatalError("Headers are the only supplimental elements available")
    }
}

extension ColorsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let (sectionName, _) = ColorsViewController.allColors[section]
        return ColorPreviewCollectionViewHeader.referenceSize(collectionView: collectionView, text: sectionName)
    }
}
