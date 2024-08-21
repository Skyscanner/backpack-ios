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

struct SearchControlInputExampleView: View {
    
    let places = ["London (any)", "Barcelona", "Everywhere", "Spain", "Paris"]
    let dates = ["Aug 10", "14 - 18 Sep", "Sep", "Oct - Nov"]
    let accessibilityDates = [
        "Aug 10": "August 10",
        "14 - 18 Sep": "14th September to 18th September",
        "Sep": "September",
        "Oct - Nov": "October to November"
    ]
    let travellers = [
        "1 Adult, Economy",
        "2 Travelers, Business",
        "4 Travelers, Economy",
        "1 Adult, First",
        "3 Travelers, Premium Economy"
    ]
    
    @State var origin: String?
    @State var destination: String?
    @State var date: String?
    @State var traveller: String?
        
    var body: some View {
        // swiftlint:disable closure_body_length
        VStack(spacing: 2) {
            BPKSearchControlInput(
                placeholder: "Choose origin",
                value: origin,
                icon: .origin,
                style: .regular,
                accessibilityLabel: "From",
                action: { origin = "Paris" }
            )
            .accessibilityIdentifier("search_control_input_origin")
            BPKSearchControlInput(
                placeholder: "Choose destination",
                value: destination,
                icon: .cityCenter,
                style: .regular,
                accessibilityLabel: "To",
                action: { destination = places.randomElement() }
            )
            .accessibilityIdentifier("search_control_input_destination")
            HStack(spacing: 2) {
                BPKSearchControlInput(
                    placeholder: "Choose dates",
                    value: date,
                    icon: .calendar,
                    style: .regular,
                    accessibilityLabel: "Dates",
                    accessibilityValueHandler: {
                        guard let date else { return "" }
                        return accessibilityDates[date] ?? ""
                    },
                    action: { date = dates.randomElement() }
                )
                .accessibilityIdentifier("search_control_input_dates")
                BPKSearchControlInput(
                    placeholder: "Choose travellers",
                    value: traveller,
                    icon: .account,
                    style: .regular,
                    accessibilityLabel: "Travellers",
                    action: { traveller = travellers.randomElement() }
                )
                .accessibilityIdentifier("search_control_input_travellers")
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
        .background(.surfaceContrastColor)
    }
}

struct SearchControlInputExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchControlInputExampleView()
    }
}
