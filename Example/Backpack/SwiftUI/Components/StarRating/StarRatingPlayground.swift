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

struct StarRatingPlayground: View {
    @State var rating: Float = 3.5
    @State var maxRating: Int = 5
    @State var size: BPKStarRatingSize = .small
    @State var rounding: Backpack_SwiftUI.BPKStarRating.Rounding = .down
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                BPKText("Current Rating: \(String(format: "%.1f", rating))", style: .heading3)
                Spacer()
                BPKPanel {
                    starComponents
                }
                Spacer()
            }
            controls
        }
        .padding()
        .background(.canvasColor)
    }
    
    private var starComponents: some View {
        VStack {
            BPKText("Static", style: .heading3)
            BPKStarRating(
                rating: $rating,
                maxRating: maxRating,
                size: size,
                rounding: rounding
            )
            BPKText("Interactive", style: .heading3)
            BPKStarRating(
                rating: $rating,
                maxRating: maxRating,
                size: size,
                rounding: rounding
            ) { selectedRating in
                rating = selectedRating
            }
            BPKText("Hotel Rating", style: .heading3)
            BPKHotelStarRating(
                rating: $rating,
                maxRating: maxRating,
                size: size
            )
        }
    }
    
    private var controls: some View {
        VStack {
            HStack {
                BPKText("Rating:")
                Slider(value: $rating, in: 0...Float(maxRating), step: 0.1)
            }
            HStack {
                BPKText("Max. stars:")
                Spacer()
                BPKNudger(value: $maxRating, min: 1, max: 12)
            }
            HStack {
                BPKText("Size:")
                Picker("Size", selection: $size) {
                    Text("Small").tag(BPKStarRatingSize.small)
                    Text("Large").tag(BPKStarRatingSize.large)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            HStack {
                BPKText("Rounding:")
                Picker("Rounding", selection: $rounding) {
                    Text("Down").tag(Backpack_SwiftUI.BPKStarRating.Rounding.down)
                    Text("Up").tag(Backpack_SwiftUI.BPKStarRating.Rounding.up)
                    Text("Nearest").tag(Backpack_SwiftUI.BPKStarRating.Rounding.nearest)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct StarRatingPlayground_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingPlayground()
    }
}
