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

import Foundation

struct Tab {
    let title: String
    let groups: [Components.Group]
    let image: UIImage?
    
    static func uikit(groups: [Components.Group]) -> Tab {
        Tab(title: "UIKit", groups: groups, image: BPKIcon.makeLargeTemplateIcon(name: .window))
    }
    
    static func swiftui(groups: [Components.Group]) -> Tab {
        Tab(title: "SwiftUI", groups: groups, image: BPKIcon.makeLargeTemplateIcon(name: .flightTakeoff))
    }
}
