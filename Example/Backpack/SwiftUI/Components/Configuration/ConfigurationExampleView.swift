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
    let chipConfigView = ConfigurationChipsView()
    let typographyConfigView = ConfigurationTypographyView()
    let buttonConfigView = ConfigurationButtonView()
    let badgeConfigView = ConfigurationBadgeView()
    let cardConfigView = ConfigurationCardView()

    var body: some View {
        
        let configViews: [(name: String, destination: () -> AnyView)] = [
            ("Chips", { AnyView(ConfigurationChipsView()) }),
            ("Typography", { AnyView(ConfigurationTypographyView()) }),
            ("Button", { AnyView(ConfigurationButtonView()) }),
            ("Badge", { AnyView(ConfigurationBadgeView()) }),
            ("Card", { AnyView(ConfigurationCardView()) })
        ]
        
        List(configViews, id: \.name) { item in
            NavigationLink(destination: item.destination()) {
                Text(item.name)
            }
        }
        .navigationTitle("Configuration Example")
        .onAppear {
            do {
                let config = BpkConfiguration.shared
                try config.set(
                    chipConfig: true,
                    typographyConfig: true,
                    buttonConfig: true,
                    badgeConfig: true,
                    cardConfig: true
                )
            } catch {
                print("No config set")
            }
        }
    }
}
