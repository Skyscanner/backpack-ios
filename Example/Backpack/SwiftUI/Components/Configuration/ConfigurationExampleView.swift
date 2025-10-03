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

    var body: some View {
        VStack(spacing: .xl) {
            VStack(spacing: .md) {
                Text("Alternate Configuration")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Round corners & custom spacing")
                    .font(.caption)
                    .foregroundColor(.textSecondaryColor)
                
                chipView
                
                dropDownChipView
                
                newTypographyStyles
                
                Spacer()
                
                BPKText("Heading 1 spacing", style: .heading1)
                    .foregroundColor(.black)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Chip Configuration")
        .onDisappear {
            BpkConfiguration.shared.reset()
        }
    }
    
    var chipView: some View {
        HStack(spacing: .md) {
            BPKChip(
                "Chip 1",
                selected: selectedChip1
            ) {
                selectedChip1.toggle()
            }

            BPKChip(
                "Chip 2",
                icon: .heart,
                selected: selectedChip2
            ) {
                selectedChip2.toggle()
            }
        }
    }
    
    var dropDownChipView: some View {
        HStack(spacing: .md) {
            BPKDropdownChip(
                "DropdownChip 1",
                selected: selectedChip3
            ) {
                selectedChip3.toggle()
            }

            BPKDropdownChip(
                "DropdownChip 2",
                icon: .heart,
                selected: selectedChip4
            ) {
                selectedChip4.toggle()
            }
        }
    }
    
    var newTypographyStyles: some View {
        VStack(spacing: 4) {
            BPKText("Editorial 4", style: .editorial4)
                .foregroundColor(.black)
            BPKText("Editorial 5", style: .editorial5)
                .foregroundColor(.black)
            BPKText("Editorial 6", style: .editorial6)
                .foregroundColor(.black)
            BPKText("Display 7", style: .display7)
                .foregroundColor(.black)
        }
    }
}
