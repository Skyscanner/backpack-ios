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

import Foundation

enum CarouselSection { case main }

final class CarouselCollectionViewDataSource: UICollectionViewDiffableDataSource<CarouselSection, CarouselViewModel> {
    
    private let reuseIdentifier: String
    
    init(collectionView: UICollectionView, reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
        super.init(collectionView: collectionView) { (collectionView, indexPath, viewModel) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: reuseIdentifier,
                for: indexPath) as? BPKCarouselCell

            cell?.setup(with: viewModel)
            return cell
        }
    }

    func render(with viewModel: [CarouselViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<CarouselSection, CarouselViewModel>()
        snapshot.appendSections([CarouselSection.main])
        snapshot.appendItems(viewModel, toSection: CarouselSection.main)
        apply(snapshot, animatingDifferences: false)
    }
}
