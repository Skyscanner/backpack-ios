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

enum ToastStory: String, StoryGroup {
    case docs = "Docs"
    case `default` = "Default"
    case onlyLabels = "With labels only"

    var title: String {
        self.rawValue
    }

    var presentableStory: Presentable {
        let storyboard = loadStoryboard(name: "Main")
        let presentable = storyboard("ToastViewController")

        return presentable.enrich {
            let toastVc = $0 as? ToastViewController
            toastVc?.type = toastViewControllerType
        }
    }

    private var toastViewControllerType: ToastType {
        switch self {
        case .docs:
            return .docs
        case .default:
            return .defaultToast
        case .onlyLabels:
            return .onlyLabels
        }
    }
}
