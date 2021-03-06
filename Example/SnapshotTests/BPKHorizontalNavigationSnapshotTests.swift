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

import XCTest

import Backpack
@testable import Backpack_Native

import FBSnapshotTestCase

class NavContainer<Size: BPKHorizontalNavigationSize>: UIView {
    weak var nav: BPKHorizontalNavigation<Size>?
    let desiredWidth: CGFloat

    init(nav: BPKHorizontalNavigation<Size>, desiredWidth: CGFloat = -1.0) {
        self.nav = nav
        self.desiredWidth = desiredWidth

        super.init(frame: .zero)

        addSubview(nav)
    }

    override func sizeToFit() {
        super.sizeToFit()

        guard let nav = nav else {
            return
        }

        var fittingSize = nav.systemLayoutSizeFitting(CGSize(width: 1000, height: 1000))

        if desiredWidth > -1.0 {
            fittingSize.width = desiredWidth
        }

        nav.frame = CGRect(origin: .zero, size: fittingSize)
        frame = nav.frame
    }

    @available(*, unavailable)
    override init(frame: CGRect) {
        fatalError("Not implemented")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}

func displayHorizontalNavigation<Size: BPKHorizontalNavigationSize>(
    _ nav: BPKHorizontalNavigation<Size>,
    width: CGFloat = -1.0
) -> NavContainer<Size> {
    let view = NavContainer(nav: nav, desiredWidth: width)
    view.backgroundColor = .bpk_white

    var fittingSize = nav.systemLayoutSizeFitting(CGSize(width: 1000, height: 1000))

    if width > -1.0 {
        fittingSize.width = width
    }

    nav.frame = CGRect(origin: .zero, size: fittingSize)
    view.frame = nav.frame

    return view
}

func createNav<Size: BPKHorizontalNavigationSize>(
    selectedItemIndex: Int = 0, showNotificationDot: Bool = false
) -> BPKHorizontalNavigation<Size> {
    let nav = BPKHorizontalNavigation<Size>(
        options: [
            .text("Flights", tag: 0, showNotificationDot: showNotificationDot),
            .text("Hotels", tag: 1, showNotificationDot: showNotificationDot),
            .text("Car Hire", tag: 2, showNotificationDot: showNotificationDot)
        ],
        selectedItemIndex: selectedItemIndex
    )

    return nav
}

func createNavWithIcons<Size: BPKHorizontalNavigationSize>(
    selectedItemIndex: Int = 0
) -> BPKHorizontalNavigation<Size> {
    let nav = BPKHorizontalNavigation<Size>(
        options: [
            .textAndIcon("Flights", icon: StoryIcon.flight, tag: 0),
            .textAndIcon("Hotels", icon: StoryIcon.hotels, tag: 1),
            .textAndIcon("Car Hire", icon: StoryIcon.cars, tag: 2)
        ],
        selectedItemIndex: selectedItemIndex
    )
    nav.showsSelectedBar = true

    return nav
}

func create<Size: BPKHorizontalNavigationSize>(
    selectedItemIndex: Int = 0,
    showsSelectedBar: Bool = true,
    width: CGFloat = -1.0,
    showNotificationDot: Bool = false
) -> (NavContainer<Size>, NavContainer<Size>) {
    let (nav1, nav2): (BPKHorizontalNavigation<Size>, BPKHorizontalNavigation<Size>) = (
        createNav(selectedItemIndex: selectedItemIndex, showNotificationDot: showNotificationDot),
        createNav(selectedItemIndex: selectedItemIndex, showNotificationDot: showNotificationDot)
    )
    nav1.showsSelectedBar = showsSelectedBar
    nav2.showsSelectedBar = showsSelectedBar

    return (displayHorizontalNavigation(nav1, width: width), displayHorizontalNavigation(nav2, width: width))
}

func createWithIcons<Size: BPKHorizontalNavigationSize>(
    selectedItemIndex: Int = 0, showsSelectedBar: Bool = true, width: CGFloat = -1.0
) -> (NavContainer<Size>, NavContainer<Size>) {
    let (nav1, nav2): (
        BPKHorizontalNavigation<Size>, BPKHorizontalNavigation<Size>
    ) = (
        createNavWithIcons(selectedItemIndex: selectedItemIndex),
        createNavWithIcons(selectedItemIndex: selectedItemIndex)
    )

    return (displayHorizontalNavigation(nav1, width: width), displayHorizontalNavigation(nav2, width: width))
}

func createWithSelectedIndex(_ index: Int) -> UIView {
    let nav: DefaultNav = createNav(selectedItemIndex: index)
    return displayHorizontalNavigation(nav)
}

typealias DefaultNav = BPKHorizontalNavigation<BPKHorizontalNavigationSizeDefault>
typealias SmallNav = BPKHorizontalNavigation<BPKHorizontalNavigationSizeSmall>

class BPKHorizontalNavigationSnapshotTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()

        recordMode = false
    }

    func testDefault() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = create()
        darkView.backgroundColor = .bpk_backgroundDark

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testSmall() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeSmall>,
            NavContainer<BPKHorizontalNavigationSizeSmall>
        ) = create()
        darkView.backgroundColor = .bpk_backgroundDark

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testSelectedIndex() {
        let lightView = createWithSelectedIndex(2)
        let darkView = createWithSelectedIndex(2)
        darkView.backgroundColor = .bpk_backgroundDark

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testWithoutBar() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = create(selectedItemIndex: 0, showsSelectedBar: false)
        darkView.backgroundColor = .bpk_backgroundDark

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testDefaultWithIcons() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = createWithIcons()
        darkView.backgroundColor = .bpk_backgroundDark

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testSmallWithIcons() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeSmall>,
            NavContainer<BPKHorizontalNavigationSizeSmall>
        ) = createWithIcons()
        darkView.backgroundColor = .bpk_backgroundDark

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testWithTheming() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = createWithIcons()
        darkView.backgroundColor = .bpk_backgroundDark
        lightView.nav?.selectedColor = .bpk_erfoud
        darkView.nav?.selectedColor = .bpk_bagan

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testWide() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = createWithIcons(selectedItemIndex: 0, showsSelectedBar: true, width: 550.0)
        darkView.backgroundColor = .bpk_backgroundDark

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testNarrow() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = createWithIcons(selectedItemIndex: 0, showsSelectedBar: true, width: 200.0)
        darkView.backgroundColor = .bpk_backgroundDark

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testWithNotificationDot() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = create(selectedItemIndex: 0, showsSelectedBar: true, width: -1.0, showNotificationDot: true)
        darkView.backgroundColor = .bpk_backgroundDark

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testWithBadge() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = create()
        darkView.backgroundColor = .bpk_backgroundDark
        lightView.nav?.options = [
            .textAndIcon("Flights", icon: StoryIcon.flight, tag: 0),
            .textWithBadge("Hotels", badgeMessage: "NEW", tag: 1),
            .textAndIcon("Cars", icon: StoryIcon.cars, tag: 2)
        ]
        darkView.nav?.options = lightView.nav!.options
        lightView.sizeToFit()
        darkView.sizeToFit()

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testWithAlternateAppearance() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = create()
        darkView.backgroundColor = .bpk_skyGray
        lightView.backgroundColor = .bpk_skyGray
        lightView.nav?.appearance = .alternate
        darkView.nav?.appearance = .alternate

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testWithCustomOptions() {
        let nav = DefaultNav(options: [
            .withBackground(title: "Flights", tag: 0),
            .withBackground(title: "Hotels", tag: 1),
            .withBackground(title: "Car Hire", tag: 2)
        ], selectedItemIndex: 0)
        nav.showsSelectedBar = false
        let container = displayHorizontalNavigation(nav)

        FBSnapshotVerifyView(container)
    }

}
