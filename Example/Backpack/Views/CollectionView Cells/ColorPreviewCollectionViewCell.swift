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

class ColorPreviewCollectionViewCell: UICollectionViewCell {
    @objc dynamic var primaryColor: UIColor = BPKColor.skyBlue {
        didSet {
            updateBackgroundColor()
        }
    }

    @objc dynamic var skyGrayTint07: UIColor = BPKColor.skyGrayTint07 {
        didSet {
            updateBackgroundColor()
        }
    }

    @objc dynamic var skyGrayTint06: UIColor = BPKColor.skyGrayTint06 {
        didSet {
            updateBackgroundColor()
        }
    }

    @objc dynamic var skyGrayTint04: UIColor = BPKColor.skyGrayTint04 {
        didSet {
            updateBackgroundColor()
        }
    }

    @objc dynamic var skyGrayTint02: UIColor = BPKColor.skyGrayTint02 {
        didSet {
            updateBackgroundColor()
        }
    }

    @objc dynamic var skyGrayTint01: UIColor = BPKColor.skyGrayTint01 {
        didSet {
            updateBackgroundColor()
        }
    }

    @objc dynamic var skyGray: UIColor = BPKColor.skyGray {
        didSet {
            updateBackgroundColor()
        }
    }

    var color: UIColor? {
        didSet {
            updateBackgroundColor()
        }
    }
    var name: String? {
        didSet {
            label.text = name
        }
    }

    private let colorView: UIView
    private let label: BPKLabel

    override init(frame: CGRect) {
        self.colorView = UIView(frame: CGRect.zero)
        self.label = BPKLabel(fontStyle: .textSm)
        label.numberOfLines = 2

        super.init(frame: frame)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    func updateBackgroundColor () {
        switch color {
        case BPKColor.skyBlue:
            colorView.backgroundColor = primaryColor
        case BPKColor.skyGrayTint07:
            colorView.backgroundColor = skyGrayTint07
        case BPKColor.skyGrayTint06:
            colorView.backgroundColor = skyGrayTint06
        case BPKColor.skyGrayTint04:
            colorView.backgroundColor = skyGrayTint04
        case BPKColor.skyGrayTint02:
            colorView.backgroundColor = skyGrayTint02
        case BPKColor.skyGrayTint01:
            colorView.backgroundColor = skyGrayTint01
        case BPKColor.skyGray:
            colorView.backgroundColor = skyGray
        default:
            colorView.backgroundColor = color
        }
    }

    public static func estimatedSize() -> CGSize {
        let mockLabel = BPKLabel(fontStyle: BPKFontStyle.textBase)
        mockLabel.text = "color"
        mockLabel.sizeToFit()

        return CGSize(width: 100, height: 100 + mockLabel.frame.height + BPKSpacingMd + BPKSpacingBase * 2)
    }

    // MARK: private
    private func setup() {
        contentView.addSubview(colorView)
        contentView.addSubview(label)

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
        let shadow = BPKShadow.shadowSm()
        shadow.apply(to: colorView.layer)
    }
}
