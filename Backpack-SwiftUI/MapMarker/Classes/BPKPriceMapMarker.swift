/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

public struct BPKPriceMapMarker: View {
    
    private let state: State
    private let price: String
    private let icon: Icon?
    
    public init(
        state: State,
        price: String,
        icon: Icon? = nil
    ) {
        self.state = state
        self.price = price
        self.icon = icon
    }
    
    public var body: some View {
        labelView
            .cornerRadius(BPKCornerRadius.sm.value)
            .shadow(.sm)
    }
    
    @ViewBuilder
    private var labelView: some View {
        HStack(spacing: .md) {
            if let icon {
                BPKIconView(icon.bpkIcon)
                    .foregroundColor(iconForegroundColor)
            }
            
            BPKText(price, style: .label3)
                .foregroundColor(state.foregroundColor)
        }
        .padding(.vertical, .sm)
        .padding(.horizontal, .md)
        .background(state.backgroundColor)
    }
    
    private var iconForegroundColor: BPKColor {
        if case .save = icon, state == .unselected {
            return .surfaceHeroColor
        }
        return state.foregroundColor
    }
}

struct BPKPriceMapMarker_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .base) {
            BPKPriceMapMarker(state: .selected, price: "£200")
            BPKPriceMapMarker(state: .unselected, price: "£200")
            BPKPriceMapMarker(state: .previousSelected, price: "£200")
            BPKPriceMapMarker(state: .selected, price: "£200", icon: .custom(.airports))
            BPKPriceMapMarker(state: .unselected, price: "£200", icon: .custom(.airports))
            BPKPriceMapMarker(state: .previousSelected, price: "£200", icon: .custom(.airports))
            BPKPriceMapMarker(state: .unselected, price: "£200", icon: .save)
            BPKPriceMapMarker(state: .selected, price: "£200", icon: .save)
            BPKPriceMapMarker(state: .previousSelected, price: "£200", icon: .save)
        }
    }
}
