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

class ChipPreviewCollectionViewCell: UICollectionViewCell {
    var enabled: Bool? {
        didSet {
            chip.isEnabled = enabled ?? true
        }
    }
    override var isSelected: Bool {
        didSet {
            chip.isSelected = isSelected
        }
    }
    var name: String? {
        didSet {
            chip.title = name
        }
    }
    
    private let chip: Backpack.Chip
    
    override init(frame: CGRect) {
        self.chip = Backpack.Chip(frame: CGRect.zero)
        
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
//    public static func estimatedSize() -> CGSize {
//        return CGSize(width: 110, height: 33)
//    }
    
    // MARK: private
    private func setup() {
        contentView.addSubview(chip)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        chip.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO is this needed?
        NSLayoutConstraint.activate([
            chip.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            chip.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: chip.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: chip.bottomAnchor),
//            colorView.widthAnchor.constraint(equalToConstant: 100),
//
//            contentView.leadingAnchor.constraint(equalTo: colorView.leadingAnchor),
//            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: BPKSpacingBase),
//            colorView.heightAnchor.constraint(equalTo: colorView.widthAnchor),
//
//            label.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: BPKSpacingMd),
//            label.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
//            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: BPKSpacingBase),
//
//            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        
//        colorView.layer.cornerRadius = BPKBorderRadiusSm
//        let shadow = Backpack.Shadow.shadowSm()
//        shadow.apply(to: colorView.layer)
    }
}
