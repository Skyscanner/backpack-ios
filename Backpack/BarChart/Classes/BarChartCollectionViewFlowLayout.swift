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
@objc(BPKBarChartCollectionViewFlowLayout)
internal final class BPKBarChartCollectionViewFlowLayout: UICollectionViewFlowLayout {

    public weak var barChartCollectionView: BPKBarChartCollectionView?

    override public init() {
        super.init()
        sectionInset.top = BPKBarChartCollectionViewHeader.referenceSize(text: "Test").height
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributesToReturn = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var copiedAttributes = [UICollectionViewLayoutAttributes]()
        copiedAttributes.reserveCapacity(attributesToReturn.count)

        for attribute in attributesToReturn {
            // Must copy attributes to avoid runtime warning:
            guard let attributeCopy = attribute.copy() as? UICollectionViewLayoutAttributes else {
                return attributesToReturn
            }
            copiedAttributes.append(attributeCopy)
        }

        for attributes in copiedAttributes {

            if let kind = attributes.representedElementKind {
                // Non nil : Supplementary View

                #if swift(>=4.2)
                let sectionHeader = UICollectionView.elementKindSectionHeader
                #else
                let sectionHeader = UICollectionElementKindSectionHeader
                #endif

                if kind == sectionHeader {
                    // [A] HEADER

                    var frame = attributes.frame

                    assert(collectionView != nil, "collectionView should not be nil")
                    assert(collectionView!.isKind(of: BPKBarChartCollectionView.self),
                           "collectionView should be of type BPKBarChartCollectionView")

                    if collectionView != nil && collectionView!.isKind(of: BPKBarChartCollectionView.self) {
                        guard let barChartCollectionView = collectionView as? BPKBarChartCollectionView else {
                            continue
                        }
                        let sectionTitle =
                          barChartCollectionView.barChart.barChartDataSource?.barChart(barChartCollectionView.barChart,
                                                                        titleForSection: attributes.indexPath.section)
                        let headerSizeForSection =
                            BPKBarChartCollectionViewHeader.referenceSize(text: sectionTitle ?? "")

                        frame.size = headerSizeForSection
                        frame.origin.y = 0
                    }

                    attributes.frame = frame
                }
            } else {
                // Kind is nil : Item (cell)

                if let attributesForItem = self.layoutAttributesForItem(at: attributes.indexPath) {
                    attributes.frame = attributesForItem.frame
                }
            }
        }

        return copiedAttributes
    }
}
