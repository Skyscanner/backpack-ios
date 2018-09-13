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

class ColorPreviewCollectionViewCell: UICollectionViewCell {
    var color: UIColor? {
        didSet {
            colorView.backgroundColor = color
        }
    }
    var name: String? {
        didSet {
            label.text = name
        }
    }
    
    private let colorView: UIView
    private let label: Backpack.Label
    
    override init(frame: CGRect) {
        self.colorView = UIView(frame: CGRect.zero)
        self.label = Backpack.Label(fontStyle: .textBase)
        
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    public static func estimatedSize() -> CGSize {
        let mockLabel = Backpack.Label(fontStyle: BPKFontStyle.textBase)
        mockLabel.text = "color"
        mockLabel.sizeToFit()
        
        return CGSize(width: 100, height: 100 + mockLabel.frame.height + BPKSpacingMd + BPKSpacingBase * 2)
    }
    
    // MARK: private
    private func setup() {
        contentView.addSubview(colorView)
        contentView.addSubview(label)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorView.widthAnchor.constraint(equalToConstant: 100),
            
            contentView.leadingAnchor.constraint(equalTo: colorView.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: BPKSpacingBase),
            colorView.heightAnchor.constraint(equalTo: colorView.widthAnchor),
            
            label.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: BPKSpacingMd),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: BPKSpacingBase),
            
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        colorView.layer.cornerRadius = BPKBorderRadiusSm
        let shadow = Backpack.Shadow.shadowSm()
        shadow.apply(to: colorView.layer)
    }
}
