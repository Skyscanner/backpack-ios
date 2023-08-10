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
import MapKit

struct ChipGroupSingleSelectWrapExampleView: View {
    @State var selectedChip: Int? = 1
    
    let chips: [BPKSingleSelectChipGroup.ChipItem] = [
        .init(text: "Shenzhen", icon: .city),
        .init(text: "London", icon: .city),
        .init(text: "Edinburgh"),
        .init(text: "Manchester"),
        .init(text: "Belfast"),
        .init(text: "Glasgow")
    ]
    
    var body: some View {
        VStack {
            defaultChip
            onDarkChip
            onImageChip
        }
        .padding()
    }
    
    var defaultChip: some View {
        BPKSingleSelectChipGroup(
            chips: chips,
            style: .default,
            selectedIndex: $selectedChip,
            type: .wrap) { _ in }
            .padding()
    }
    
    var onDarkChip: some View {
        BPKSingleSelectChipGroup(
            chips: chips,
            style: .onDark,
            selectedIndex: $selectedChip,
            type: .wrap) { _ in }
            .padding()
            .background(.surfaceContrastColor)
    }
    
    var onImageChip: some View {
        ZStack {
            let coordsRegion = MKCoordinateRegion(
                center: .init(latitude: 36.7, longitude: -04.4),
                span: .init(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
            Map(coordinateRegion: .constant(coordsRegion))
                .frame(height: 150)
            BPKSingleSelectChipGroup(
                chips: chips,
                style: .onImage,
                selectedIndex: $selectedChip,
                type: .wrap) { _ in }
                .padding()
        }
    }
}

struct ChipGroupSingleSelectWrapExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ChipGroupSingleSelectWrapExampleView()
    }
}
