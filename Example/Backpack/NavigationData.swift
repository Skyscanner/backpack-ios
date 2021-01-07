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

public struct Item {
    var name: String
    var value: ItemValue
}

extension Item {
    func isGroup() -> Bool {
        switch self.value {
        case .group:
            return true
        default:
            return false
        }
    }

    func isStory() -> Bool {
        switch self.value {
        case .story:
            return true
        default:
            return false
        }
    }

    func subItems() -> [Item]? {
        switch self.value {
        case .group(let items):
            return items
        default:
            return nil
        }
    }
}

extension Item: ItemConvertible {
    func asItems() -> [Item] {
        return [self]
    }
}

public struct Group {
    var name: String
    var items: [Item]

    init(name: String, @AppBuilder builder: () -> [Item]) {
        self.name = name
        self.items = builder()
    }
}

extension Group: ItemConvertible {
    func asItems() -> [Item] {
        return [Item(name: name, value: .group(items))]
    }
}

extension Array: ItemConvertible where Element == Item {
    func asItems() -> [Item] {
        self
    }
}

@_functionBuilder
public struct AppBuilder {
    // returns empty array of Items
    public static func buildBlock() -> [Item] { [] }
}

extension AppBuilder {
    // maps groups to list of Items
    static func buildBlock(_ groups: ItemConvertible...) -> [Item] {
        groups.flatMap { $0.asItems() }
    }
}

public func makeApp(@AppBuilder _ content: () -> [Item]) -> [Item] {
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

public struct Section<T> {
    let name: String?
    let rows: [Row<T>]
}

public struct Row<T> {
    let name: String
    let value: T
}

public func sectionify(items: [Item]) -> [Section<Item>] {
    let groups: [(String, [Item])] = items.compactMap({ group in
            group.subItems().map({
                (group.name, $0)
            })
    })

    let ungroupedItems: [Item] = items.filter({ $0.isStory() })

    var value = groups.map({group in
        Section(name: group.0, rows: group.1.map({ Row(name: $0.name, value: $0) }))
    })

    if ungroupedItems.count > 0 {
        value.append(Section(name: nil, rows: ungroupedItems.map({ Row(name: $0.name, value: $0) })))
    }

    return value
}

@objc
class NavigationData: NSObject {

    static var mainStoryboard = loadStoryboard(name: "Main")

    // swiftlint:disable line_length closure_body_length

    static var appStructure: [Item] = makeApp {
        Group(name: "Tokens") {
            Item(name: "Colors", value: .story(mainStoryboard("ColorsViewController")))
            Group(name: "Gradients") {
                Item(name: "Primary", value: .story(loadStoryboard(name: "Gradients", identifier: "GradientsViewController")))
                Item(name: "Baseline scrim", value: .story(loadStoryboard(name: "Gradients", identifier: "GradientsViewController")))
            }
            Group(name: "Gradients nested") {
                Group(name: "Nest") {
                    Item(name: "Primary", value: .story(loadStoryboard(name: "Gradients", identifier: "GradientsViewController")))
                }
                Group(name: "Nest") {
                    Item(name: "Baseline scrim", value: .story(loadStoryboard(name: "Gradients", identifier: "GradientsViewController")))
                }
            }
            Item(name: "Spacings", value: .story(mainStoryboard("SpacingsViewController")))
            Item(name: "Radii", value: .story(mainStoryboard("RadiiViewController")))
            Item(name: "Shadows", value: .story(mainStoryboard("ShadowsViewController")))
        }
        Group(name: "Components") {
            Item(name: "Badges", value: .story(loadStoryboard(name: "Badges", identifier: "BadgesViewController")))
            Item(name: "Bar charts", value: .story(loadStoryboard(name: "BarCharts", identifier: "BarChartsViewController")))
            Item(name: "Bottom sheet", value: .story(loadStoryboard(name: "BottomSheet", identifier: "BottomSheetViewController")))
            Item(name: "Buttons", value: .story(loadStoryboard(name: "Buttons", identifier: "ButtonsViewController")))
            Item(name: "Calendar", value: .story(loadStoryboard(name: "Calendar", identifier: "CalendarViewController")))
            Item(name: "Cards", value: .story(loadStoryboard(name: "Cards", identifier: "CardsViewController")))
            Item(name: "Chips", value: .story(loadStoryboard(name: "Chips", identifier: "ChipsViewController")))
            Item(name: "Flare views", value: .story(loadStoryboard(name: "FlareView", identifier: "FlareViewViewController")))
            Item(name: "Dialogs", value: .story(loadStoryboard(name: "Dialogs", identifier: "DialogsViewController")))
            Item(name: "Horizontal navigation", value: .story(loadStoryboard(name: "HorizontalNavigation", identifier: "HorizontalNavigationViewController")))
            Item(name: "Icons", value: .story(mainStoryboard("IconsViewController")))
            Item(name: "Labels", value: .story(loadStoryboard(name: "Labels", identifier: "LabelsViewController")))
            Item(name: "Navigation bars", value: .story(loadStoryboard(name: "NavigationBar", identifier: "NavigationBarViewController")))
            Item(name: "Overlay views", value: .story(loadStoryboard(name: "OverlayView", identifier: "OverlayViewViewController")))
            Item(name: "Panels", value: .story(loadStoryboard(name: "Panel", identifier: "PanelsViewController")))
            Item(name: "Progress bar", value: .story(loadStoryboard(name: "ProgressBar", identifier: "ProgressBarViewController")))
            Item(name: "Rating", value: .story(loadStoryboard(name: "Ratings", identifier: "RatingsViewController")))
            Item(name: "Snackbar", value: .story(loadStoryboard(name: "Snackbar", identifier: "SnackbarViewController")))
            Item(name: "Spinners", value: .story(loadStoryboard(name: "Spinners", identifier: "SpinnersViewController")))
            Item(name: "Star ratings", value: .story(loadStoryboard(name: "StarRatings", identifier: "StarRatingsViewController")))
            Item(name: "Switches", value: .story(loadStoryboard(name: "Switches", identifier: "SwitchesViewController")))
            Item(name: "Tab bar controller", value: .story(loadStoryboard(name: "TabBarControllers", identifier: "TabBarControllersViewController")))
            Item(name: "Tappable link labels", value: .story(loadStoryboard(name: "TappableLinkLabels", identifier: "TappableLinkLabelsViewController")))
            Item(name: "Text fields", value: .story(loadStoryboard(name: "TextField", identifier: "TextFieldViewController")))
            Item(name: "Text views", value: .story(mainStoryboard("TextViewsViewController")))
            Item(name: "Toasts", value: .story(loadStoryboard(name: "Toasts", identifier: "ToastsViewController")))
        }
    }
}
