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
    var icon: BPKChip.Icon? {
        didSet {
            if let icon = icon {
                chip.icon = icon
            } else {
                chip.icon = nil
            }
        }
    }
    var backgroundTint: UIColor? {
        didSet {
            if backgroundTint != nil {
                chip.backgroundTint = backgroundTint
            }
        }
    }
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
    var title: String? {
        didSet {
            chip.title = title
        }
    }
    var style: BPKChipStyle? {
        didSet {
            guard let style = style else { return }
            chip.style = style
        }
    }

    private let chip: BPKChip = BPKChip(frame: CGRect.zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    // MARK: private
    private func setUp() {
        contentView.addSubview(chip)

        chip.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            chip.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            chip.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: chip.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: chip.bottomAnchor)
            ])
    }
}
