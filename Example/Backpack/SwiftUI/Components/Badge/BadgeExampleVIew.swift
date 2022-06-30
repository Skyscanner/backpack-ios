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
    var body: some View {
        ZStack {
            Color(.backgroundColor)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                makeBadgeRow(text: "Normal", icon: .tickCircle, style: .normal)
                makeBadgeRow(text: "Strong", icon: .tickCircle, style: .strong)
                makeBadgeRow(text: "Success", icon: .tickCircle, style: .success)
                makeBadgeRow(text: "Warning", icon: .helpCircle, style: .warning)
                makeBadgeRow(text: "Destructive", icon: .closeCircle, style: .destructive)
                makeBadgeRow(text: "Inverse", icon: .tickCircle, style: .inverse, background: .skyGray)
                makeBadgeRow(text: "Outline", icon: .tickCircle, style: .outline, background: .skyBlue)
                Spacer()
            }
        }
    }
    
    private func makeBadgeRow(
        text: String,
        icon: Backpack_SwiftUI.BPKIcon,
        style: Backpack_SwiftUI.BPKBadge.Style,
        background: Backpack_SwiftUI.BPKColor = .backgroundColor
    ) -> some View {
        HStack {
            Spacer()
            BPKBadge(text)
                .badgeStyle(style)
            Spacer()
            BPKBadge(text, icon: icon)
                .badgeStyle(style)
            Spacer()
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
