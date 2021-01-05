/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

protocol Presentable {
    func makeViewController() -> UIViewController
}

enum ItemValue {
    case story(Presentable)
    case group([Item])
}

protocol ItemConvertible {
    func asItems() -> [Item]
}

struct Item {
    var name: String?
    var result: ItemValue
}

extension Item: ItemConvertible {
    func asItems() -> [Item] {
        return [self]
    }
}

struct Group {
    var name: String
    var items: [Item]

    init(name: String, @AppBuilder builder: () -> [Item]) {
        self.name = name
        self.items = builder()
    }
}

extension Group: ItemConvertible {
    func asItems() -> [Item] {
        return [Item(name: name, result: .group(items))]
    }
}

extension Array: ItemConvertible where Element == Item {
    func asItems() -> [Item] {
        self
    }
}

@_functionBuilder
struct AppBuilder {
    // returns empty array of Items
    static func buildBlock() -> [Item] { [] }
}

extension AppBuilder {
    // maps groups to list of Items
    static func buildBlock(_ groups: ItemConvertible...) -> [Item] {
        groups.flatMap { $0.asItems() }
    }
}

func makeApp(@AppBuilder _ content: () -> [Item]) -> [Item] {
    content()
}

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

func loadStoryboard(name: String) -> (String) -> Presentable {
    let storyboard = UIStoryboard(name: name, bundle: nil)

    return { viewControllerIdentier in
         return StoryboardPresentable(storyboard: storyboard, identifier: viewControllerIdentier)
    }
}

func loadStoryboard(name: String, identifier: String) -> Presentable {
    return loadStoryboard(name: name)(identifier)
}

@objc
class NavigationData: NSObject {

    static var mainStoryboard = loadStoryboard(name: "Main")

    // swiftlint:disable line_length closure_body_length

    static var appStructure: [Item] = makeApp {
        Group(name: "Tokens") {
            Item(name: "Colors", result: .story(mainStoryboard("ColorsViewController")))
            Item(name: "Gradients", result: .story(loadStoryboard(name: "Gradients", identifier: "GradientsViewController")))
            Item(name: "Spacings", result: .story(mainStoryboard("SpacingsViewController")))
            Item(name: "Radii", result: .story(mainStoryboard("RadiiViewController")))
            Item(name: "Shadows", result: .story(mainStoryboard("ShadowsViewController")))
        }
        Group(name: "Components") {
            Item(name: "Badges", result: .story(loadStoryboard(name: "Badges", identifier: "BadgesViewController")))
            Item(name: "Bar charts", result: .story(loadStoryboard(name: "BarCharts", identifier: "BarChartsViewController")))
            Item(name: "Bottom sheet", result: .story(loadStoryboard(name: "BottomSheet", identifier: "BottomSheetViewController")))
            Item(name: "Buttons", result: .story(loadStoryboard(name: "Buttons", identifier: "ButtonsViewController")))
            Item(name: "Calendar", result: .story(loadStoryboard(name: "Calendar", identifier: "CalendarViewController")))
            Item(name: "Cards", result: .story(loadStoryboard(name: "Cards", identifier: "CardsViewController")))
            Item(name: "Chips", result: .story(loadStoryboard(name: "Chips", identifier: "ChipsViewController")))
            Item(name: "Flare views", result: .story(loadStoryboard(name: "FlareView", identifier: "FlareViewViewController")))
            Item(name: "Dialogs", result: .story(loadStoryboard(name: "Dialogs", identifier: "DialogsViewController")))
            Item(name: "Horizontal navigation", result: .story(loadStoryboard(name: "HorizontalNavigation", identifier: "HorizontalNavigationViewController")))
            Item(name: "Icons", result: .story(mainStoryboard("IconsViewController")))
            Item(name: "Labels", result: .story(loadStoryboard(name: "Labels", identifier: "LabelsViewController")))
            Item(name: "Navigation bars", result: .story(loadStoryboard(name: "NavigationBar", identifier: "NavigationBarViewController")))
            Item(name: "Overlay views", result: .story(loadStoryboard(name: "OverlayView", identifier: "OverlayViewViewController")))
            Item(name: "Panels", result: .story(loadStoryboard(name: "Panel", identifier: "PanelsViewController")))
            Item(name: "Progress bar", result: .story(loadStoryboard(name: "ProgressBar", identifier: "ProgressBarViewController")))
            Item(name: "Rating", result: .story(loadStoryboard(name: "Ratings", identifier: "RatingsViewController")))
            Item(name: "Snackbar", result: .story(loadStoryboard(name: "Snackbar", identifier: "SnackbarViewController")))
            Item(name: "Spinners", result: .story(loadStoryboard(name: "Spinners", identifier: "SpinnersViewController")))
            Item(name: "Star ratings", result: .story(loadStoryboard(name: "StarRatings", identifier: "StarRatingsViewController")))
            Item(name: "Switches", result: .story(loadStoryboard(name: "Switches", identifier: "SwitchesViewController")))
            Item(name: "Tab bar controller", result: .story(loadStoryboard(name: "TabBarControllers", identifier: "TabBarControllersViewController")))
            Item(name: "Tappable link labels", result: .story(loadStoryboard(name: "TappableLinkLabels", identifier: "TappableLinkLabelsViewController")))
            Item(name: "Text fields", result: .story(loadStoryboard(name: "TextField", identifier: "TextFieldViewController")))
            Item(name: "Text views", result: .story(mainStoryboard("TextViewsViewController")))
            Item(name: "Toasts", result: .story(loadStoryboard(name: "Toasts", identifier: "ToastsViewController")))
        }
    }
}
