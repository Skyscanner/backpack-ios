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

@objcMembers
@objc(BPKMiniFlareView)
public final class BPKMiniFlareView: BPKFlareView {

    let label: UILabel = BPKLabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }

    func setupViews() {
        self.backgroundColor = BPKColor.dynamicColor(withLightVariant: BPKColor.skyBlueShade02,
                                                     darkVariant: BPKColor.blackTint06)
        self.label.textColor = BPKColor.dynamicColor(withLightVariant: BPKColor.white, darkVariant: BPKColor.black)

        self.contentView.addSubview(self.label)

        self.label.translatesAutoresizingMaskIntoConstraints = false

        self.cornerRadius = BPKSpacingSm

        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalTo: self.label.widthAnchor, constant: 2*BPKSpacingMd),
            self.contentView.heightAnchor.constraint(equalTo: self.label.heightAnchor, constant: 2*BPKSpacingMd),
            self.label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }

    public var text: String? {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
        }
    }

    override public func flareHeight() -> CGFloat {
        return BPKSpacingMd
    }
}
