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

private func loadDialogController() -> Presentable {
    let storyboard = loadStoryboard(name: "Main")
    return storyboard("DialogViewController")
}

struct DialogStory {
    enum Alert: String, StoryGroup {
        case withCallToAction = "With call to action"
        case warning = "Warning"
        case withNoTitle = "With no title"
        case extreme = "Extreme"

        var title: String {
            self.rawValue
        }

        var presentableStory: Presentable {
            let presentable = loadDialogController()

            return presentable.enrich {
                let dialogVC = $0 as? DialogViewController
                dialogVC?.type = type
            }
        }

        var type: DialogType {
            switch self {
            case .withCallToAction:
                return .normal
            case .warning:
                return .warning
            case .withNoTitle:
                return .noTitle
            case .extreme:
                return .extreme
            }
        }
    }

    enum BottomSheet: String, StoryGroup {
        case deleteConfirmation = "Delete confirmation"
        case success = "Success"
        case withNoIcon = "With no icon"
        case withNoIconAndNoTitle = "With no icon and no title"

        var title: String {
            self.rawValue
        }

        var presentableStory: Presentable {
            let presentable = loadDialogController()

            return presentable.enrich {
                let dialogVC = $0 as? DialogViewController
                dialogVC?.type = type
            }
        }

        var type: DialogType {
            switch self {
            case .deleteConfirmation:
                return .delete
            case .success:
                return .confirmation
            case .withNoIcon:
                return .noIcon
            case .withNoIconAndNoTitle:
                return .noIconNoTitle
            }
        }
    }

    enum InAppMessaging: String, StoryGroup {
        case inAppMessaing = "In-app messaging"

        var title: String {
            self.rawValue
        }

        var presentableStory: Presentable {
            let presentable = loadDialogController()

            return presentable.enrich {
                let dialogVC = $0 as? DialogViewController
                dialogVC?.type = type
            }
        }

        var type: DialogType {
            switch self {
            case .inAppMessaing:
                return .inAppMessaging
            }
        }
    }
}
