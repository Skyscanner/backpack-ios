//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019 Skyscanner Ltd. All rights reserved.
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

class StarRatingsDocViewController: UIViewController {
    @IBOutlet weak var smallRatingTitle: Label!
    @IBOutlet weak var smallRating: StarRating!
    @IBOutlet weak var largeRatingTitle: Label!
    @IBOutlet weak var largeRating: StarRating!
    @IBOutlet weak var extraLargeRatingTitle: Label!
    @IBOutlet weak var extraLargeRating: StarRating!

    override func viewDidLoad() {
        // Setup titles
        smallRatingTitle.text = "Small rating - 0 out of 5"
        largeRatingTitle.text = "Large rating - 2.8 out of 5"
        extraLargeRatingTitle.text = "Extra large title - 3.5 out of 5"

        // Setup rating values
        smallRating.rating = 0
        largeRating.rating = 2.8
        extraLargeRating.rating = 3.5

        // Setup rating sizes
        smallRating.size = .small
        largeRating.size = .large
        extraLargeRating.size = .xLarge
    }
}
