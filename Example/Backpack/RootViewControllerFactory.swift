import UIKit

protocol RootViewControllerFactory {
    func create() -> UIViewController
}

struct DefaultRootViewControllerFactory: RootViewControllerFactory {
    let tokensProvider: TokenCellsProvider
    let componentsProvider: ComponentCellsProvider
    
    func create() -> UIViewController {
        GroupsViewController(
            groups: HomeGroupsProvider(
                tokens: tokensProvider.cells(),
                components: componentsProvider.cells()
            ).groups()
        )
    }
}

struct ThemedViewControllerFactoryDecorator: RootViewControllerFactory {
    let decoratee: () -> UIViewController
    
    func create() -> UIViewController {
        ThemeHelpers.applyAllThemes()
        let activeTheme = ThemeHelpers.themeDefinition(forTheme: Settings.sharedSettings.activeTheme)
        return BPKThemeContainerController(themeDefinition: activeTheme, rootViewController: decoratee())
    }
}
