/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

enum FlareStory: String, StoryGroup {
    case `default` = "Default"
    case flareAtTop = "Flare at top"
    case rounded = "Rounded"
    case backgroundImage = "Background image"
    case animated = "Animated"

    var title: String {
        self.rawValue
    }

    var presentableStory: Presentable {
        let storyboard = loadStoryboard(name: "Main")
        let presentable = storyboard("FlareViewViewController")

        return presentable.enrich {
            let flareViewVC = $0 as? FlareViewViewController

            switch self {
            case .flareAtTop:
                flareViewVC?.flareAtTop = true
            case .rounded:
                flareViewVC?.rounded = true
            case .backgroundImage:
                flareViewVC?.backgroundImage = true
            case .animated:
                flareViewVC?.backgroundImage = true
                flareViewVC?.animated = true
            default: break
            }
        }
    }
}
