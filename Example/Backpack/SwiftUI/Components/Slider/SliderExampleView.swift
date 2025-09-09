//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

struct SliderExampleView: View {
    @State var changed: Bool = false
    @State var selectedRange: ClosedRange<Float> = -20...20
    @State var selectedRangeLabels: ClosedRange<Float> = -20...20
    @State var selectedValue: Float = 20
    @State var selectedTimeRange: ClosedRange<Float> = 0...Float((24 * 60) - 1)

    // swiftlint:disable closure_body_length
    var body: some View {
        VStack(alignment: .leading) {
            BPKText("Standard")
            BPKSlider(
                value: $selectedValue,
                sliderBounds: -50...50
            )
            
            BPKText("Range")
            BPKRangeSlider(
                selectedRange: $selectedRange,
                sliderBounds: -50...50,
                minSpacing: 5
            )
            
            BPKText("Range With Thumbnails")
            BPKRangeSlider(
                selectedRange: $selectedRangeLabels,
                sliderBounds: -50...50,
                minSpacing: 5,
                thumbnailLabels: .init(
                    lowerThumbnail: "\(selectedRangeLabels.lowerBound)",
                    upperThumbnail: "\(selectedRangeLabels.upperBound)")
            )

            BPKText("Time range")
            BPKRangeSlider(
                selectedRange: $selectedTimeRange,
                sliderBounds: 0...Float((24 * 60) - 1),
                step: 15,
                thumbnailLabels: .init(
                    lowerThumbnail:
                        "\(Int(selectedTimeRange.lowerBound / 60)):\(Int(selectedTimeRange.lowerBound) % 60)",
                    upperThumbnail:
                        "\(Int(selectedTimeRange.upperBound / 60)):\(Int(selectedTimeRange.upperBound) % 60)")
            ).accessibilityHidden(true)

        }
        .padding()
    }
}

struct SliderExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SliderExampleView()
    }
}
