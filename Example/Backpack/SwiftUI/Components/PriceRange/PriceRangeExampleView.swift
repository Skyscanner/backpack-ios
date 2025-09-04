//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd. All rights reserved.
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

struct PriceRangeExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .xxl) {
            VStack(alignment: .leading) {
                BPKText("Default", style: .heading3)
                defaultExamples()
            }
            
            VStack(alignment: .leading) {
                BPKText("Collapsed", style: .heading3)
                collapsedExamples()
            }
        }
    }
    
    private func defaultExamples() -> some View {
        VStack(spacing: .md) {
            defaultPriceRangeExample(text: "£850", percentage: 85)
            defaultPriceRangeExample(text: "£500", percentage: 50)
            defaultPriceRangeExample(text: "£150", percentage: 15)
        }
        .frame(width: 240)
    }
    
    private func collapsedExamples() -> some View {
        VStack(spacing: .md) {
            collapsedPriceRangeExample(percentage: 90)
            collapsedPriceRangeExample(percentage: 50)
            collapsedPriceRangeExample(percentage: 10)
        }
        .frame(width: 140)
    }
    
    private func defaultPriceRangeExample(text: String, percentage: Double) -> some View {
        BPKPriceRange(configuration: .default(.init(
            marker: .init(text: text, percentage: percentage),
            segments: .init(
                lower: .init(text: "£200", percentage: 20),
                upper: .init(text: "£800", percentage: 80)
            )
        )))
    }
    
    private func collapsedPriceRangeExample(percentage: Double) -> some View {
        BPKPriceRange(configuration: .collapsed(.init(
            markerPercentage: percentage,
            segments: .init(lower: 20, upper: 80)
        )))
    }
}

#Preview {
    PriceRangeExampleView()
}
