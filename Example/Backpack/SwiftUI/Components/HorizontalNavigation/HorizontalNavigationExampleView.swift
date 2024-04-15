//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
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

struct HorizontalNavigationExampleView: View {
    @State var selectedTab = 0
    
    var body: some View {
        VStack {
            components(size: .default)
            components(size: .small)
        }
    }
    
    private func components(
        size: Backpack_SwiftUI.BPKHorizontalNavigation.Size
    ) -> some View {
        VStack {
            BPKHorizontalNavigation(
                tabs: [
                    .init(title: "One", onClick: { selectedTab = 0 }),
                    .init(title: "Two", onClick: { selectedTab = 1 }),
                    .init(title: "Three", onClick: { selectedTab = 2 })
                ],
                size: size,
                selectedTab: selectedTab
            )
            BPKHorizontalNavigation(
                tabs: [
                    .init(title: "One", icon: .flight, onClick: { selectedTab = 0 }),
                    .init(title: "Two", icon: .flight, onClick: { selectedTab = 1 }),
                    .init(title: "Three", icon: .flight, onClick: { selectedTab = 2 })
                ],
                size: size,
                selectedTab: selectedTab
            )
        }
    }
}

struct HorizontalNavigationExampleView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalNavigationExampleView()
    }
}
