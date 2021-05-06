/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

enum LabelStory: String, StoryGroup {
    case `default` = "Default"
    case emphasized = "Emphasised"
    case heavy = "Heavy"
    case performance = "Performance"
    case multipleFontStyle = "Multiple font styles"

    var title: String {
        self.rawValue
    }

    var presentableStory: Presentable {
        let storyboard = loadStoryboard(name: "Labels")

        switch self {
        case .default, .emphasized, .heavy:
            let presentable = storyboard("LabelsViewController")

            return presentable.enrich {
                let labelsVc = $0 as? LabelsViewController
                labelsVc?.type = type
            }
        case .performance:
            return storyboard("LabelsPerformanceViewController")
        case .multipleFontStyle:
            return storyboard("LabelMultiFontStyleViewController")
        }
    }

    private var useLabelsViewController: Bool {
        switch self {
        case .default, .emphasized, .heavy:
            return true
        default:
            return false
        }
    }

    private var type: LabelsDisplayType {
        switch self {
        case.default:
            return .normal
        case .emphasized:
            return .emphasized
        case .heavy:
            return .heavy
        case .performance:
            return .normal
        case .multipleFontStyle:
            return .normal
        }
    }
}
