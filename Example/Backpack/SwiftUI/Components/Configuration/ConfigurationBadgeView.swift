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
import Backpack_Common

struct ConfigurationBadgeView: View {

    var body: some View {
        ZStack {
            VStack(spacing: .lg) {
                configText
                normalBadge
                subtleBadge
                strongBadge
                successBadge
                warningBadge
                criticalBadge
                VStack {
                    inverseBadge
                    Text("Outline (deprecated -> Inverse)").foregroundColor(.textOnDarkColor)
                    outlineBadge
                }
                .frame(maxWidth: .infinity)
                .background(.corePrimaryColor)
                brandBadge
                Spacer()
            }
        }
        .navigationTitle("Badge Configuration")
        .onDisappear {
            BpkConfiguration.shared.reset()
        }
    }

    var configText: some View {
        VStack(spacing: .md) {

            HStack(alignment: .center, spacing: .xxxl) {
                Text("No icon")
                Text("With icon")
            }
            .padding(.leading, .base)
        }
    }

    var normalBadge: some View {
        HStack(alignment: .center, spacing: .xxxl) {
            BPKBadge("Normal")
            BPKBadge("Normal", icon: .tickCircle)
        }
    }
    
    var subtleBadge: some View {
        HStack(alignment: .center, spacing: .xxxl) {
            BPKBadge("Subtle").badgeStyle(.subtle)
            BPKBadge("Subtle", icon: .tickCircle).badgeStyle(.subtle)
        }
    }

    var strongBadge: some View {
        HStack(alignment: .center, spacing: .xxxl) {
            BPKBadge("Strong").badgeStyle(.strong)
            BPKBadge("Strong", icon: .tickCircle).badgeStyle(.strong)
        }
    }

    var successBadge: some View {
        HStack(alignment: .center, spacing: .xxxxl) {
            BPKBadge("")
            BPKBadge("Success", icon: .tickCircle).badgeStyle(.success)
        }
    }

    var warningBadge: some View {
        HStack(alignment: .center, spacing: .xxxxl) {
            BPKBadge("")
            BPKBadge("Warning", icon: .informationCircle).badgeStyle(.warning)
        }
    }

    var criticalBadge: some View {
        HStack(alignment: .center, spacing: .xxxxl) {
            BPKBadge("")
            BPKBadge("Critical", icon: .exclamation).badgeStyle(.destructive)
        }
    }

    var inverseBadge: some View {
        HStack(alignment: .center, spacing: .xxxl) {
            BPKBadge("Inverse").badgeStyle(.inverse)
            BPKBadge("Inverse", icon: .tickCircle).badgeStyle(.inverse)
        }
        .padding(.top, .base)
    }

    var outlineBadge: some View {
        HStack(alignment: .center, spacing: .xxxl) {
            BPKBadge("Outline").badgeStyle(.outline)
            BPKBadge("Outline", icon: .tickCircle).badgeStyle(.outline)
        }
        .padding(.bottom, .base)
    }

    var brandBadge: some View {
        HStack(alignment: .center, spacing: .xxxl) {
            BPKBadge("Brand").badgeStyle(.brand)
            BPKBadge("Brand", icon: .priceTag).badgeStyle(.brand)
        }
    }
}
