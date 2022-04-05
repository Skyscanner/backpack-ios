/**
 * Makes a UIViewController by invoking a the supplied custom generator.
 */
struct CustomPresentable: Presentable {
    func makeViewController() -> UIViewController {
        return generateViewController()
    }

    var generateViewController: () -> UIViewController
}
