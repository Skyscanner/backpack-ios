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

/**
 * This file contains the code for our "Stories" approach on iOS.
 * The notion of stories is inspired by Storybook from the javascript community.
 *
 * The DSL that is used in this file is defined in `AppStructure.swift`.
 *
 * The central idea of this approach is to use a declarative system to describe
 * the structure and navigation paths of the app.
 * The implementation is based on Swift's
 * [Result Builders](https://www.swiftbysundell.com/articles/deep-dive-into-swift-function-builders/),
 * the very same that powers Swift UI. The main entry point for this is the function ``makeApp``.
 *
 * Prior to this system, we used storyboards to describe the navigation and structure of the app. We are in the process
 * of migrating from that system to the stories format.
 *
 * The following PRs contain examples of this:
 *
 * * [#940](https://github.com/Skyscanner/backpack-ios/pull/940) _d8de142_
 * * [#937](https://github.com/Skyscanner/backpack-ios/pull/937) _e323bea3_, 909d49e6_, _e8fdeee_
 *
 * We are done when we no longer use **segues** for navigation. We might still use storyboards for
 * the stories, but all navigation should be specified declaratively using this system.
 */
class NavigationData: NSObject {
    static var mainStoryboard = loadStoryboard(name: "Main")

    // swiftlint:disable line_length closure_body_length

    static var appStructure: [Item] = makeApp {
        Group(name: "Tokens") {
            ColorsStory().example
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
            Item(name: "Spacings", value: .story(mainStoryboard("SpacingsViewController")))
            Item(name: "Radii", value: .story(mainStoryboard("RadiiViewController")))
            Item(name: "Shadows", value: .story(mainStoryboard("ShadowsViewController")))
        }
        Group(name: "Components") {
            Item(name: "Badges", value: .story(loadStoryboard(name: "Badges", identifier: "BadgesViewController")))
            Item(name: "Bar charts", value: .story(loadStoryboard(name: "BarCharts", identifier: "BarChartsViewController")))
            Item(name: "Bottom sheet", value: .story(loadStoryboard(name: "BottomSheet", identifier: "BottomSheetViewController")))
            Group(name: "Buttons") {
                ButtonStory.allExamples
            }
            Group(name: "Calendar") {
                CalendarStory.allExamples
            }
            Group(name: "Cards") {
                CardStory.allExamples
                DividedCardStory.allExamples
            }
            Group(name: "Chips") {
                ChipStory.allExamples
            }
            Group(name: "Flare views") {
                FlareStory.allExamples
            }
            Group(name: "Dialogs") {
                Group(name: "Alert") {
                    DialogStory.Alert.allExamples
                }
                Group(name: "Bottom sheet") {
                    DialogStory.BottomSheet.allExamples
                }
                Group(name: "In-app messaging") {
                    DialogStory.InAppMessaging.allExamples
                }
            }
            Group(name: "Horizontal navigation") {
                HorizontalNavigationStory.allExamples
            }
            Item(name: "Icons", value: .story(mainStoryboard("IconsViewController")))
            Group(name: "Labels") {
                LabelStory.allExamples
            }
            Group(name: "Navigation bars") {
                NavigationBarStory.allExamples
            }
            Item(name: "Nudger", value: .story(CustomPresentable(generateViewController: {
                return NudgerViewController()
            })))
            Item(name: "Overlay views", value: .story(loadStoryboard(name: "OverlayView", identifier: "OverlayViewViewController")))
            Group(name: "Map") {
                MapStory.allExamples
            }
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
            Group(name: "Toasts") {
                ToastStory.allExamples
            }
        }
    }

    // swiftlint:enable

}
