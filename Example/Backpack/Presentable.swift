//
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
 * Loads a story board and returns a function that can create
 * a Presentable for a given view controller.
 *
 * parameter name: The name of the storyboard.
 * returns: A function that accespts a scene identifier and returns the presentable
 */
func loadStoryboard(name: String) -> (String) -> Presentable {
    let storyboard = UIStoryboard(name: name, bundle: nil)

    return { sceneIdentier in
        StoryboardPresentable(storyboard: storyboard, identifier: sceneIdentier)
    }
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
    loadStoryboard(name: name)(identifier)
}

/**
 * Makes a UIViewController by invoking a the supplied custom generator.
 */
struct CustomPresentable: Presentable {
    func makeViewController() -> UIViewController {
        return generateViewController()
    }

    var generateViewController: () -> UIViewController
}

/**
 * Given two functions, returns a new function that, when invoked, will invoke the first function,
 * apply the second function to it, and return the resulting value.
 *
 * parameter fun: The function to apply to get the result.
 * parameter map: The function to apply to the result before returning.
 * returns: A function which, when invoked, applies the supplied functions and returns the result.
*/
func enrich<R>(_ fun: @escaping () -> R, _ map: @escaping (R) -> Void) -> () -> R {
    return {
        let result: R = fun()
        map(result)

        return result
    }
}
