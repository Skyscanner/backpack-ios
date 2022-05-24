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

struct IconsExampleView: View {
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    @State var query: String = ""
    
    var filtered: [Backpack_SwiftUI.BPKIcon] {
        guard query != "" else { return IconsExampleViewContent.allIcons }
        return IconsExampleViewContent.allIcons.filter { icon in
            icon.name.lowercased().contains(query.lowercased())
        }
    }
    
    var body: some View {
        VStack {
            TextField("Filter", text: $query)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            ScrollView {
                iconGroup(title: "Large Icons", size: .large)
                iconGroup(title: "Small Icons", size: .small)
            }
        }
    }
    
    private func iconGroup(title: String, size: Backpack_SwiftUI.BPKIcon.Size) -> some View {
        VStack {
            BPKText(title, style: .heading1)
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(filtered, id: \.name) { icon in
                    VStack {
                        BPKIconView(icon, size: size)
                            .foregroundColor(.primaryColor)
                        BPKText(icon.name, style: .caption)
                    }
                }
            }
        }
    }
}

struct IconsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        IconsExampleView()
    }
}
