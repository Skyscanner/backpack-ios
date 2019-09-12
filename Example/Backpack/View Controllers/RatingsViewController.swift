/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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
    @IBOutlet var ratings: [Rating]!

    fileprivate static var ratingData = [
        (ratingValue: 3.0, title: "Low title", accessibilityLabel: "Rated 0 out of 10. Low title."),
        (ratingValue: 5.9, title: "Low title", accessibilityLabel: "Rated 2.1 out of 10. Low title."),
        (ratingValue: 6.0, title: "Medium title", accessibilityLabel: "Rated 4.3 out of 10. Medium title."),
        (ratingValue: 7.9, title: "Medium title", accessibilityLabel: "Rated 6.4 out of 10. Medium title."),
        (ratingValue: 8.0, title: "High title", accessibilityLabel: "Rated 8.6 out of 10. High title."),
        (ratingValue: 10.0, title: "High title", accessibilityLabel: "Rated 10 out of 10. High title.")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(ratings.count == RatingsViewController.ratingData.count,
               "The number of rating components does not match the data")
        self.setupRatings()
    }

    func setupRatings() {
        for index in 0...RatingsViewController.ratingData.count - 1 {
            ratings[index].ratingValue = RatingsViewController.ratingData[index].ratingValue
            ratings[index].title = RatingsViewController.ratingData[index].title
            ratings[index].accessibilityLabel = RatingsViewController.ratingData[index].accessibilityLabel
        }
    }
}
