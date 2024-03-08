/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

public struct BPKRatingBar: View {
    private let label: String
    private let rating: Float
    private let accessibilityLabel: String
    private let ratingScale: RatingScale
    private let showScale: Bool
    private let style: Style
    
    /// Initializes a new instance of the `BPKRatingBar` struct.
    /// - Parameters:
    ///   - label: The label for the rating bar.
    ///   - rating: The rating value.
    ///   - accessibilityLabel: The accessibility label for the rating bar.
    ///   - ratingScale: The rating scale for the rating bar. Default value is `.zeroToFive`.
    ///   - showScale: A boolean value indicating whether to show the rating scale. Default value is `true`.
    ///   - style: The style of the rating bar. Default value is `.default`.
    public init(
        label: String,
        rating: Float,
        accessibilityLabel: String,
        ratingScale: RatingScale = .zeroToFive,
        showScale: Bool = true,
        style: Style = .default
    ) {
        self.label = label
        self.rating = rating
        self.accessibilityLabel = accessibilityLabel
        self.ratingScale = ratingScale
        self.showScale = showScale
        self.style = style
    }
    
    public var body: some View {
        VStack(spacing: .md) {
            HStack(alignment: .lastTextBaseline, spacing: .zero) {
                BPKText(label, style: .footnote)
                Spacer()
                if showScale {
                    BPKText("\(rating)", style: .heading5)
                    BPKText("/", style: .caption)
                    BPKText(ratingScale.scaleLabel, style: .caption)
                }
            }
            ZStack {
                Capsule()
                    .foregroundColor(style.ratingBarBackgroundColor)
                    
                GeometryReader { proxy in
                    Capsule()
                        .foregroundColor(.corePrimaryColor)
                        .frame(width: proxy.size.width * CGFloat(calculateValue()))
                }
            }
            .frame(height: .md)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
    }
    
    /// Only to calculate the size of the filled part of the rating bar.
    /// The labels will show the raw rating value and the rating scale,
    /// even if the rating is out of the scale.
    private func calculateValue() -> Float {
        let valueToUse: Float
        if rating > ratingScale.rawScale {
            valueToUse = ratingScale.rawScale
        } else if rating < 0 {
            valueToUse = 0
        } else {
            valueToUse = rating
        }
        return valueToUse / ratingScale.rawScale
    }
}

struct BPKRatingBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKRatingBar(
                label: "Leading",
                rating: 6,
                accessibilityLabel: ""
            )
            BPKRatingBar(
                label: "Leading",
                rating: -1,
                accessibilityLabel: "",
                ratingScale: .zeroToTen
            )
            BPKRatingBar(
                label: "Leading",
                rating: 3.0,
                accessibilityLabel: "",
                showScale: false
            )
        }
        .padding()
        .previewDisplayName("Default")
        
        VStack {
            BPKRatingBar(
                label: "Leading",
                rating: 6,
                accessibilityLabel: "",
                style: .onContrast
            )
            BPKRatingBar(
                label: "Leading",
                rating: -1,
                accessibilityLabel: "",
                ratingScale: .zeroToTen,
                style: .onContrast
            )
            BPKRatingBar(
                label: "Leading",
                rating: 3.0,
                accessibilityLabel: "",
                showScale: false,
                style: .onContrast
            )
        }
        .padding()
        .previewDisplayName("On Contrast")
        .background(.canvasContrastColor)
    }
}
