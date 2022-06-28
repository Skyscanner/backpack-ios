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
            Color(.skyGrayTint06.darkVariant(.black))
                .ignoresSafeArea()
            HStack {
                regularBadges
                iconBadges
            }
        }
    }
    
    var regularBadges: some View {
        VStack(alignment: .leading) {
            BPKBadge("Default")
                .badgeStyle(.`default`)
            BPKBadge("Emphasis")
                .badgeStyle(.emphasis)
            BPKBadge("Success")
                .badgeStyle(.success)
            BPKBadge("Warning")
                .badgeStyle(.warning)
            BPKBadge("Error")
                .badgeStyle(.error)
            BPKBadge("OnDark")
                .badgeStyle(.onDark)
            BPKBadge("Outline")
                .badgeStyle(.outline)
        }
    }
    
    var iconBadges: some View {
        VStack(alignment: .leading) {
            BPKBadge("Default", icon: .tickCircle)
                .badgeStyle(.`default`)
            BPKBadge("Emphasis", icon: .tickCircle)
                .badgeStyle(.emphasis)
            BPKBadge("Success", icon: .tickCircle)
                .badgeStyle(.success)
            BPKBadge("Warning", icon: .helpCircle)
                .badgeStyle(.warning)
            BPKBadge("Error", icon: .closeCircle)
                .badgeStyle(.error)
            BPKBadge("OnDark", icon: .tickCircle)
                .badgeStyle(.onDark)
            BPKBadge("Outline", icon: .tickCircle)
                .badgeStyle(.outline)
        }
    }
}

struct BadgeExampleVIew_Previews: PreviewProvider {
    static var previews: some View {
        BadgeExampleVIew()
    }
}
