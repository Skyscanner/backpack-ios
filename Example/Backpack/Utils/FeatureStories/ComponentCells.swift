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

import Foundation

// swiftlint:disable file_length
struct ComponentCellsProvider {
    let navigator: PresentableNavigator
    let toastDuration: TimeInterval
    
    private func show(presentable: Presentable) {
        navigator.present(presentable: presentable)
    }
    
    private func showChildren(title: String, children: [Components.Group]) {
        navigator.present(title: title, groups: children)
    }
    
    private func showComponent(title: String, tabs: [Components.Tab]) {
        navigator.present(title: title, tabs: tabs)
    }

    // swiftlint:disable:next function_body_length
    func cells() -> [Components.Cell] {
        let dataSources: [CellDataSource] = [
            badge(),
            barChart(),
            bottomSheet(),
            button(),
            calendar(),
            card(),
            cardButton(),
            cardList(),
            carousel(),
            chips(),
            chipGroup(),
            flightLeg(),
            flare(),
            floatingNotification(),
            graphicPromo(),
            dialog(),
            horizontalNavigation(),
            icon(),
            label(),
            navBar(),
            nudger(),
            overlayViews(),
            mapView(),
            pageIndicators(),
            panels(),
            price(),
            progressBar(),
            ratings(),
            sectionHeader(),
            select(),
            snackbar(),
            skeleton(),
            sliders(),
            snippets(),
            sponsoredBanner(),
            spinners(),
            starRatings(),
            switches(),
            tabBarControllers(),
            tappableLinkLabels(),
            textField(),
            textViews(),
            toasts(duration: toastDuration)
        ]
        return dataSources.map(\.cell)
    }
}

extension ComponentCellsProvider {
    private func badge() -> CellDataSource {
        ComponentCellDataSource(
            title: "Badges",
            tabs: [
                .uikit(presentable: CustomPresentable(
                    generateViewController: {
                        BadgesViewController()
                    })),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(BadgeExampleVIew())
                }))
            ],
            showChildren: { showComponent(title: "Badges", tabs: $0) }
        )
    }
    private func barChart() -> CellDataSource {
        PresentableCellDataSource(
            title: "Bar charts",
            storyboard: .named("BarCharts", on: "BarChartsViewController"),
            showPresentable: show(presentable:)
        )
    }
    private func bottomSheet() -> CellDataSource {
        ComponentCellDataSource(
            title: "Bottom sheet",
            tabs: [
                .uikit(presentable: loadStoryboard(name: "BottomSheet", identifier: "BottomSheetViewController")),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(BottomSheetExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Bottom sheet", tabs: $0) }
        )
    }
    private func button() -> CellDataSource {
        ComponentCellDataSource(
            title: "Buttons",
            tabs: [
                .uikit(groups: ButtonGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(groups: ButtonGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Labels", tabs: $0) }
        )
    }
    private func calendar() -> CellDataSource {
        GroupCellDataSource(
            title: "Calendar",
            groups: CalendarGroupsProvider(showPresentable: show(presentable:)).groups(),
            showChildren: { showChildren(title: "Calendar", children: $0) }
        )
    }
    private func card() -> CellDataSource {
        ComponentCellDataSource(
            title: "Cards",
            tabs: [
                .uikit(groups: CardGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(groups: CardGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Cards", tabs: $0) }
        )
    }
    private func cardButton() -> CellDataSource {
        PresentableCellDataSource.custom(
            title: "Card Button",
            customController: { CardButtonsViewController() },
            showPresentable: show(presentable:)
        )
    }
    private func chips() -> CellDataSource {
        ComponentCellDataSource(
            title: "Chips",
            tabs: [
                .uikit(groups: ChipsGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(groups: ChipsGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Chips", tabs: $0) }
        )
    }
    private func chipGroup() -> CellDataSource {
        ComponentCellDataSource(
            title: "Chip Group",
            tabs: [
                .swiftui(groups: ChipGroupProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Chip Group", tabs: $0) }
        )
    }
    private func flare() -> CellDataSource {
        ComponentCellDataSource(
            title: "Flare views",
            tabs: [
                .uikit(groups: FlareGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(FlareExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Flare views", tabs: $0) }
        )
    }
    private func graphicPromo() -> CellDataSource {
        ComponentCellDataSource(
            title: "Graphic promo",
            tabs: [
                .swiftui(groups: GraphicPromoGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Graphic promo", tabs: $0) }
        )
    }
    private func dialog() -> CellDataSource {
        ComponentCellDataSource(
            title: "Dialogs",
            tabs: [
                .uikit(groups: DialogGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(DialogExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Dialogs", tabs: $0) }
        )
    }
    private func horizontalNavigation() -> CellDataSource {
        GroupCellDataSource(
            title: "Horizontal navigation",
            groups: HorizontalNavigationGroupsProvider(showPresentable: show(presentable:)).groups(),
            showChildren: { showChildren(title: "Horizontal navigation", children: $0) }
        )
    }
    private func icon() -> CellDataSource {
        ComponentCellDataSource(
            title: "Icons",
            tabs: [
                .uikit(presentable: loadStoryboard(
                    name: "Main",
                    identifier: "IconsViewController"
                )),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(IconsExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Icons", tabs: $0) }
        )
    }
    private func label() -> CellDataSource {
        ComponentCellDataSource(
            title: "Labels",
            tabs: [
                .uikit(groups: LabelGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(groups: TextGroupsProvider(showPresentable: show(presentable:)).groups())
            ],
            showChildren: { showComponent(title: "Labels", tabs: $0) }
        )
    }
    private func navBar() -> CellDataSource {
        GroupCellDataSource(
            title: "Navigation bars",
            groups: NavBarGroupsProvider(showPresentable: show(presentable:)).groups(),
            showChildren: { showChildren(title: "Navigation bars", children: $0) }
        )
    }
    private func nudger() -> CellDataSource {
        ComponentCellDataSource(
            title: "Nudger",
            tabs: [
                .uikit(presentable: CustomPresentable(
                    generateViewController: {
                        NudgerViewController()
                    })),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(NudgerExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Nudger", tabs: $0) }
        )
    }
    private func overlayViews() -> CellDataSource {
        ComponentCellDataSource(
            title: "Overlay",
            tabs: [
                .uikit(groups: OverlayGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(groups: OverlayGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Overlay", tabs: $0) }
        )
    }
    private func mapView() -> CellDataSource {
        ComponentCellDataSource(
            title: "Map",
            tabs: [
                .uikit(groups: MapGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(MapMarkerExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Map Markers", tabs: $0) }
        )
    }
    private func panels() -> CellDataSource {
        ComponentCellDataSource(
            title: "Panels",
            tabs: [
                .uikit(presentable: loadStoryboard(
                    name: "Panel",
                    identifier: "PanelsViewController"
                )),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(PanelExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Panels", tabs: $0) }
        )
    }
    private func progressBar() -> CellDataSource {
        ComponentCellDataSource(
            title: "Progress bar",
            tabs: [
                .uikit(presentable: loadStoryboard(
                    name: "ProgressBar",
                    identifier: "ProgressBarViewController"
                )),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(ProgressBarExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Progress bar", tabs: $0) }
        )
    }
    private func ratings() -> CellDataSource {
        ComponentCellDataSource(
            title: "Rating",
            tabs: [
                .uikit(groups: RatingGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(groups: RatingGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Rating", tabs: $0) }
        )
    }
    private func select() -> CellDataSource {
        ComponentCellDataSource(
            title: "Select",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(SelectExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Select Pickers", tabs: $0) }
        )
    }
    private func snackbar() -> CellDataSource {
        PresentableCellDataSource(
            title: "Snackbar",
            storyboard: .named("Snackbar", on: "SnackbarViewController"),
            showPresentable: show(presentable:)
        )
    }
    private func sliders() -> CellDataSource {
        ComponentCellDataSource(
            title: "Slider",
            tabs: [
                .swiftui(groups: SliderGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Slider", tabs: $0) }
        )
    }
    private func snippets() -> CellDataSource {
        ComponentCellDataSource(
            title: "Snippet",
            tabs: [
                .swiftui(groups: SnippetGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Snippet", tabs: $0) }
        )
    }
    private func skeleton() -> CellDataSource {
        ComponentCellDataSource(
            title: "Skeleton",
            tabs: [
                .uikit(presentable: CustomPresentable(
                    generateViewController: {
                        SkeletonViewController()
                    })),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(SkeletonExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Skeleton", tabs: $0) }
        )
    }
    private func spinners() -> CellDataSource {
        ComponentCellDataSource(
            title: "Spinners",
            tabs: [
                .uikit(presentable: CustomPresentable(
                    generateViewController: {
                        SpinnersViewController()
                    }
                )),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(SpinnerExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Spinners", tabs: $0) }
        )
    }
    private func starRatings() -> CellDataSource {
        ComponentCellDataSource(
            title: "Star ratings",
            tabs: [
                .uikit(presentable: loadStoryboard(name: "StarRatings", identifier: "StarRatingsViewController")),
                .swiftui(groups: StarRatingGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Star ratings", tabs: $0) }
        )
    }
    private func switches() -> CellDataSource {
        ComponentCellDataSource(
            title: "Switches",
            tabs: [
                .uikit(presentable: loadStoryboard(name: "Switches", identifier: "SwitchesViewController")),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(SwitchExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Switches", tabs: $0) }
        )
    }
    private func tabBarControllers() -> CellDataSource {
        PresentableCellDataSource(
            title: "Tab bar controller",
            storyboard: .named("TabBarControllers", on: "TabBarControllersViewController"),
            showPresentable: show(presentable:)
        )
    }
    private func tappableLinkLabels() -> CellDataSource {
        PresentableCellDataSource(
            title: "Tappable link labels",
            storyboard: .named("TappableLinkLabels", on: "TappableLinkLabelsViewController"),
            showPresentable: show(presentable:)
        )
    }
    private func textField() -> CellDataSource {
        ComponentCellDataSource(
            title: "Text fields",
            tabs: [
                .uikit(presentable: loadStoryboard(name: "TextField", identifier: "TextFieldViewController")),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(TextFieldExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Text Fields", tabs: $0) }
        )
    }
    private func textViews() -> CellDataSource {
        PresentableCellDataSource(
            title: "Text views",
            storyboard: .named("Main", on: "TextViewsViewController"),
            showPresentable: show(presentable:)
        )
    }
    private func toasts(duration: TimeInterval) -> CellDataSource {
        GroupCellDataSource(
            title: "Toasts",
            groups: ToastGroupsProvider(
                showPresentable: show(presentable:),
                toastDuration: duration
            ).groups(),
            showChildren: { showChildren(title: "Toasts", children: $0) }
        )
    }
    private func pageIndicators() -> CellDataSource {
        ComponentCellDataSource(
            title: "Page indicators",
            tabs: [
                .uikit(presentable: CustomPresentable(
                    generateViewController: {
                        PageIndicatorViewController()
                    }
                )),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(PageIndicatorExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Page indicators", tabs: $0) }
        )
    }
    private func carousel() -> CellDataSource {
        ComponentCellDataSource(
            title: "Carousel",
            tabs: [
                .uikit(presentable: CustomPresentable(
                    generateViewController: { CarouselViewController() }
                )),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(CarouselExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Carousel", tabs: $0) }
        )
    }
    private func price() -> CellDataSource {
        ComponentCellDataSource(
            title: "Price",
            tabs: [
                .uikit(groups: PriceGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(groups: PriceGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Price", tabs: $0) }
        )
    }
    private func flightLeg() -> CellDataSource {
        ComponentCellDataSource(
            title: "Flight Leg",
            tabs: [
                .uikit(presentable: CustomPresentable(
                    generateViewController: { BPKFlightLegViewController() }
                ))
            ],
            showChildren: { showComponent(title: "Flight Leg", tabs: $0) }
        )
    }
    private func floatingNotification() -> CellDataSource {
        ComponentCellDataSource(
            title: "Floating notification",
            tabs: [
                .uikit(presentable: CustomPresentable(
                    generateViewController: { FloatingNotificationViewController() }
                ))
            ],
            showChildren: { showComponent(title: "Floating notification", tabs: $0) }
        )
    }
    private func sectionHeader() -> CellDataSource {
        ComponentCellDataSource(
            title: "Section header",
            tabs: [
                .swiftui(groups: SectionHeaderGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Section header", tabs: $0) }
        )
    }
    private func cardList() -> CellDataSource {
        ComponentCellDataSource(
            title: "Card list",
            tabs: [
                .swiftui(groups: CardListGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Card list", tabs: $0) }
        )
    }
    private func sponsoredBanner() -> CellDataSource {
        ComponentCellDataSource(
            title: "Sponsored Banner",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(SponsoredBannerExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Sponsored Banner", tabs: $0) }
        )
    }
}
