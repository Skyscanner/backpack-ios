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

import SwiftUI

/// A view that displays a star rating based on a rating value.
public struct BPKHotelStarRating: View {
    @Binding private var rating: Int
    private let size: BPKStarRatingSize
    
    /// Initializes a new `BPKHotelStarRating` instance.
    /// - Parameters:
    ///   - rating: A binding to the current rating value.
    ///   Represents the number of stars to display.
    ///   - size: The size of the star rating, defaults to `.small`.
    public init(
        rating: Binding<Int>,
        size: BPKStarRatingSize = .small
    ) {
        self._rating = rating
        self.size = size
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<rating, id: \.self) { _ in
                BPKIconView(.star, size: size.starSize)
                    .foregroundColor(.textSecondaryColor)
                    .accessibilityHidden(true)
            }
        }
        .accessibilityElement()
        .accessibilityValue(Text(String(rating)))
    }
}

struct BPKHotelStarRating_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            BPKText("Small", style: .heading3)
            BPKHotelStarRating(rating: .constant(3))
            BPKHotelStarRating(rating: .constant(4))
            BPKText("Large", style: .heading3)
            BPKHotelStarRating(rating: .constant(3), size: .large)
            BPKHotelStarRating(rating: .constant(4), size: .large)
        }
    }
}
