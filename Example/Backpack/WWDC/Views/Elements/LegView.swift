//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
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

// swiftlint:disable line_length
struct LegView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    let leg: FlightLegModel

    var body: some View {
        let layout = isHorizontalLayout ? AnyLayout(HStackLayout(spacing: 16)) : AnyLayout(VStackLayout(alignment: .leading, spacing: 16))

        layout {
            if isHorizontalLayout {
                LogoView(a11yLabel: leg.legType)
                    .accessibilitySortPriority(100)
            }
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    if !isHorizontalLayout {
                        LogoView(a11yLabel: leg.legType)
                            .accessibilitySortPriority(100)
                    }
                    BPKText("\(leg.departureTime) - \(leg.returnTime)", style: .heading5)
                }
                BPKText("\(leg.outboundAirport) - \(leg.returnAirport)", style: .caption)
                    .foregroundColor(.textSecondaryColor)
            }
            .accessibilitySortPriority(90)
            if isHorizontalLayout {
                Spacer()
            }
            VStack(alignment: isHorizontalLayout ? .trailing : .leading, spacing: 4) {
                BPKText(leg.stops, style: .label3)
                BPKText(leg.displayDuration, style: .caption)
                    .accessibilityLabel(leg.a11yDuration)
                    .foregroundColor(.textSecondaryColor)
            }
        }
        .accessibilityElement(children: .contain)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var switchPoint: DynamicTypeSize {
        .xxxLarge
    }
    
    private var isHorizontalLayout: Bool {
        dynamicTypeSize < switchPoint
    }
}

#Preview {
    LegView(leg: FlightModel.exampleData[0].legs[0])
}
