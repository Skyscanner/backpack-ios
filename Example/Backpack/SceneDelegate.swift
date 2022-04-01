//
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
import Backpack

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let window = UIWindowFactory().window(forScene: scene) else { return }
        
        let groupsScreenFactory = GroupsViewControllerFactory(settingsButton: settingsButton)
        let presentableNavigator = PresentableNavigator(groupsScreenFactory: groupsScreenFactory)
        let groups = HomeGroupsProvider(
            onPresentableSelected: presentableNavigator.present(presentable:),
            goToChildGroups: presentableNavigator.present(title:groups:),
            buttonGroups: ButtonsGroupsProvider(onPresentableSelected: presentableNavigator.present(presentable:))
        ).groups()
        let rootTableViewController = groupsScreenFactory
            .groupsScreen(title: "Backpack", withGroups: groups)
        let navigationController = UINavigationController(rootViewController: rootTableViewController)
        presentableNavigator.navigationController = navigationController
        window.rootViewController = navigationController
        
        if let rootVc = window.rootViewController, ThemeHelpers.isThemingSupported() {
            ThemeHelpers.applyAllThemes()
            let activeTheme = ThemeHelpers.themeDefinition(forTheme: Settings.sharedSettings.activeTheme)
            let themeController = BPKThemeContainerController(themeDefinition: activeTheme, rootViewController: rootVc)
            window.rootViewController = themeController
        }
        
        self.window = window
        window.makeKeyAndVisible()
        
        if ThemeHelpers.forceDarkMode() {
            self.window?.overrideUserInterfaceStyle = .dark
        }
    }
    
    private var settingsButton: UIBarButtonItem? {
        if !ThemeHelpers.isThemingSupported() { return nil }
        let settingsButton = UIBarButtonItem()
        settingsButton.image = BPKIcon.makeLargeTemplateIcon(name: .settings)
        settingsButton.accessibilityLabel = "Settings"
        settingsButton.target = self
        settingsButton.action = #selector(didTapSettingsButton)
        return settingsButton
    }
    
    @objc
    private func didTapSettingsButton() {
        ExampleApp(getKeyWindow: {
            UIApplication.shared.windows.first(where: \.isKeyWindow)
        }).showSettingsView()
    }
}

protocol GroupsProvider {
    func groups() -> [Components.Group]
}

struct HomeGroupsProvider: GroupsProvider {
    let onPresentableSelected: (Presentable) -> Void
    let goToChildGroups: (String, [Components.Group]) -> Void
    let buttonGroups: GroupsProvider
    
    private func presentableCell(
        _ title: String,
        storyboardName: String? = nil,
        storyboardIdentifier: String
    ) -> Components.Cell {
        Components.Cell(title: title, onSelection: {
            let presentable = loadStoryboard(name: storyboardName ?? title, identifier: storyboardIdentifier)
            self.onPresentableSelected(presentable)
        })
    }
    
    private func presentableGroupCell(_ title: String, groups: [Components.Group]) -> Components.Cell {
        Components.Cell(title: title) { self.goToChildGroups(title, groups) }
    }
    
    private func presentableGroupCell(_ title: String, provider: GroupsProvider) -> Components.Cell {
        presentableGroupCell(title, groups: provider.groups())
    }
    
    private func presentableGroupCell(_ group: Components.Group) -> Components.Cell {
        presentableGroupCell(group.title, groups: [
            Components.Group(title: group.title, cells: group.cells)
        ])
    }
    
    private func gradients() -> Components.Cell { presentableGroupCell(
        Components.Group(
            title: "Gradients",
            cells: [
                presentableCell(
                    "Primary",
                    storyboardName: "Gradients",
                    storyboardIdentifier: "PrimaryGradientViewController"
                ),
                presentableCell(
                    "Baseline Scrim",
                    storyboardName: "Gradients",
                    storyboardIdentifier: "GradientViewController"
                )
            ]
        )
    )}
    private func barCharts() -> Components.Cell { presentableCell(
        "Bar charts",
        storyboardName: "BarCharts",
        storyboardIdentifier: "BarChartsViewController"
    )}
    private func bottomSheet() -> Components.Cell { presentableCell(
        "Bottom sheet",
        storyboardName: "BottomSheet",
        storyboardIdentifier: "BottomSheetViewController"
    )}
    func groups() -> [Components.Group] {
        [
            Components.Group(
                title: "Components",
                cells: [
                    presentableCell("Colors", storyboardName: "Main", storyboardIdentifier: "ColorsViewController"),
                    gradients(),
                    presentableCell("Spacings", storyboardIdentifier: "SpacingsViewController"),
                    presentableCell("Radii", storyboardIdentifier: "RadiiViewController"),
                    presentableCell("Shadows", storyboardIdentifier: "ShadowsViewController")
                ]
            ),
            Components.Group(
                title: "Components",
                cells: [
                    presentableCell("Badges", storyboardIdentifier: "BadgesViewController"),
                    barCharts(),
                    bottomSheet(),
                    presentableGroupCell("Buttons", provider: buttonGroups)
                ]
            )
        ]
    }
}

struct ButtonsGroupsProvider: GroupsProvider {
    let onPresentableSelected: (Presentable) -> Void
    
    private func enrich(screen: UIViewController, style: BPKButtonStyle) {
        guard let screen = screen as? BPKButtonsViewController else {
            return
        }
        screen.style = style
    }
    
    private func presentableCell(_ name: String, style: BPKButtonStyle) -> Components.Cell {
        let presentable = loadStoryboard(name: "Buttons", identifier: "ButtonsViewController")
            .enrich { enrich(screen: $0, style: style) }
        return Components.Cell(title: name) { self.onPresentableSelected(presentable) }
    }
    
    func groups() -> [Components.Group] {
        [
            Components.Group(
                title: "Buttons",
                cells: [
                    presentableCell("Primary", style: .primary),
                    presentableCell("Secondary", style: .secondary),
                    presentableCell("Destructive", style: .destructive),
                    presentableCell("Featured", style: .featured),
                    presentableCell("Link", style: .link),
                    presentableCell("Primary On Dark", style: .primaryOnDark),
                    presentableCell("Primary On Light", style: .primaryOnLight)
                ]
            )
        ]
    }
}

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
