/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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
    public var text: String {
        didSet {
            titleLabel.text = text
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

    /// Initialise a BPKBarChartKeyItem with text
    /// - parameter text: The text to diplay inside the item
    public init(text: String) {
        self.text = text
        super.init(frame: CGRect.zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        clipsToBounds = true
        addSubview(titleLabel)
        layer.cornerRadius = BPKSpacingSm
        layoutMargins = UIEdgeInsets(top: BPKSpacingSm, left: BPKSpacingSm, bottom: BPKSpacingSm, right: BPKSpacingSm)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
    }

    lazy fileprivate var titleLabel: BPKLabel = {
        let titleLabel: BPKLabel = BPKLabel(fontStyle: .textFootnote)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = text
        return titleLabel
    }()
}
