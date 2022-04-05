import UIKit

class PresentableNavigator {
    var navigationController: UINavigationController!
    private let groupsScreenFactory: GroupsViewControllerFactory
    
    init(groupsScreenFactory: GroupsViewControllerFactory) {
        self.groupsScreenFactory = groupsScreenFactory
    }
    
    func present(presentable: Presentable) {
        navigationController.pushViewController(presentable.makeViewController(), animated: true)
    }
    
    func present(title: String, groups: [Components.Group]) {
        let screen = groupsScreenFactory.groupsScreen(title: title, withGroups: groups)
        navigationController.pushViewController(screen, animated: true)
    }
}
