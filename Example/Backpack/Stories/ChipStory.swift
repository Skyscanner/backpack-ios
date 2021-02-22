/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2021 Skyscanner Ltd. All rights reserved.
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

enum ChipStory: String, Story {
  case `default` = "Default"
  case withIcons = "With icons"
  case withBackgroundColor = "With background colour"
  case filled = "Filled"
  case filledWithBackgroundColor = "Filled with background colour"

  var presentableStory: Presentable {
    let storyboard = loadStoryboard(name: "Chips")
    let viewController = storyboard("ChipsViewController").makeViewController
    return CustomPresentable(generateViewController: enrich(viewController, {
      let target = $0 as? ChipsViewController
      let filledBackgroundColor: UIColor = .bpk_abisko

      switch self {
      case .withIcons:
        target?.icons = true
      case .withBackgroundColor:
        target?.backgroundTint = filledBackgroundColor
      case .filled:
        target?.style = .filled
      case .filledWithBackgroundColor:
        target?.style = .filled
        target?.backgroundTint = filledBackgroundColor
      default: break
      }
    }))
  }
}
