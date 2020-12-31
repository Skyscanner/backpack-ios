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

    static var gradientsItem = Item(name: "Gradients", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Primary", result: Storyboard(storyboardName: "Gradients", storyboardIdentifier: "PrimaryGradientsViewController")),
        Item(name: "Baseline scrim", result: Storyboard(storyboardName: "Gradients", storyboardIdentifier: "GradientsViewController"))
    ])]))
    static var spacingsItem = Item(name: "Spacings", result: Storyboard(storyboardName: "Main", storyboardIdentifier: "SpacingsViewController"))

    static var radiiItem = Item(name: "Radii", result: Storyboard(storyboardName: "Main", storyboardIdentifier: "RadiiViewController"))
    static var shadowsItem = Item(name: "Shadows", result: Storyboard(storyboardName: "Main", storyboardIdentifier: "ShadowsViewController"))
    static var badgesItem = Item(name: "Badges", result: Storyboard(storyboardName: "Badges", storyboardIdentifier: "BadgesViewController"))
    static var barChartsItem = Item(name: "Bar charts", result: Storyboard(storyboardName: "BarCharts", storyboardIdentifier: "BarChartViewController"))
    static var bottomSheetItem = Item(name: "Bottom sheet", result: AppStructure(sections: [ Section(name: "", items: [
        Item(name: "With scroll view", result: Storyboard(storyboardName: "BottomSheet", storyboardIdentifier: "BottomSheetScrollableContentViewController")),
        Item(name: "With bottom section", result: Storyboard(storyboardName: "BottomSheet", storyboardIdentifier: "BottomSheetScrollableContentViewController")),
        Item(name: "Presenting another sheet", result: Storyboard(storyboardName: "BottomSheet", storyboardIdentifier: "BottomSheetScrollableContentViewController")),
        Item(name: "Non-scrollable content", result: Storyboard(storyboardName: "BottomSheet", storyboardIdentifier: "BottomSheetScrollableContentViewController")),
        Item(name: "Resizeable content height", result: Storyboard(storyboardName: "BottomSheet", storyboardIdentifier: "BottomSheetScrollableContentViewController"))
    ])]))
    static var buttonsItem = Item(name: "Buttons", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Primary", result: Storyboard(storyboardName: "Buttons", storyboardIdentifier: "ButtonViewController")),
        Item(name: "Secondary", result: Storyboard(storyboardName: "Buttons", storyboardIdentifier: "ButtonViewController")),
        Item(name: "Destructive", result: Storyboard(storyboardName: "Buttons", storyboardIdentifier: "ButtonViewController")),
        Item(name: "Featured", result: Storyboard(storyboardName: "Buttons", storyboardIdentifier: "ButtonViewController")),
        Item(name: "Link", result: Storyboard(storyboardName: "Buttons", storyboardIdentifier: "ButtonViewController")),
        Item(name: "Outline", result: Storyboard(storyboardName: "Buttons", storyboardIdentifier: "ButtonViewController"))
    ])]))
    static var calendarItem = Item(name: "Calendar", result: AppStructure(sections: [ Section(name: "", items: [
        Item(name: "Default", result: Storyboard(storyboardName: "Calendar", storyboardIdentifier: "CalendarViewController")),
        Item(name: "With max enabled date", result: Storyboard(storyboardName: "Calendar", storyboardIdentifier: "CalendarViewController")),
        Item(name: "Custom styles for specific dates", result: Storyboard(storyboardName: "Calendar", storyboardIdentifier: "CalendarViewController")),
        Item(name: "Default", result: Storyboard(storyboardName: "Calendar", storyboardIdentifier: "CalendarViewController"))
    ])]))
    static var cardsItem = Item(name: "Cards", result: AppStructure(sections: [ Section(name: "", items: [
        Item(name: "Default", result: Storyboard(storyboardName: "Cards", storyboardIdentifier: "CardViewController")),
        Item(name: "Without padding", result: Storyboard(storyboardName: "Cards", storyboardIdentifier: "CardViewController")),
        Item(name: "Selected", result: Storyboard(storyboardName: "Cards", storyboardIdentifier: "CardViewController")),
        Item(name: "Corner style large", result: Storyboard(storyboardName: "Cards", storyboardIdentifier: "CardViewController")),
        Item(name: "Background color", result: Storyboard(storyboardName: "Cards", storyboardIdentifier: "CardViewController")),
        Item(name: "With divider", result: Storyboard(storyboardName: "Cards", storyboardIdentifier: "DividedCardViewController")),
        Item(name: "With divider arranged vertically", result: Storyboard(storyboardName: "Cards", storyboardIdentifier: "DividedCardViewController")),
        Item(name: "With divider without padding", result: Storyboard(storyboardName: "Cards", storyboardIdentifier: "DividedCardViewController")),
        Item(name: "With divider and corner style large", result: Storyboard(storyboardName: "Cards", storyboardIdentifier: "DividedCardViewController"))
    ])]))
    static var chipsItem = Item(name: "Chips", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Default", result: Storyboard(storyboardName: "Chips", storyboardIdentifier: "ChipViewController")),
        Item(name: "With icons", result: Storyboard(storyboardName: "Chips", storyboardIdentifier: "ChipViewController")),
        Item(name: "With background color", result: Storyboard(storyboardName: "Chips", storyboardIdentifier: "ChipViewController")),
        Item(name: "Filled", result: Storyboard(storyboardName: "Chips", storyboardIdentifier: "ChipViewController")),
        Item(name: "Filled with background color", result: Storyboard(storyboardName: "Chips", storyboardIdentifier: "ChipViewController"))
    ])]))
    static var flareItem = Item(name: "Flare views", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Default", result: Storyboard(storyboardName: "FlareView", storyboardIdentifier: "FlareViewsViewController")),
        Item(name: "Flare at top", result: Storyboard(storyboardName: "FlareView", storyboardIdentifier: "FlareViewsViewController")),
        Item(name: "Rounded", result: Storyboard(storyboardName: "FlareView", storyboardIdentifier: "FlareViewsViewController")),
        Item(name: "Background image", result: Storyboard(storyboardName: "FlareView", storyboardIdentifier: "FlareViewsViewController")),
        Item(name: "Animated", result: Storyboard(storyboardName: "FlareView", storyboardIdentifier: "FlareViewsViewController"))
    ])]))

    static var dialogsItem = Item(name: "Dialogs", result: AppStructure(sections: [
        Section(name: "Alert", items: [
            Item(name: "With call to action", result: Storyboard(storyboardName: "Dialogs", storyboardIdentifier: "DialogsViewController")),
            Item(name: "Warning", result: Storyboard(storyboardName: "Dialogs", storyboardIdentifier: "DialogsViewController")),
            Item(name: "With no title", result: Storyboard(storyboardName: "Dialogs", storyboardIdentifier: "DialogsViewController")),
            Item(name: "Extreme", result: Storyboard(storyboardName: "Dialogs", storyboardIdentifier: "DialogsViewController"))
        ]),
        Section(name: "Bottom sheet", items: [
            Item(name: "Delete confirmation", result: Storyboard(storyboardName: "Dialogs", storyboardIdentifier: "DialogsViewController")),
            Item(name: "Success", result: Storyboard(storyboardName: "Dialogs", storyboardIdentifier: "DialogsViewController")),
            Item(name: "With no icon", result: Storyboard(storyboardName: "Dialogs", storyboardIdentifier: "DialogsViewController")),
            Item(name: "With no icon or title", result: Storyboard(storyboardName: "Dialogs", storyboardIdentifier: "DialogsViewController"))
        ]),
        Section(name: "In-app messaging", items: [
            Item(name: "In-app messaging", result: Storyboard(storyboardName: "Dialogs", storyboardIdentifier: "DialogsViewController"))
        ])
    ]))
    static var horizontalNavItem = Item(name: "Horizontal navigation", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Default", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController")),
        Item(name: "Small", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController")),
        Item(name: "Without underline", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController")),
        Item(name: "With icons", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController")),
        Item(name: "Small with icons", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController")),
        Item(name: "Wide", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController")),
        Item(name: "With scroll", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController")),
        Item(name: "Custom items", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController")),
        Item(name: "With notifications", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController")),
        Item(name: "With badge", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController")),
        Item(name: "Alternate", result: Storyboard(storyboardName: "HorizontalNavigation", storyboardIdentifier: "HorizontalNavigationViewController"))
    ])]))
    static var iconsItem = Item(name: "Icons", result: Storyboard(storyboardName: "Main", storyboardIdentifier: "IconsViewController"))
    static var labelsItem = Item(name: "Labels", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Default", result: Storyboard(storyboardName: "Labels", storyboardIdentifier: "LabelsViewController")),
        Item(name: "Emphasized", result: Storyboard(storyboardName: "Labels", storyboardIdentifier: "LabelsViewController")),
        Item(name: "Heavy", result: Storyboard(storyboardName: "Labels", storyboardIdentifier: "LabelsViewController")),
        Item(name: "Performance", result: Storyboard(storyboardName: "Labels", storyboardIdentifier: "LabelsViewController")),
        Item(name: "Multiple font styles", result: Storyboard(storyboardName: "Labels", storyboardIdentifier: "LabelsViewController"))
    ])]))
    static var navigationItem = Item(name: "Navigation bars", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Default", result: Storyboard(storyboardName: "NavigationBar", storyboardIdentifier: "NavigationBarViewController")),
        Item(name: "With buttons", result: Storyboard(storyboardName: "NavigationBar", storyboardIdentifier: "NavigationBarViewController"))
    ])]))
    static var overlayItem = Item(name: "Overlay views", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Default", result: Storyboard(storyboardName: "OverlayView", storyboardIdentifier: "OverlayViewViewController")),
        Item(name: "Overlay type none", result: Storyboard(storyboardName: "OverlayView", storyboardIdentifier: "OverlayViewViewController")),
        Item(name: "Corner style large", result: Storyboard(storyboardName: "OverlayView", storyboardIdentifier: "OverlayViewViewController")),
        Item(name: "Foreground content", result: Storyboard(storyboardName: "OverlayView", storyboardIdentifier: "OverlayViewViewController"))
    ])]))
    static var panelsItem = Item(name: "Panels", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Default", result: Storyboard(storyboardName: "Panel", storyboardIdentifier: "PanelViewController")),
        Item(name: "Without padding", result: Storyboard(storyboardName: "Panel", storyboardIdentifier: "PanelViewController")),
        Item(name: "Elevated", result: Storyboard(storyboardName: "Panel", storyboardIdentifier: "PanelViewController"))
    ])]))
    static var progressItem = Item(name: "Progress bar", result: Storyboard(storyboardName: "ProgressBar", storyboardIdentifier: "ProgressBarViewController"))
    static var ratingItem = Item(name: "Rating", result: Storyboard(storyboardName: "Ratings", storyboardIdentifier: "RatingsViewController"))
    static var snackbarItem = Item(name: "Snackbar", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "With text", result: Storyboard(storyboardName: "Snackbar", storyboardIdentifier: "SnackbarViewController")),
        Item(name: "With text and buttons", result: Storyboard(storyboardName: "Snackbar", storyboardIdentifier: "SnackbarViewController")),
        Item(name: "With title, text and button", result: Storyboard(storyboardName: "Snackbar", storyboardIdentifier: "SnackbarViewController")),
        Item(name: "With text and icon only button", result: Storyboard(storyboardName: "Snackbar", storyboardIdentifier: "SnackbarViewController")),
        Item(name: "With text, button and accessory icon", result: Storyboard(storyboardName: "Snackbar", storyboardIdentifier: "SnackbarViewController")),
        Item(name: "With indefinite duration", result: Storyboard(storyboardName: "Snackbar", storyboardIdentifier: "SnackbarViewController")),
        Item(name: "With long duration", result: Storyboard(storyboardName: "Snackbar", storyboardIdentifier: "SnackbarViewController")),
        Item(name: "With short duration", result: Storyboard(storyboardName: "Snackbar", storyboardIdentifier: "SnackbarViewController")),
        Item(name: "With keyboard", result: Storyboard(storyboardName: "Snackbar", storyboardIdentifier: "SnackbarViewController")),
        Item(name: "With delegate", result: Storyboard(storyboardName: "Snackbar", storyboardIdentifier: "SnackbarViewController"))
    ])]))
    static var spinnersItem = Item(name: "Spinners", result: Storyboard(storyboardName: "Spinners", storyboardIdentifier: "SpinnersViewController"))
    static var starItem = Item(name: "Star ratings", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Interactive", result: Storyboard(storyboardName: "StarRatings", storyboardIdentifier: "StarRatingsViewController")),
        Item(name: "Docs", result: Storyboard(storyboardName: "StarRatings", storyboardIdentifier: "StarRatingsViewController"))
    ])]))
    static var switchesItem = Item(name: "Switches", result: Storyboard(storyboardName: "Switches", storyboardIdentifier: "SwitchesViewController"))
    static var tabItem = Item(name: "Tab bar controller", result: Storyboard(storyboardName: "TabBarControllers", storyboardIdentifier: "TabBarControllerViewController"))
    static var tappableItem = Item(name: "Tappable link labels", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Text with single link", result: Storyboard(storyboardName: "TappableLinkLabels", storyboardIdentifier: "TappableLinkLabelsViewController")),
        Item(name: "Text with multiple link", result: Storyboard(storyboardName: "TappableLinkLabels", storyboardIdentifier: "TappableLinkLabelsViewController")),
        Item(name: "Alternate style", result: Storyboard(storyboardName: "TappableLinkLabels", storyboardIdentifier: "TappableLinkLabelsViewController")),
        Item(name: "Non-URL links", result: Storyboard(storyboardName: "TappableLinkLabels", storyboardIdentifier: "TappableLinkLabelsViewController")),
        Item(name: "Link with custom color", result: Storyboard(storyboardName: "TappableLinkLabels", storyboardIdentifier: "TappableLinkLabelsViewController"))
    ])]))
    static var textFieldsItem = Item(name: "Text fields", result: Storyboard(storyboardName: "TextField", storyboardIdentifier: "TextFieldViewController"))
    static var textViewsItem = Item(name: "Text views", result: Storyboard(storyboardName: "Main", storyboardIdentifier: "TextViewsViewController"))
    static var toastsItem = Item(name: "Toasts", result: AppStructure(sections: [Section(name: "", items: [
        Item(name: "Default", result: Storyboard(storyboardName: "Toasts", storyboardIdentifier: "ToastViewController")),
        Item(name: "Label only", result: Storyboard(storyboardName: "Toasts", storyboardIdentifier: "ToastViewController"))
    ])]))

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
