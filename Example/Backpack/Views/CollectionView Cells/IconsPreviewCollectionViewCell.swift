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

class IconsPreviewCollectionViewCell: UICollectionViewCell {

    var size: BPKIconSize? {
        didSet {
            imageView.size = size ?? BPKIconSize.large
        }
    }

    var icon: BPKIconName? {
        didSet {
            imageView.iconName = icon
        }
    }

    private let imageView: BPKIconView

    override init(frame: CGRect) {
        self.imageView = BPKIconView(iconName: nil, size: .large)

        super.init(frame: frame)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    public static func estimatedSize() -> CGSize {
        return BPKIcon.concreteSize(forSize: .large)
    }

    // MARK: private
    private func setup() {
        contentView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: BPKIcon.concreteSize(forSize: .large).width),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            imageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: BPKSpacingSm),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: BPKSpacingSm)
        ])

    }
}
