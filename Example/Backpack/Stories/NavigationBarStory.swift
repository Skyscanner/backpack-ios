//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

enum NavigationBarStory: String, StoryGroup {
    case `default` = "Default"
    case withButtons = "With buttons"
    case witHeaders = "With headers"

    var title: String {
        self.rawValue
    }

    var presentableStory: Presentable {
        let storyboard = loadStoryboard(name: "Main")
        let presentable = storyboard("NavigationBarViewController")

        return presentable.enrich {
            let navVc = $0 as? NavigationBarViewController

            switch self {
            case .default:
                break
            case .withButtons:
                navVc?.showButtons = true
            case .witHeaders:
                navVc?.showHeaders = true
            }
        }
    }
}
