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

struct BadgeExampleVIew: View {
    @State private var tappedBadge: String?

    var body: some View {
        ZStack {
            Color(.canvasColor)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    if let tappedBadge {
                        BPKText("Tapped: \(tappedBadge)", style: .footnote)
                            .padding()
                    }
                    makeBadgeRow(text: "Normal", icon: .tickCircle, style: .normal)
                    makeBadgeRow(text: "Subtle", icon: .tickCircle, style: .subtle)
                    makeBadgeRow(text: "Strong", icon: .tickCircle, style: .strong)
                    makeBadgeRow(text: "Success", icon: .tickCircle, style: .success)
                    makeBadgeRow(text: "Warning", icon: .informationCircle, style: .warning)
                    makeBadgeRow(text: "Critical", icon: .exclamation, style: .destructive)
                    makeBadgeRow(text: "Inverse", icon: .tickCircle, style: .inverse, background: .corePrimaryColor)
                    makeBadgeRow(text: "Outline", icon: .tickCircle, style: .outline, background: .corePrimaryColor)
                    makeBadgeRow(text: "Brand", icon: .priceTag, style: .brand)
                    makeBadgeRow(text: "Loyalty", icon: .informationCircle, style: .loyalty)
                }
            }
        }
    }

    private func makeBadgeRow(
        text: String,
        icon: Backpack_SwiftUI.BPKIcon,
        style: Backpack_SwiftUI.BPKBadge.Style,
        background: Backpack_SwiftUI.BPKColor = .canvasColor
    ) -> some View {
        VStack(spacing: BPKSpacing.sm.value) {
            HStack {
                Spacer()
                if ![BPKBadge.Style.success, BPKBadge.Style.warning, BPKBadge.Style.destructive].contains(style) {
                    BPKBadge(text)
                        .badgeStyle(style)
                } else {
                    Spacer()
                }
                Spacer()
                BPKBadge(text, icon: icon)
                    .badgeStyle(style)
                Spacer()
                // BPKBadge itself is purely presentational: it owns the fixed trailing
                // information glyph but not the tap handling. The app wraps it in its own
                // Button and sets its own accessibility label/traits, same as the
                // itinerary emissions badge POC does.
                Button {
                    tappedBadge = text
                } label: {
                    BPKBadge(text)
                        .badgeStyle(style)
                        .interactive()
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(.isButton)
                Spacer()
                Button {
                    tappedBadge = text
                } label: {
                    BPKBadge(text, icon: icon)
                        .badgeStyle(style)
                        .interactive()
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(.isButton)
                Spacer()
            }
        }
        .padding()
        .background(background)
    }
}

struct BadgeExampleVIew_Previews: PreviewProvider {
    static var previews: some View {
        BadgeExampleVIew()
    }
}
