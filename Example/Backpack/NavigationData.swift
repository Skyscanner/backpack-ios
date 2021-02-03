/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

class NavigationData: NSObject {
    static var mainStoryboard = loadStoryboard(name: "Main")
    static var buttonsStoryboard = loadStoryboard(name: "Buttons")
    static var calendarStoryboard = loadStoryboard(name: "Calendar")
    static var cardStoryboard = loadStoryboard(name: "Cards")

    static func setButtonStyle(style: BPKButtonStyle) -> (UIViewController) -> Void {
        return {storyboardVC in
            guard let buttonsVC = storyboardVC as? BPKButtonsViewController else {
                return
            }

            buttonsVC.style = style
        }
    }

    static func buttonStoryboard(style: BPKButtonStyle) -> Presentable {
        return CustomPresentable(generateViewController:
            enrich(
                buttonsStoryboard("ButtonsViewController").makeViewController,
                setButtonStyle(style: style)
            )
        )
    }

    enum CalendarStory: String {
        case `default`
        case withMaxEnabledDate
        case withCustomStyles
        case withPrices
        case alternativeBackgroundColor
    }

    static func setCalendarProperties(story: CalendarStory) -> (UIViewController) -> Void {
        return {storyboardVC in
            guard let calendarVC = storyboardVC as? CalendarViewController else {
                return
            }

            switch story {
            case .default:
                break
            case .withMaxEnabledDate:
                calendarVC.maxEnabledDate = true
            case .withCustomStyles:
                calendarVC.customStylesForDates = true
            case .withPrices:
                calendarVC.showPrices = true
            case .alternativeBackgroundColor:
                calendarVC.alternativeBackgroundColor = true
            }
        }
    }

    static func calendarStoryboard(story: CalendarStory) -> Presentable {
        return CustomPresentable(generateViewController:
            enrich(
                calendarStoryboard("CalendarViewController").makeViewController,
                setCalendarProperties(story: story)
            )
        )
    }

    enum CardStory: String {
        case `default`
        case withoutPadding
        case selected
        case cornerStyleLarge
        case alternativeBackgroundColor
    }

    static func setCardProperties(story: CardStory) -> (UIViewController) -> Void {
        return {storyboardVC in
            guard let cardVC = storyboardVC as? CardsViewController else {
                return
            }

            switch story {
            case .default:
                break
            case .withoutPadding:
                cardVC.padded = false
            case .selected:
                cardVC.selected = true
            case .cornerStyleLarge:
                cardVC.cornerStyle = .large
            case .alternativeBackgroundColor:
                cardVC.backgroundColor = BPKColor.skyBlueTint01
            }
        }
    }

    static func cardStoryboard(story: CardStory) -> Presentable {
        return CustomPresentable(generateViewController:
            enrich(
                cardStoryboard("CardsViewController").makeViewController,
                setCardProperties(story: story)
            )
        )
    }

    enum DividedCardStory: String {
        case dividedHorizontal
        case dividedHorizontalCornerStyleLarge
        case dividedVertical
        case dividedVerticalNoPadding
    }

    static func setDividedCardProperties(story: DividedCardStory) -> (UIViewController) -> Void {
        return {storyboardVC in
            guard let cardVC = storyboardVC as? DividedCardsViewController else {
                return
            }

            switch story {
            case .dividedHorizontal:
                cardVC.divisionDirection = .horizontal
            case .dividedHorizontalCornerStyleLarge:
                cardVC.divisionDirection = .horizontal
                cardVC.cornerStyle = .large
            case .dividedVertical:
                cardVC.divisionDirection = .vertical
            case .dividedVerticalNoPadding:
                cardVC.divisionDirection = .vertical
                cardVC.padded = false
            }
        }
    }

    static func dividedCardStoryboard(story: DividedCardStory) -> Presentable {
        return CustomPresentable(generateViewController:
            enrich(
                cardStoryboard("DividedCardsViewController").makeViewController,
                setDividedCardProperties(story: story)
            )
        )
    }

    // swiftlint:disable line_length closure_body_length

    static var appStructure: [Item] = makeApp {
        Group(name: "Tokens") {
            Item(name: "Colors", value: .story(mainStoryboard("ColorsViewController")))
            Group(name: "Gradients") {
                Item(
                    name: "Primary",
                    value: .story(loadStoryboard(name: "Gradients", identifier: "PrimaryGradientViewController"))
                )
                Item(
                    name: "Baseline Scrim",
                    value: .story(loadStoryboard(name: "Gradients", identifier: "GradientViewController"))
                )
            }
            Item(name: "Gradients", value: .story(loadStoryboard(name: "Gradients", identifier: "GradientsViewController")))
            Item(name: "Spacings", value: .story(mainStoryboard("SpacingsViewController")))
            Item(name: "Radii", value: .story(mainStoryboard("RadiiViewController")))
            Item(name: "Shadows", value: .story(mainStoryboard("ShadowsViewController")))
        }
        Group(name: "Components") {
            Item(name: "Badges", value: .story(loadStoryboard(name: "Badges", identifier: "BadgesViewController")))
            Item(name: "Bar charts", value: .story(loadStoryboard(name: "BarCharts", identifier: "BarChartsViewController")))
            Item(name: "Bottom sheet", value: .story(loadStoryboard(name: "BottomSheet", identifier: "BottomSheetViewController")))
            Group(name: "Buttons") {
                Item(name: "Primary", value: .story(buttonStoryboard(style: .primary)))
                Item(name: "Secondary", value: .story(buttonStoryboard(style: .secondary)))
                Item(name: "Destructive", value: .story(buttonStoryboard(style: .destructive)))
                Item(name: "Featured", value: .story(buttonStoryboard(style: .featured)))
                Item(name: "Link", value: .story(buttonStoryboard(style: .link)))
                Item(name: "Outline", value: .story(buttonStoryboard(style: .outline)))
            }
            Group(name: "Calendar") {
                Item(name: "Default", value: .story(calendarStoryboard(story: .default)))
                Item(name: "With max enabled date", value: .story(calendarStoryboard(story: .withMaxEnabledDate)))
                Item(name: "Custom styles for specific dates", value: .story(calendarStoryboard(story: .withCustomStyles)))
                Item(name: "With prices", value: .story(calendarStoryboard(story: .withPrices)))
                Item(name: "With alternative background color", value: .story(calendarStoryboard(story: .alternativeBackgroundColor)))
            }
            Group(name: "Cards") {
                Item(name: "Default", value: .story(cardStoryboard(story: .default)))
                Item(name: "Without padding", value: .story(cardStoryboard(story: .withoutPadding)))
                Item(name: "Selected", value: .story(cardStoryboard(story: .selected)))
                Item(name: "Corner style large", value: .story(cardStoryboard(story: .cornerStyleLarge)))
                Item(name: "Background color", value: .story(cardStoryboard(story: .alternativeBackgroundColor)))
                Item(name: "With divider", value: .story(dividedCardStoryboard(story: .dividedHorizontal)))
                Item(name: "With divider arranged vertically", value: .story(dividedCardStoryboard(story: .dividedVertical)))
                Item(name: "With divider without padding", value: .story(dividedCardStoryboard(story: .dividedVerticalNoPadding)))
                Item(name: "With divider and corner style large", value: .story(dividedCardStoryboard(story: .dividedHorizontalCornerStyleLarge)))
            }
            Item(name: "Flare views", value: .story(loadStoryboard(name: "FlareView", identifier: "FlareViewViewController")))
            Item(name: "Chips", value: .story(loadStoryboard(name: "Chips", identifier: "ChipsViewController")))
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

    // swiftlint:enable

}
