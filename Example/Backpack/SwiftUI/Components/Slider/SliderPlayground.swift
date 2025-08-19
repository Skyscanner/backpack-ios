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

struct SliderPlayground: View {
    @State var changed: Bool = false
    @State var selectedRange: ClosedRange<Float> = -20...20
    @State var selectedValue: Float = 20
    @State var minSpacing: Float = 5
    @State var step: Float = 1
    
    var body: some View {
        VStack {
            temperatureControl
            volumeControl
            Spacer()
            VStack {
                HStack {
                    BPKText("Min spacing:")
                    BPKText("\(minSpacing)")
                    Spacer()
                }
                BPKSlider(value: $minSpacing, sliderBounds: -100...100, step: step)
                    .frame(width: 200)
            }
            VStack {
                HStack {
                    BPKText("Step:")
                    BPKText("\(step)")
                    Spacer()
                }
                BPKSlider(value: $step, sliderBounds: 0.1...2, step: 0.1)
                    .frame(width: 200)
            }
        }
        .padding()
    }
    
    private var volumeControl: some View {
        HStack {
            VStack(alignment: .leading) {
                BPKText("Volume")
                BPKText("\(String(format: "%.1f", selectedValue))")
            }
            Spacer()
            BPKSlider(
                value: $selectedValue,
                sliderBounds: 0...100,
                step: step
            )
            .frame(width: 200)
        }
    }
    
    private var temperatureControl: some View {
        HStack {
            VStack(alignment: .leading) {
                BPKText("Temperature")
                HStack(alignment: .firstTextBaseline, spacing: .sm) {
                    BPKText("\(String(format: "%.1f", selectedRange.lowerBound))º")
                    BPKText("/")
                    BPKText("\(String(format: "%.1f", selectedRange.upperBound))º", style: .caption)
                }
            }
            Spacer()
            BPKRangeSlider(
                selectedRange: $selectedRange,
                sliderBounds: -50...50,
                step: step,
                minSpacing: minSpacing
            )
            .frame(width: 200)
        }
    }
}

struct SliderPlayground_Previews: PreviewProvider {
    static var previews: some View {
        SliderPlayground()
    }
}
