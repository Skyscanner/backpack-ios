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

public struct BPKCardWrapper<HeaderContent: View, WrappedContent: CardWrappable>: View {
    
    private let backgroundColor: BPKColor
    private let header: HeaderContent
    private let card: WrappedContent

    public init(
        backgroundColor: BPKColor,
        @ViewBuilder header: () -> HeaderContent,
        @ViewBuilder card: () -> WrappedContent
    ) {
        self.backgroundColor = backgroundColor
        self.header = header()
        self.card = card()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            header
            card
        }
        .background(backgroundColor)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: .sm)
                .stroke(Color(backgroundColor), lineWidth: 2)
        )
    }
}

struct BPKCardWrapper_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKCardWrapper(backgroundColor: .coreAccentColor) {
                HStack(spacing: 5) {
                    BPKIconView(.flag)
                    BPKText("BPKCard", style: .caption)
                        .foregroundColor(.white)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.md)
            } card: {
                BPKCard(elevation: .none) {
                    Text("Card Content")
                }
            }
            
            BPKCardWrapper(backgroundColor: .corePrimaryColor) {
                HStack(spacing: 5) {
                    BPKIconView(.flag)
                    BPKText("PrimaryColor", style: .caption)
                        .foregroundColor(.white)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.md)
            } card: {
                BPKCard(elevation: .none) {
                    Text("Card Content")
                }
            }
            
            BPKCardWrapper(backgroundColor: .coreAccentColor) {
                HStack(spacing: 5) {
                    BPKIconView(.flag)
                    BPKText("BPKDividedCard", style: .caption)
                        .foregroundColor(.white)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.md)
            } card: {
                BPKDividedCard {
                    Text("Primary Content")
                } secondaryContent: {
                    Text("Secondary Content")
                }
            }
        }
        .padding()
    }
}
