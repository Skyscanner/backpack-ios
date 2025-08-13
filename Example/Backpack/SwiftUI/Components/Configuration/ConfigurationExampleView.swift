//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

struct ConfigurationExampleView: View {
    @State private var selectedChip1 = false
    @State private var selectedChip2 = false
    @State private var selectedChip3 = false
    @State private var selectedChip4 = false

    // swiftlint:disable closure_body_length
    var body: some View {
        VStack(spacing: .xl) {
            VStack(spacing: .md) {
                Text("Default Configuration")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack(spacing: .md) {
                    BPKChip("Chip 1", selected: selectedChip1) {
                        selectedChip1.toggle()
                    }
                    
                    BPKChip("Chip 2", icon: .heart, selected: selectedChip2) {
                        selectedChip2.toggle()
                    }
                }
            }
            
            VStack(spacing: .md) {
                Text("Alternate Configuration")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Round corners & custom spacing")
                    .font(.caption)
                    .foregroundColor(.textSecondaryColor)
                
                HStack(spacing: .md) {
                    BPKChip(
                        "Chip 3",
                        configOverride: BpkConfiguration.shared,
                        selected: selectedChip3
                    ) {
                        selectedChip3.toggle()
                    }

                    BPKChip(
                        "Chip 4",
                        icon: .heart,
                        configOverride: BpkConfiguration.shared,
                        selected: selectedChip4
                    ) {
                        selectedChip4.toggle()
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Chip Configuration")
    }
}
