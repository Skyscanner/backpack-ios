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

/*
 * Inspired by MIT licensed code from Dejan Skledar
 * https://github.com/dejanskledar/centered-collectionview-layout
 */

import UIKit

class CollectionViewRow {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0

    init(spacing: CGFloat) {
        self.spacing = spacing
    }

    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }

    func leftAlignLayout(collectionViewWidth: CGFloat) {
        var offset = CGFloat(0.0)
        for attribute in attributes {
            attribute.frame.origin.x = offset
            offset += attribute.frame.width + spacing
        }
    }
}

class UICollectionViewMasonryFlowLayout: UICollectionViewFlowLayout {
    var rowCount = 0

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var rows = [CollectionViewRow]()
        var currentRow: CGFloat = -1

        for attribute in attributes {
            if currentRow != attribute.frame.origin.y {
                currentRow = attribute.frame.origin.y
                rows.append(CollectionViewRow(spacing: self.minimumInteritemSpacing))
            }
            rows.last?.add(attribute: attribute)
        }
        rowCount = rows.count

        rows.forEach { $0.leftAlignLayout(collectionViewWidth: collectionView?.frame.width ?? 0) }
        return rows.flatMap { $0.attributes }
    }

    override var collectionViewContentSize: CGSize {
        var contentSize = super.collectionViewContentSize
        let verticalPadding = CGFloat(rowCount) * self.minimumLineSpacing
        contentSize.height += verticalPadding
        return contentSize
    }
}
