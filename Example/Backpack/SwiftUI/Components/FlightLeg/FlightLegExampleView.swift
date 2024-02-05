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

struct FlightLegExampleView: View {
    // swiftlint:disable closure_body_length
    // swiftlint:disable line_length
    var body: some View {
        ScrollView {
            BPKCard {
                cardContent()
            }
            .padding()
            
            cardContent(addHeading: true)
                .padding(.md)
                .background(.surfaceDefaultColor)
                .cornerRadius(8)
                .shadow(.sm)
                .padding()
            
            cardContent(addHeading: true)
                .padding(.md)
                .background(.surfaceDefaultColor)
                .cornerRadius(8)
                .shadow(.sm)
                .padding()
        }
    }
    
    @ViewBuilder
    func cardContent(addHeading: Bool = false) -> some View {
        VStack(alignment: .leading) {
            BPKText("Swiss & Lufthansa", style: .heading5)
                .accessibilityAddTraits(addHeading ? .isHeader : .isStaticText)
            BPKFlightLeg(
                departureArrivalTime: "13:45 - 19:15",
                flightDescription: "LHR - BCN",
                stopsInfo: "1 stop",
                highlightStopsInfo: true,
                duration: "4h 30m"
            )
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Outbound: From LHR to BCN. Leaving at 13:45 and arriving at 19:45. Takes 4hours 30 minutes with 1 stop.")
            
            BPKFlightLeg(
                departureArrivalTime: "14:00 - 17:45",
                flightDescription: "LHR - BCN",
                stopsInfo: "1 stop",
                highlightStopsInfo: true,
                duration: "4h 45m"
            )
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Return: From BCN to LHR. Leaving at 14:00 and arriving at 17:45. Takes 4 hours 45 minutes with 1 stop.")
            
            HStack(spacing: .sm) {
                BPKBadge("1", icon: .baggageCabin)
                    .accessibilityLabel("1 cabin bag")
                BPKBadge("0", icon: .baggageChecked)
                    .accessibilityLabel("No checked bags")
                Spacer()
                BPKPrice(price: "£211", size: .small)
                    .accessibilityAddTraits(addHeading ? .isButton : .isStaticText)
            }
        }
    }
}

#Preview {
    FlightLegExampleView()
}
