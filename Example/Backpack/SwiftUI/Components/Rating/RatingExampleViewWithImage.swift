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

struct RatingExampleViewWithImage: View {

    private let isDefaultSizes = [true, false]
    private let subtitles = ["1,532 reviews", nil]
    private let showScaleAndShowZeroToFive: [(showScale: Bool, showZeroToFive: Bool)] = [
        (showScale: true, showZeroToFive: true),
        (showScale: true, showZeroToFive: false),
        (showScale: false, showZeroToFive: true)
    ]
    private let value: Float = 4.5

    var body: some View {
        VStack(alignment: .leading, spacing: BPKSpacing.sm.value) {
            ForEach(isDefaultSizes, id: \.self) { isDefaultSize in
                ForEach(subtitles, id: \.self) { subtitle in
                    ForEach(showScaleAndShowZeroToFive.indices, id: \.self) { index in

                        let (showScale, showZeroToFive) = showScaleAndShowZeroToFive[index]
                        let scale = showZeroToFive ? "5" : "10"
                        let subtitleAccessibilityLabel = subtitle != nil ? "Base on \(subtitles)" : ""
                        let accessibilityLabel = "Rated Excellent, 4.5 out of \(scale). \(subtitleAccessibilityLabel)"

                        BPKRating(
                            value: value,
                            ratingScale: showZeroToFive ? .zeroToFive: .zeroToTen,
                            size: isDefaultSize ? .default: .large,
                            subtitle: subtitle,
                            showScale: showScale
                        ) {
                            Image("backpack-logo-horizontal")
                                .resizable()
                                .frame(width: 110, height: 24)
                                .aspectRatio(contentMode: .fit)
                        }.accessibilityLabel(accessibilityLabel)
                    }
                }
            }
        }
    }
}

struct RatingExampleViewWithImage_Previews: PreviewProvider {
    static var previews: some View {
        RatingExampleViewWithImage()
    }
}
