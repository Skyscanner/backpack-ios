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

enum DividedCardStory: String, StoryGroup {
    case dividedHorizontal = "With divider"
    case dividedHorizontalCornerStyleLarge = "With divider and corner style large"
    case dividedVertical = "With divider arranged vertically"
    case dividedVerticalNoPadding = "With divider without padding"

    var title: String {
        self.rawValue
    }

    var presentableStory: Presentable {
        let storyboard = loadStoryboard(name: "Cards")
        let presentable = storyboard("DividedCardsViewController")

        return presentable.enrich {
            let cardVC = $0 as? DividedCardsViewController

            switch self {
            case .dividedHorizontal:
                cardVC?.divisionDirection = .horizontal
            case .dividedHorizontalCornerStyleLarge:
                cardVC?.divisionDirection = .horizontal
                cardVC?.cornerStyle = .large
            case .dividedVertical:
                cardVC?.divisionDirection = .vertical
            case .dividedVerticalNoPadding:
                cardVC?.divisionDirection = .vertical
                cardVC?.padded = false
            }
        }
    }
}
