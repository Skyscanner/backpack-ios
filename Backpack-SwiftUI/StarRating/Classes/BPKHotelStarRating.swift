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
    @Binding private var rating: Float
    private let maxRating: Int
    private let size: BPKStarRatingSize
    
    /// Initializes a new `BPKHotelStarRating` instance.
    /// - Parameters:
    ///   - rating: A binding to the current rating value.
    ///   - maxRating: The maximum rating value allowed.
    ///   Represents the number of stars to display.
    ///   - size: The size of the star rating, defaults to `.small`.
    public init(
        rating: Binding<Float>,
        maxRating: Int,
        size: BPKStarRatingSize = .small
    ) {
        self._rating = rating
        self.maxRating = maxRating
        self.size = size
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { index in
                if let star = starType(for: index) {
                    BPKStarView(type: star, size: size.starSize)
                        .accessibilityHidden(true)
                }
            }
        }
        .accessibilityElement()
        .accessibilityValue(Text(String(coercedRating)))
    }
    
    private func starType(for index: Int) -> BPKStarView.StarType? {
        let clamped = max(0, min(coercedRating - Float(index), 1))
        guard clamped >= 1 else { return nil }
        return .full
    }
    
    private var coercedRating: Float {
        floor(max(0, min(Float(maxRating), rating)))
    }
}

struct BPKHotelStarRating_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            BPKText("Small", style: .heading3)
            BPKHotelStarRating(rating: .constant(3), maxRating: 5)
            BPKHotelStarRating(rating: .constant(3.5), maxRating: 5)
            BPKHotelStarRating(rating: .constant(4), maxRating: 5)
            BPKText("Large", style: .heading3)
            BPKHotelStarRating(rating: .constant(3), maxRating: 5, size: .large)
            BPKHotelStarRating(rating: .constant(3.5), maxRating: 5, size: .large)
            BPKHotelStarRating(rating: .constant(4), maxRating: 5, size: .large)
        }
    }
}
