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
