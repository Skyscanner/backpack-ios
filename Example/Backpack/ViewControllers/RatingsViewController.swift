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

import Backpack.Rating

class RatingsViewController: UIViewController {
    @IBOutlet var ratings: [BPKRating]!
    var showSubtitle: Bool = false
    var showDifferentSizes: Bool = false
    var layout: BPKRatingLayout = .horizontal

    static let titleTextDefinition = BPKRatingTextDefinition(
        highRatingText: "High title",
        mediumRatingText: "Medium title",
        lowRatingText: "Low title"
    )

    static let subtitleTextDefinition = BPKRatingTextDefinition(
        highRatingText: "High subtitle",
        mediumRatingText: "Medium subtitle",
        lowRatingText: "Low subtitle"
    )

    fileprivate static var ratingData = [
        (
            ratingValue: 3.0, titleDefinition: titleTextDefinition, subtitleDefinition: subtitleTextDefinition,
            accessibilityLabel: "Rated 3 out of 10. Low title.", size: BPKRatingSize.large
        ),
        (
            ratingValue: 5.9, titleDefinition: titleTextDefinition, subtitleDefinition: subtitleTextDefinition,
            accessibilityLabel: "Rated 5.9 out of 10. Low title.", size: BPKRatingSize.large
        ),
        (
            ratingValue: 6.0, titleDefinition: titleTextDefinition, subtitleDefinition: subtitleTextDefinition,
            accessibilityLabel: "Rated 6.0 out of 10. Medium title.", size: BPKRatingSize.base
        ),
        (
            ratingValue: 7.9, titleDefinition: titleTextDefinition, subtitleDefinition: subtitleTextDefinition,
            accessibilityLabel: "Rated 7.9 out of 10. Medium title.", size: BPKRatingSize.small
        ),
        (
            ratingValue: 8.0, titleDefinition: titleTextDefinition, subtitleDefinition: subtitleTextDefinition,
            accessibilityLabel: "Rated 8 out of 10. High title.", size: BPKRatingSize.extraSmall
        ),
        (
            ratingValue: 10.0, titleDefinition: titleTextDefinition, subtitleDefinition: subtitleTextDefinition,
            accessibilityLabel: "Rated 10 out of 10. High title.", size: BPKRatingSize.extraSmall
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(
            ratings.count == RatingsViewController.ratingData.count,
            "The number of rating components does not match the data"
        )
        self.setupRatings()
    }

    func setupRatings() {
        for index in 0...RatingsViewController.ratingData.count - 1 {
            ratings[index].ratingValue = RatingsViewController.ratingData[index].ratingValue
            ratings[index].title = RatingsViewController.ratingData[index].titleDefinition
            ratings[index].accessibilityLabel = RatingsViewController.ratingData[index].accessibilityLabel
            ratings[index].layout = layout
            if showSubtitle {
                ratings[index].subtitle = RatingsViewController.ratingData[index].subtitleDefinition
            }
            if showDifferentSizes {
                ratings[index].size = RatingsViewController.ratingData[index].size
            }
        }
    }
}
