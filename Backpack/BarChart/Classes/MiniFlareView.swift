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

@objcMembers
@objc(BPKMiniFlareView)
internal final class BPKMiniFlareView: BPKFlareView {

    /// The text to display within the the mini flare
    public var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    fileprivate func setupViews() {
        backgroundColor = BPKColor.dynamicColor(withLightVariant: BPKColor.skyBlueShade02,
                                                     darkVariant: BPKColor.blackTint06)

        contentView.addSubview(label)

        cornerRadius = BPKSpacingSm

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: label.widthAnchor, constant: 2*BPKSpacingMd),
            contentView.heightAnchor.constraint(equalTo: label.heightAnchor, constant: 2*BPKSpacingMd),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    lazy fileprivate var label: BPKLabel = {
        let label = BPKLabel(fontStyle: .textBase)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = BPKColor.dynamicColor(withLightVariant: BPKColor.white, darkVariant: BPKColor.black)
        return label
    }()

    override public var flareHeight: CGFloat {
        return BPKSpacingMd
    }
}
