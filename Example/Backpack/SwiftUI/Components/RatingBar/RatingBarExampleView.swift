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

struct RatingBarExampleView: View {
    
    var body: some View {
        VStack(spacing: .base) {
            ratings(title: "Default", .default)
            ratings(title: "On Contrast", .onContrast)
                .background(.canvasContrastColor)
        }
    }
    
    private func ratings(title: String, _ style: BPKRatingBar.Style) -> some View {
        VStack(alignment: .leading, spacing: .base) {
            BPKText(title, style: .heading4)
            BPKRatingBar(
                label: "Leading text",
                rating: 4.7,
                accessibilityLabel: "Hotel rated 4.7 out of 5",
                style: style
            )
            BPKRatingBar(
                label: "Leading text",
                rating: 4.7,
                accessibilityLabel: "Hotel rated 4.7 out of 10",
                ratingScale: .zeroToTen,
                style: style
            )
            BPKRatingBar(
                label: "Leading text",
                rating: 4.7,
                accessibilityLabel: "Hotel rated 4.7 out of 5",
                showScale: false,
                style: style
            )
        }
        .padding()
    }
}

struct RatingBarExampleView_Previews: PreviewProvider {
    static var previews: some View {
        RatingBarExampleView()
    }
}
