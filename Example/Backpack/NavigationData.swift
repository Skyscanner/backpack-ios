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

@objc
class NavigationData: NSObject {
    struct Item {
        var name: String?
        var result: Presentable
    }

    struct Section {
        var name: String?
        var items: [Item]?
    }

    struct AppStructure: Presentable {
        func makeViewController() -> UIViewController {
            return BPKRootListTableViewController(structure: self)
        }

        var sections: [Section]
    }

    struct Storyboard: Presentable {
        func makeViewController() -> UIViewController {
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            let viewController: UIViewController =
                storyboard.instantiateViewController(withIdentifier: storyboardIdentifier)
            viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            return viewController
        }

        var storyboardName: String
        var storyboardIdentifier: String
    }

    // Note - structs are a value type, so if you create a new variable
    // referencing an existing struct, it will create a unique copy.

    // swiftlint:disable line_length

    static var coloursItem = Item(name: "Colors", result: Storyboard(storyboardName: "Main", storyboardIdentifier: "ColorsViewController"))
    static var gradientsItem = Item(name: "Gradients", result: Storyboard(storyboardName: "Gradients", storyboardIdentifier: "GradientsViewController"))
    static var spacingsItem = Item(name: "Spacings", result: Storyboard(storyboardName: "Main", storyboardIdentifier: "SpacingsViewController"))
    static var radiiItem = Item(name: "Radii", result: Storyboard(storyboardName: "Main", storyboardIdentifier: "RadiiViewController"))
    static var shadowsItem = Item(name: "Shadows", result: Storyboard(storyboardName: "Main", storyboardIdentifier: "ShadowsViewController"))

    static var badgesItem = Item(name: "Badges", result: Storyboard(storyboardName: "Badges", storyboardIdentifier: "BadgesViewController"))
    static var barChartsItem = Item(name: "Bar charts", result: Storyboard(storyboardName: "BarCharts", storyboardIdentifier: "BarChartsViewController"))
    static var bottomSheetItem = Item(name: "Bottom sheet", result: Storyboard(storyboardName: "BottomSheet", storyboardIdentifier: "BottomSheetViewController"))
    static var buttonsItem = Item(name: "Buttons", result: Storyboard(storyboardName: "Buttons", storyboardIdentifier: "ButtonsViewController"))
    static var calendarItem = Item(name: "Calendar", result: Storyboard(storyboardName: "Calendar", storyboardIdentifier: "CalendarViewController"))
    static var cardsItem = Item(name: "Cards", result: Storyboard(storyboardName: "Cards", storyboardIdentifier: "CardsViewController"))
    static var chipsItem = Item(name: "Chips", result: Storyboard(storyboardName: "Chips", storyboardIdentifier: "ChipsViewController"))
    static var flareItem = Item(name: "Flare views", result: Storyboard(storyboardName: "FlareView", storyboardIdentifier: "FlareViewViewController"))
    static var dialogsItem = Item(name: "Dialogs", result: Storyboard(storyboardName: "Dialogs", storyboardIdentifier: "DialogsViewController"))
    static var horizontalNavItem = Item(name: "Horizontal navigation", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController"))
    static var iconsItem = Item(name: "Icons", result: Storyboard(storyboardName: "Main", storyboardIdentifier: "IconsViewController"))
    static var labelsItem = Item(name: "Labels", result: Storyboard(storyboardName: "Labels", storyboardIdentifier: "LabelsViewController"))
    static var navigationItem = Item(name: "Navigation bars", result: Storyboard(storyboardName: "NavigationBar", storyboardIdentifier: "NavigationBarViewController"))
    static var overlayItem = Item(name: "Overlay views", result: Storyboard(storyboardName: "OverlayView", storyboardIdentifier: "OverlayViewViewController"))
    static var panelsItem = Item(name: "Panels", result: Storyboard(storyboardName: "Panel", storyboardIdentifier: "PanelsViewController"))
    static var progressItem = Item(name: "Progress bar", result: Storyboard(storyboardName: "ProgressBar", storyboardIdentifier: "ProgressBarViewController"))
    static var ratingItem = Item(name: "Rating", result: Storyboard(storyboardName: "Ratings", storyboardIdentifier: "RatingsViewController"))
    static var snackbarItem = Item(name: "Snackbar", result: Storyboard(storyboardName: "Snackbar", storyboardIdentifier: "SnackbarViewController"))
    static var spinnersItem = Item(name: "Spinners", result: Storyboard(storyboardName: "Spinners", storyboardIdentifier: "SpinnersViewController"))
    static var starItem = Item(name: "Star ratings", result: Storyboard(storyboardName: "StarRatings", storyboardIdentifier: "StarRatingsViewController"))
    static var switchesItem = Item(name: "Switches", result: Storyboard(storyboardName: "Switches", storyboardIdentifier: "SwitchesViewController"))
    static var tabItem = Item(name: "Tab bar controller", result: Storyboard(storyboardName: "TabBarControllers", storyboardIdentifier: "TabBarControllersViewController"))
    static var tappableItem = Item(name: "Tappable link labels", result: Storyboard(storyboardName: "TappableLinkLabels", storyboardIdentifier: "TappableLinkLabelsViewController"))
    static var textFieldsItem = Item(name: "Text fields", result: Storyboard(storyboardName: "TextField", storyboardIdentifier: "TextFieldViewController"))
    static var textViewsItem = Item(name: "Text views", result: Storyboard(storyboardName: "Main", storyboardIdentifier: "TextViewsViewController"))
    static var toastsItem = Item(name: "Toasts", result: Storyboard(storyboardName: "Toasts", storyboardIdentifier: "ToastsViewController"))

    // swiftlint:enable line_length

    static var appStructure: AppStructure = AppStructure(sections: [
        Section(name: "Tokens", items: [
            coloursItem,
            gradientsItem,
            spacingsItem,
            radiiItem,
            shadowsItem
        ]),
        Section(name: "Components", items: [
            badgesItem,
            barChartsItem,
            bottomSheetItem,
            buttonsItem,
            calendarItem,
            cardsItem,
            chipsItem,
            flareItem,
            dialogsItem,
            horizontalNavItem,
            iconsItem,
            labelsItem,
            navigationItem,
            overlayItem,
            panelsItem,
            progressItem,
            ratingItem,
            snackbarItem,
            spinnersItem,
            starItem,
            switchesItem,
            tabItem,
            tappableItem,
            textFieldsItem,
            textViewsItem,
            toastsItem
        ])
    ])
}
