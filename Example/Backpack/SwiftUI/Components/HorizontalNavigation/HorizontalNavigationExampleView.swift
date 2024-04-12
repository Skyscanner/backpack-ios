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
            BPKHorizontalNavigation(
                tabs: [.init(title: "One"), .init(title: "Two"), .init(title: "Three")],
                selectedTab: $selectedTab
            )
            BPKHorizontalNavigation(
                tabs: [
                    .init(title: "One", icon: .flight),
                    .init(title: "Two", icon: .flight),
                    .init(title: "Three", icon: .flight)
                ],
                selectedTab: $selectedTab
            )
            BPKHorizontalNavigation(
                tabs: [.init(title: "One"), .init(title: "Two"), .init(title: "Three")],
                size: .small,
                selectedTab: $selectedTab
            )
            BPKHorizontalNavigation(
                tabs: [
                    .init(title: "One", icon: .flight),
                    .init(title: "Two", icon: .flight),
                    .init(title: "Three", icon: .flight)
                ],
                size: .small,
                selectedTab: $selectedTab
            )
        }
    }
}

struct HorizontalNavigationExampleView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalNavigationExampleView()
    }
}
