//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019. Skyscanner Ltd. All rights reserved.
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
import Backpack

class StarRatingsViewController: UIViewController {
    @IBOutlet weak var defaultSizeTitleLabel: Label!
    @IBOutlet weak var largeSizeTitleLabel: Label!
    @IBOutlet weak var starRatingView: StarRating!
    @IBOutlet weak var largeStarRatingView: StarRating!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var extraLargeRatingView: StarRating!
    override func viewDidLoad() {
        starRatingView.rating = ratingSlider.value
        largeStarRatingView.rating = ratingSlider.value
        largeStarRatingView.size = .large
        extraLargeRatingView.size = .xLarge
        extraLargeRatingView.isUserInteractionEnabled = true
        updateLabels()
    }
    @IBAction func userDidChangeRating(_ sender: UISlider) {
        starRatingView.rating = sender.value
        largeStarRatingView.rating = sender.value
        extraLargeRatingView.rating = sender.value
        updateLabels()
    }
    func updateLabels() {
        defaultSizeTitleLabel.text = String(format: "Default (%.3f out of 5 stars)", ratingSlider.value)
        largeSizeTitleLabel.text = String(format: "Large (%.3f out of 5 stars)", ratingSlider.value)
    }
}
