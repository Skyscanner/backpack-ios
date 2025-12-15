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

@available(*, deprecated, message: "We intentionally use this deprecated API.")
class StarRatingsDocViewController: UIViewController {
    @IBOutlet weak var smallRatingTitle: BPKLabel!
    @IBOutlet weak var smallRating: BPKObjcUIKitStarRating!
    @IBOutlet weak var largeRatingTitle: BPKLabel!
    @IBOutlet weak var largeRating: BPKObjcUIKitStarRating!
    
    @IBOutlet weak var smallHotelStarRating: BPKHotelStarRating!
    @IBOutlet weak var largeHotelStarRating: BPKHotelStarRating!

    override func viewDidLoad() {
        // Setup titles
        smallRatingTitle.text = "Small rating - 0 out of 5"
        largeRatingTitle.text = "Large rating - 2.8 out of 5"

        // Setup rating values
        smallRating.rating = 0
        largeRating.rating = 2.8

        // Setup rating sizes
        smallRating.size = .small
        largeRating.size = .large
        
        // Setup hotel star rating
        smallHotelStarRating.rating = 5
        smallHotelStarRating.size = .small
        largeHotelStarRating.rating = 3
        largeHotelStarRating.size = .large
    }
}
