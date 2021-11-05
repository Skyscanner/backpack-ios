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
import Backpack

protocol IconDetails {
    associatedtype ViewClass: BPKIconView
    associatedtype IconNameType: Any
    static var size: CGSize { get }
    static func setIconName(view: Self.ViewClass, name: Self.IconNameType)
}

extension BPKSmallIconName: IconDetails {
    static var size: CGSize = BPKIcon.concreteSizeForSmallIcon

    typealias ViewClass = BPKSmallIconView
    typealias IconNameType = BPKSmallIconName

    static func setIconName(view: BPKSmallIconView, name: BPKSmallIconName) {
        view.iconName = BPKIconName(rawValue: name.rawValue)
    }
}

extension BPKLargeIconName: IconDetails {
    static var size: CGSize = BPKIcon.concreteSizeForLargeIcon

    typealias ViewClass = BPKLargeIconView
    typealias IconNameType = BPKLargeIconName

    static func setIconName(view: BPKLargeIconView, name: BPKLargeIconName) {
        view.iconName = BPKIconName(rawValue: name.rawValue)
    }
}

extension BPKXlIconName: IconDetails {
    static var size: CGSize = BPKIcon.concreteSizeForXlIcon

    typealias ViewClass = BPKXlIconView
    typealias IconNameType = BPKXlIconName

    static func setIconName(view: BPKXlIconView, name: BPKXlIconName) {
        view.iconName = BPKIconName(rawValue: name.rawValue)
    }
}

class IconsPreviewCollectionViewCell<T: IconDetails>: UICollectionViewCell {
    var icon: T.IconNameType? {
        didSet {
            if let icon = icon {
                T.setIconName(view: imageView, name: icon)
            }
        }
    }

    private var imageView: T.ViewClass

    override init(frame: CGRect) {
        self.imageView = T.ViewClass(frame: .zero)

        super.init(frame: frame)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    // MARK: private
    private func setup() {
        contentView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
}
