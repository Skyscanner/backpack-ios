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
import Backpack

class PreviewCollectionViewHeader: UICollectionReusableView {
    var name: String? {
        didSet {
            label.text = name
        }
    }

    private let label: BPKLabel

    override init(frame: CGRect) {
        self.label = BPKLabel(fontStyle: .textHeading3)

        super.init(frame: frame)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    public static func referenceSize(collectionView: UICollectionView, text: String) -> CGSize {
        let mockLabel = BPKLabel(fontStyle: .textHeading4)
        mockLabel.text = text
        mockLabel.sizeToFit()

        return CGSize(width: collectionView.frame.width, height: mockLabel.frame.height + BPKSpacingBase + BPKSpacingMd)
    }

    // MARK: private
    private func setup() {
        self.addSubview(label)

        self.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: BPKSpacingBase),
            self.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: BPKSpacingMd)
        ])
    }
}
