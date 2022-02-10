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
@objc(BPKBarChartCollectionViewHeader)
internal final class BPKBarChartCollectionViewHeader: UICollectionReusableView {

    /// The text to diplay inside the header
    public var text: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    public static func referenceSize(text: String) -> CGSize {
        let mockLabel = BPKBarChartCollectionViewHeader.baseLabel()
        mockLabel.text = text
        mockLabel.sizeToFit()

        return CGSize(width: mockLabel.frame.width + 2 * BPKSpacingMd, height: mockLabel.frame.height + BPKSpacingMd)
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupViews()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    fileprivate func setupViews() {
        clipsToBounds = false

        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BPKSpacingMd),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: BPKSpacingMd),
            bottomAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: BPKSpacingMd)
        ])
    }

    fileprivate lazy var titleLabel: BPKLabel = {
        let view = BPKBarChartCollectionViewHeader.baseLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()

    static func baseLabel() -> BPKLabel {
        return BPKLabel(fontStyle: .textHeading4)
    }
}
