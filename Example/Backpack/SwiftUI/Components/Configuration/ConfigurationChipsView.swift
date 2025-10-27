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

struct ConfigurationChipsView: View {
    @State private var selectedChip1 = false
    @State private var selectedChip2 = true
    @State private var selectedChip3 = false
    
    @State private var style: Backpack_SwiftUI.BPKChipStyle = .default
    @State private var backGroundColor: Color = .clear

    var body: some View {
        ZStack {
            if #available(iOS 17.0, *) {
                Color(backGroundColor)
                    .ignoresSafeArea(edges: .all)
            }
            
            VStack(spacing: .lg) {

                configText
                
                chipViewDefault
                
                dropDownChipView
                
                BPKDismissableChip("Dismiss", style: style, onClick: {
                    
                })
                
                chipViewImage
                
                Spacer()
                
                styleButtons
            }
        }
        .navigationTitle("Chip Configuration")
        .onDisappear {
            BpkConfiguration.shared.reset()
        }
    }
    
    var configText: some View {
        VStack(spacing: .md) {
            Text("Alternate Configuration")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Round corners & custom spacing")
                .font(.caption)
                .foregroundColor(.textSecondaryColor)
            
            HStack(alignment: .center, spacing: .xxxl) {
                Text("Off")
                Text("On")
                Text("Disabled")
            }
            .padding(.leading, .base)
        }
    }
    
    var styleButtons: some View {
        HStack(alignment: .center, spacing: .lg) {
            Button("Default") {
                style = .default
                backGroundColor = .clear
            }
            
            Button("onContrast") {
                style = .default
                backGroundColor = .gray
            }
            
            Button("OnDark") {
                style = .onDark
                backGroundColor = Color(cgColor: BPKColor.surfaceContrastColor.cgColor)
            }
        }
    }
    
    var chipViewDefault: some View {
        HStack(spacing: .lg) {
            BPKChip(
                "Chip 1",
                selected: selectedChip1,
                style: style
            ) {
                selectedChip1.toggle()
            }

            BPKChip(
                "Chip 2",
                selected: selectedChip2,
                style: style
            ) {
                selectedChip2.toggle()
            }
            
            BPKChip(
                "Chip 3",
                selected: selectedChip3,
                style: style
            ) {
                selectedChip3.toggle()
            }
            .disabled(true)
        }
    }
    
    var chipViewImage: some View {
        HStack(spacing: .md) {
            BPKChip(
                "Chip 1",
                icon: .deals,
                selected: selectedChip1,
                style: style
            ) {
                selectedChip1.toggle()
            }

            BPKChip(
                "Chip 2",
                icon: .deals,
                selected: selectedChip2,
                style: style
            ) {
                selectedChip2.toggle()
            }
            
            BPKChip(
                "Chip 3",
                icon: .deals,
                selected: selectedChip3,
                style: style
            ) {}
            .disabled(true)
        }
    }
    
    var dropDownChipView: some View {
        HStack(spacing: .md) {
            BPKDropdownChip(
                "Dropdown",
                selected: selectedChip1,
                style: style
            ) {
                selectedChip1.toggle()
            }

            BPKDropdownChip(
                "Dropdown",
                selected: selectedChip2,
                style: style
            ) {
                selectedChip2.toggle()
            }
            
            BPKDropdownChip(
                "Dropdown",
                selected: selectedChip3,
                style: style
            ) {}
                .disabled(true)
        }
        .padding(.horizontal, .sm)
    }
}
