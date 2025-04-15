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
@MainActor
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
            appSearchModal(),
            badge(),
            bannerAlert(),
            barChart(),
            bottomSheet(),
            button(),
            calendar(),
            card(),
            cardButton(),
            cardList(),
            carousel(),
            carouselCard(),
            cardCarousel(),
            chips(),
            chipGroup(),
            dynamicStack(),
            fieldSet(),
            flightLeg(),
            flare(),
            floatingNotification(),
            graphicPromo(),
            dialog(),
            horizontalNavigation(),
            icon(),
            imageGalleryPreview(),
            imageGalleryGridView(),
            imageGallerySlideshow(),
            insetBanner(),
            label(),
            navBar(),
            navigationTabsGroup(),
            nudger(),
            overlayViews(),
            mapView(),
            pageIndicators(),
            panels(),
            price(),
            progressBar(),
            ratings(),
            ratingBar(),
            searchControlInput(),
            searchInputSummary(),
            sectionHeader(),
            segmentPicker(),
            select(),
            snackbar(),
            skeleton(),
            sliders(),
            snippets(),
            spinners(),
            starRatings(),
            switches(),
            tabBarControllers(),
            tappableLinkLabels(),
            textArea(),
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
    
    private func bannerAlert() -> CellDataSource {
        ComponentCellDataSource(
            title: "Banner Alert",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(BannerAlertExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Banner Alert", tabs: $0) }
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
        ComponentCellDataSource(
            title: "Calendar",
            tabs: [
                .uikit(groups: CalendarGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(groups: CalendarGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Calendar", tabs: $0) }
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
        ComponentCellDataSource(
            title: "Card Button",
            tabs: [
                .uikit(presentable: CustomPresentable(
                    generateViewController: {
                        CardButtonsViewController()
                    }
                )),
                .swiftui(presentable: CustomPresentable(
                    generateViewController: {
                        ContentUIHostingController(CardButtonExampleView())
                    }
                ))
            ],
            showChildren: { showComponent(title: "Card Button", tabs: $0) }
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
        ComponentCellDataSource(
            title: "Horizontal navigation",
            tabs: [
                .uikit(groups: HorizontalNavigationGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(HorizontalNavigationExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Horizontal navigation", tabs: $0) }
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
        ComponentCellDataSource(
            title: "Navigation bars",
            tabs: [
                .uikit(groups: NavBarGroupsProvider(showPresentable: show(presentable:)).groups()),
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(NavBarExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Navigation bars", tabs: $0) }
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
    private func navigationTabsGroup() -> CellDataSource {
        ComponentCellDataSource(
            title: "Navigation Tabs Group",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(NavigationTabGroupExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Navigation Tabs Group", tabs: $0) }
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
    private func ratingBar() -> CellDataSource {
        ComponentCellDataSource(
            title: "Rating Bar",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(RatingBarExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Rating Bar", tabs: $0) }
        )
    }
    private func searchControlInput() -> CellDataSource {
        ComponentCellDataSource(
            title: "Search Control Input",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(SearchControlInputExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Search Control Input", tabs: $0) }
        )
    }
    private func searchInputSummary() -> CellDataSource {
        ComponentCellDataSource(
            title: "Search Input Summary",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(SearchInputSummaryExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Search Input Summary", tabs: $0) }
        )
    }

    private func segmentPicker() -> CellDataSource {
        ComponentCellDataSource(
            title: "Segmented Control",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(SegmentedControlExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Segmented Control", tabs: $0) }
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
                .uikit(presentable: CustomPresentable(
                    generateViewController: {
                        SwitchesViewController()
                    }
                )),
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
    private func textArea() -> CellDataSource {
        ComponentCellDataSource(
            title: "Text area",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(TextAreaExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Text Area", tabs: $0) }
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
    private func carouselCard() -> CellDataSource {
        ComponentCellDataSource(
            title: "Carousel Card",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(CarouselCardExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Carousel Card", tabs: $0) }
        )
    }
    private func cardCarousel() -> CellDataSource {
        ComponentCellDataSource(
            title: "Card Carousel",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(CardCarouselExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Card Carousel", tabs: $0) }
        )
    }
    private func imageGalleryPreview() -> CellDataSource {
        ComponentCellDataSource(
            title: "Image Gallery Preview",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(ImageGalleryPreviewExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Image Gallery Preview", tabs: $0) }
        )
    }
    private func imageGallerySlideshow() -> CellDataSource {
        ComponentCellDataSource(
            title: "Image Gallery Slideshow",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(ImageGallerySlideshowExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Image Gallery Slideshow", tabs: $0) }
        )
    }
    private func imageGalleryGridView() -> CellDataSource {
        ComponentCellDataSource(
            title: "Image Gallery Grid",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(ImageGalleryGridExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Image Gallery Grid", tabs: $0) }
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
    private func fieldSet() -> CellDataSource {
        ComponentCellDataSource(
            title: "Field Set",
            tabs: [
                .swiftui(groups: FieldSetGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Field Set", tabs: $0) }
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
    private func insetBanner() -> CellDataSource {
        ComponentCellDataSource(
            title: "Inset Banner",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(InsetBannerExampleView())
                }))
            ],
            showChildren: { showComponent(title: "Inset Banner", tabs: $0) }
        )
    }
    
    private func appSearchModal() -> CellDataSource {
        ComponentCellDataSource(
            title: "App Search Modal",
            tabs: [
                .swiftui(groups: AppSearchModalGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "App Search Modal", tabs: $0) }
        )
    }

    private func dynamicStack() -> CellDataSource {
        ComponentCellDataSource(
            title: "Dynamic Stack",
            tabs: [
                .swiftui(groups: DynamicStackGroupsProvider(showPresentable: show(presentable:)).swiftUIGroups())
            ],
            showChildren: { showComponent(title: "Dynamic Stack", tabs: $0) }
        )
    }
}
