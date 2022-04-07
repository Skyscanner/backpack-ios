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

import UIKit

/**
 * Makes a UIViewController based on the storyboard name and identifier.
 */
struct StoryboardPresentable: Presentable {
    func makeViewController() -> UIViewController {
        let viewController: UIViewController =
            storyboard.instantiateViewController(withIdentifier: identifier)
        viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        return viewController
    }

    var storyboard: UIStoryboard
    var identifier: String
}

/**
 * Loads a view controller from a given story board and returns a Presentable
 * that can instantiate this view controller.
 *
 * parameter name: The name of the storyboard.
 * parameter identifier: The identifier of the scene.
 * returns: The Presentable which can display the storyboard view controller
 */
func loadStoryboard(name: String, identifier: String) -> Presentable {
    StoryboardPresentable(
        storyboard: UIStoryboard(name: name, bundle: nil),
        identifier: identifier
    )
}
