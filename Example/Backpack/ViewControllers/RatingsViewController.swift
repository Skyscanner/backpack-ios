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

import Backpack.Rating

func makeAccessibilityLabel(
    _ showSubtitle: Bool,
    _ titleTextDefinition: BPKRatingTextDefinition,
    _ subtitleTextDefinition: BPKRatingTextDefinition
) -> ((BPKRatingRange, Double) -> String) {
    return { range, value in
        let title = titleTextDefinition.text(for: range)

        if showSubtitle {
            let subtitle = subtitleTextDefinition.text(for: range)

            return "Rated \(value) of 10. \(title). \(subtitle)."
        } else {
            return "Rated \(value) of 10. \(title)."
        }
    }
}

class RatingsViewController: UIViewController {
    struct RatingExample {
        let ratingValue: Double
        let makeStrings: (Bool) -> BPKRatingStrings
        let size: BPKRatingSize
    }

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
        makeRatingData(rating: 3.0, size: .large),
        makeRatingData(rating: 5.9, size: .large),
        makeRatingData(rating: 6.0, size: .base),
        makeRatingData(rating: 7.9, size: .small),
        makeRatingData(rating: 8.0, size: .extraSmall),
        makeRatingData(rating: 10.0, size: .extraSmall)
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
        for (data, rating) in zip(RatingsViewController.ratingData, ratings) {
            rating.ratingValue = data.ratingValue
            rating.strings = data.makeStrings(showSubtitle)
            rating.layout = layout
            if showDifferentSizes {
                rating.size = data.size
            }
        }
    }

    fileprivate static func makeRatingData(
        rating: Double, size: BPKRatingSize
    ) -> RatingExample {
        return RatingExample(
            ratingValue: rating,
            makeStrings: { showSubtitles in
                return BPKSimpleRatingStrings(
                    titleText: titleTextDefinition,
                    subtitleText: showSubtitles ? subtitleTextDefinition : nil,
                    accessibilityLabel: makeAccessibilityLabel(
                        showSubtitles, titleTextDefinition, subtitleTextDefinition)
                )
            },
            size: size
        )
    }
}
