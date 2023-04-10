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
public struct BPKStarRating: View {
    /// An enum representing the rounding method to use.
    /// - down: Rounds down to the nearest half star.
    /// - up: Rounds up to the nearest half star.
    /// - nearest: Rounds to the nearest half star.
    public enum Rounding {
        case down, up, nearest
        
        func roundedRating(_ rating: Float) -> Float {
            switch self {
            case .down: return floor(rating * 2) / 2
            case .up: return ceil(rating * 2) / 2
            case .nearest: return round(rating * 2) / 2
            }
        }
    }
    
    @Binding private var rating: Float
    private let maxRating: Int
    private let size: BPKStarRatingSize
    private let rounding: Rounding
    private let onRatingChanged: ((Float) -> Void)?
    
    /// Initializes a new `BPKStarRating` instance.
    /// - Parameters:
    ///   - rating: A binding to the current rating value.
    ///   - maxRating: The maximum rating value allowed.
    ///   Represents the number of stars to display.
    ///   - size: The size of the star rating, defaults to `.small`.
    ///   - rounding: The rounding method to use, defaults to `.down`.
    ///   - onRatingChanged: A callback that is called when the user taps on a star.
    public init(
        rating: Binding<Float>,
        maxRating: Int,
        size: BPKStarRatingSize = .small,
        rounding: Rounding = .down,
        onRatingChanged: ((Float) -> Void)? = nil
    ) {
        self._rating = rating
        self.maxRating = maxRating
        self.size = size
        self.rounding = rounding
        self.onRatingChanged = onRatingChanged
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { index in
                BPKStarView(type: starType(for: index), size: size.starSize)
                    .onTapGesture {
                        onRatingChanged?(Float(index + 1))
                    } .accessibilityHidden(true)
            }
        }
        .accessibilityElement()
        .accessibilityValue(Text(String(coercedRating)))
        .if(onRatingChanged != nil) { view in
            view.accessibilityAdjustableAction { direction in
                switch direction {
                case .increment: increment()
                case .decrement: decrement()
                @unknown default: break
                }
            }
        }
    }

    private func increment() {
        onRatingChanged?(Float(min(maxRating, Int(coercedRating + 1))))
    }

    private func decrement() {
        onRatingChanged?(Float(max(0, Int(coercedRating - 1))))
    }
    
    private func starType(for index: Int) -> BPKStarView.StarType {
        let clamped = max(0, min(coercedRating - Float(index), 1))
        switch clamped {
        case 0..<0.5: return .empty
        case 0.5..<1: return .half
        default: return .full
        }
    }
    
    private var coercedRating: Float {
        let coercedRating = max(0, min(Float(maxRating), rating))
        return rounding.roundedRating(coercedRating)
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct BPKStarRating_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            BPKText("Small", style: .heading3)
            BPKStarRating(rating: .constant(3), maxRating: 5)
            BPKStarRating(rating: .constant(3.5), maxRating: 5)
            BPKStarRating(rating: .constant(4), maxRating: 5)
            BPKText("Large", style: .heading3)
            BPKStarRating(rating: .constant(3), maxRating: 5, size: .large)
            BPKStarRating(rating: .constant(3.5), maxRating: 5, size: .large)
            BPKStarRating(rating: .constant(4), maxRating: 5, size: .large)
        }
    }
}
