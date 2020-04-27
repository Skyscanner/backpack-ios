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
@objc(BPKBarChartKeyItem)
public final class BPKBarChartKeyItem: UIView {

    /// The text to display inside the item
    public var text: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    /// The color of the text
    public var textColor: UIColor? {
        get {
            return titleLabel.textColor
        }
        set {
            titleLabel.textColor = newValue
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupViews()
    }

    func setupViews() {
        clipsToBounds = true
        addSubview(titleLabel)
        layer.cornerRadius = BPKSpacingSm

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BPKSpacingSm),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: BPKSpacingSm),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: BPKSpacingSm),
            bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: BPKSpacingSm)

        ])
    }

    lazy fileprivate var titleLabel: BPKLabel = {
        let titleLabel: BPKLabel = BPKLabel(fontStyle: .textSm)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
}
