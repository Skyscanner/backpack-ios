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

// swiftlint:disable closure_body_length
struct CompactFlightCardView: View {
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOverEnabled
    @Binding var flight: FlightModel
    
    var body: some View {
        VStack(spacing: .md) {
            HStack {
                BPKText(flight.airline, style: .heading5)
                    .accessibilityAddTraits(.isHeader)
                Spacer()
                BPKIconView(
                    flight.isAddedToFavorites ? .heart : .heartOutline,
                    size: .large
                )
            }
            ForEach(flight.legs) { leg in
                LegView(leg: leg)
            }
            
            HStack {
                BPKBadge("1", icon: .baggageCabin)
                    .accessibilityLabel("1 cabin bag")
                BPKBadge("0", icon: .baggageChecked)
                    .accessibilityLabel("No checked bags")
                Spacer()
                BPKPrice(price: flight.price, size: .small)
            }
            .padding(.top, .md)
            
            if voiceOverEnabled {
                HStack {
                    Spacer()
                    BPKButton("Select", icon: .trailing(icon: .longArrowRight)) {
                        tapCard()
                    }
                    .accessiblityLabel("Select")
                    .accessibilityAction(named: favoriteActionLabel) {
                        flight.isAddedToFavorites.toggle()
                    }
                }
            }
        }
        .padding(.base)
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .md))
        .shadow(.sm)
        .onTapGesture {
            tapCard()
        }
    }
    
    var favoriteActionLabel: String {
        if flight.isAddedToFavorites {
            "Remove favorite"
        } else {
            "Add favorite"
        }
    }
    
    func tapCard() {
        print("Tap card")
    }
}

#Preview {
    ZStack {
        Color(BPKColor.canvasColor)
        CompactFlightCardView(flight: .constant(FlightModel.exampleData[0]))
            .padding()
    }
}
