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

enum CardStory: String, StoryGroup {
    case `default` = "Default"
    case withoutPadding = "Without padding"
    case selected = "Selected"
    case cornerStyleLarge = "Corner style large"
    case alternativeBackgroundColor = "Background color"

    var title: String {
        self.rawValue
    }

    var presentableStory: Presentable {
        let storyboard = loadStoryboard(name: "Cards")
        let presentable = storyboard("CardsViewController")

        return presentable.enrich {
            let cardVC = $0 as? CardsViewController

            switch self {
            case .default:
                break
            case .withoutPadding:
                cardVC?.padded = false
            case .selected:
                cardVC?.selected = true
            case .cornerStyleLarge:
                cardVC?.cornerStyle = .large
            case .alternativeBackgroundColor:
                cardVC?.backgroundColor = BPKColor.skyBlueTint01
            }
        }
    }
}
