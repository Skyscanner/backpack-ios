

//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

import SwiftUI
import Backpack_SwiftUI

struct StarRatingExampleView: View {
    @State var rating: Float = 3.3
    @State var hotelRating: Int = 3
    
    var body: some View {
        VStack {
            staticStars
            interactiveStars
            hotelStars
        }
    }

    var staticStars: some View {
        VStack {
            BPKText("Static", style: .heading3)
            BPKStarRating(
                rating: $rating,
                maxRating: 5
            )
            .accessibilityLabel("Stars")
            BPKStarRating(
                rating: $rating,
                maxRating: 5,
                size: .large
            )
            .accessibilityLabel("Stars")
        }
    }

    var interactiveStars: some View {
        VStack {
            BPKText("Interactive", style: .heading3)
            BPKStarRating(
                rating: $rating,
                maxRating: 5
            ) { selectedRating in
                rating = selectedRating
            }
            .accessibilityLabel("Stars")
            BPKStarRating(
                rating: $rating,
                maxRating: 5,
                size: .large
            ) { selectedRating in
                rating = selectedRating
            }
            .accessibilityLabel("Stars")
        }
    }

    var hotelStars: some View {
        VStack {
            BPKText("Hotel Rating", style: .heading3)
            BPKHotelStarRating(rating: $hotelRating)
                .accessibilityLabel("Stars")
            BPKHotelStarRating(rating: $hotelRating, size: .large)
                .accessibilityLabel("Stars")
        }
    }
}

struct StarRatingExampleView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingExampleView()
    }
}
