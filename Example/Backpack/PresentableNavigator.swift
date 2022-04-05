import UIKit

class PresentableNavigator {
    var navigationController: UINavigationController!

    func present(presentable: Presentable) {
        navigationController.pushViewController(presentable.makeViewController(), animated: true)
    }
    
    func present(title: String, groups: [Components.Group]) {
        navigationController.pushViewController(
            GroupsViewController(groups: groups),
            animated: true
        )
    }
}
