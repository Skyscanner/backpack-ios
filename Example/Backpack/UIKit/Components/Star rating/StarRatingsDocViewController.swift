//
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
import Backpack

class StarRatingsDocViewController: UIViewController {
    @IBOutlet weak var smallRatingTitle: BPKLabel!
    @IBOutlet weak var smallRating: BPKStarRating!
    @IBOutlet weak var largeRatingTitle: BPKLabel!
    @IBOutlet weak var largeRating: BPKStarRating!
    @IBOutlet weak var extraLargeRatingTitle: BPKLabel!
    @IBOutlet weak var extraLargeRating: BPKStarRating!
    
    @IBOutlet weak var smallHotelStarRating: BPKHotelStarRating!
    @IBOutlet weak var largeHotelStarRating: BPKHotelStarRating!
    @IBOutlet weak var extraLargeHotelStarRating: BPKHotelStarRating!

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
        
        // Setup hotel star rating
        smallHotelStarRating.rating = 5
        smallHotelStarRating.size = .small
        largeHotelStarRating.rating = 3
        largeHotelStarRating.size = .large
        extraLargeHotelStarRating.rating = 3
        extraLargeHotelStarRating.size = .xLarge
    }
}
