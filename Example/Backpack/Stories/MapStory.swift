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

enum MapStory: String, StoryGroup {
    case `default` = "Default"
    case performance = "Performance"

    var title: String {
        self.rawValue
    }

    var presentableStory: Presentable {
        let storyboard = loadStoryboard(name: "Map")
        let presentable = storyboard("MapsViewController")

        return presentable.enrich {
            let mapViewController = $0 as? MapViewController

            switch self {
            case .performance:
                mapViewController?.testPerformance = true
            default: break
            }
        }
    }
}
