// swiftlint:disable file_length
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

import XCTest
import FBSnapshotTestCase

@testable import Backpack

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
    selectedItemIndex: Int = 0
) -> BPKHorizontalNavigation<Size> {
    let nav = BPKHorizontalNavigation<Size>(
        options: [
            .text("Flights", tag: 0),
            .text("Hotels", tag: 1),
            .text("Car Hire", tag: 2)
        ],
        selectedItemIndex: selectedItemIndex
    )

    return nav
}

struct StoryIcon<Size: BPKHorizontalNavigationSize>: BPKHorizontalNavigationOptionIcon {
    let smallIconName: BPKSmallIconName
    let largeIconName: BPKLargeIconName

    static var flight: Self {
        .init(smallIconName: .flight, largeIconName: .flight)
    }

    static var hotels: Self {
        .init(smallIconName: .hotels, largeIconName: .hotels)
    }

    static var cars: Self {
        .init(smallIconName: .cars, largeIconName: .cars)
    }

    private static var isSmall: Bool {
        Size.self == BPKHorizontalNavigationSizeSmall.self
    }
    
    func makeImage() -> UIImage {
        if Self.isSmall {
            return BPKIcon.makeSmallTemplateIcon(name: smallIconName)
        } else {
            return BPKIcon.makeLargeTemplateIcon(name: largeIconName)
        }
    }

    static var size: CGSize {
        if isSmall {
            return BPKIcon.concreteSizeForSmallIcon
        } else {
            return BPKIcon.concreteSizeForLargeIcon
        }
    }
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
    width: CGFloat = -1.0
) -> (NavContainer<Size>, NavContainer<Size>) {
    let (nav1, nav2): (BPKHorizontalNavigation<Size>, BPKHorizontalNavigation<Size>) = (
        createNav(selectedItemIndex: selectedItemIndex),
        createNav(selectedItemIndex: selectedItemIndex)
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
        darkView.backgroundColor = .bpk_black

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testSmall() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeSmall>,
            NavContainer<BPKHorizontalNavigationSizeSmall>
        ) = create()
        darkView.backgroundColor = .bpk_black

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testSelectedIndex() {
        let lightView = createWithSelectedIndex(2)
        let darkView = createWithSelectedIndex(2)
        darkView.backgroundColor = .bpk_black

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testWithoutBar() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = create(selectedItemIndex: 0, showsSelectedBar: false)
        darkView.backgroundColor = .bpk_black

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testDefaultWithIcons() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = createWithIcons()
        darkView.backgroundColor = .bpk_black

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testSmallWithIcons() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeSmall>,
            NavContainer<BPKHorizontalNavigationSizeSmall>
        ) = createWithIcons()
        darkView.backgroundColor = .bpk_black

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testWithTheming() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = createWithIcons()
        darkView.backgroundColor = .bpk_black
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
        darkView.backgroundColor = .bpk_black

        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }

    func testNarrow() {
        let (lightView, darkView): (
            NavContainer<BPKHorizontalNavigationSizeDefault>,
            NavContainer<BPKHorizontalNavigationSizeDefault>
        ) = createWithIcons(selectedItemIndex: 0, showsSelectedBar: true, width: 200.0)
        darkView.backgroundColor = .bpk_black

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

extension BPKHorizontalNavigation.AnyOption {
    // swiftlint:disable:next type_name
    struct CustomHorizontalNavigationOptionWithBackground<
        Size: BPKHorizontalNavigationSize
    >: BPKHorizontalNavigationOption {
        /**
         *
         */
        let title: String

        var tag: NSInteger

        func makeItem() -> BPKHorizontalNavigationItem {
            return HorizontalNavigationItemWithBackground<Size>(title: title)
        }
    }
    
    class HorizontalNavigationItemWithBackground<
        Size: BPKHorizontalNavigationSize
    >: UIButton, BPKHorizontalNavigationItem {
        // MARK: - BPKHorizontalNavigationItem

        public var selectedColor: UIColor? = BPKColor.primaryColor

        public var appearance: BPKHorizontalNavigationAppearance = .normal

        // MARK: Implementaiton

        let title: String

        @objc
        public init(title: String) {
            self.title = title

            super.init(frame: .zero)

            setUp()
        }

        func setUp() {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: BPKSpacingBase, bottom: 0, right: BPKSpacingBase)
            updateStyle()
        }

        func updateTitle() {
            let fontStyle = Size.fontStyle
            var textColor = BPKColor.textPrimaryColor

            if isSelected || isHighlighted {
                textColor = .white
            }

            let attributedString = BPKFont.makeAttributedString(
                fontStyle: fontStyle, content: title, textColor: textColor
            )

            setAttributedTitle(attributedString, for: .normal)
        }

        func updateBackground() {
            if isSelected {
                self.backgroundColor = selectedColor
            } else if isHighlighted {
                self.backgroundColor = selectedColor?.withAlphaComponent(0.6)
            } else {
                self.backgroundColor = .clear
            }
        }

        func updateStyle() {
            updateTitle()
            updateBackground()
        }

        // MARK: - Overrides

        override public var isSelected: Bool {
            didSet {
                updateStyle()
            }
        }

        override public var isHighlighted: Bool {
            didSet {
                updateStyle()
            }
        }

        override public var intrinsicContentSize: CGSize {
            let size = super.intrinsicContentSize
            return CGSize(width: size.width + 2 * BPKSpacingBase, height: size.height)
        }

        public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)

            if self.traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
                updateStyle()
            }
        }

        // MARK: - Coder

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    static func withBackground<S: BPKHorizontalNavigationSize>(
        title: String, tag: NSInteger = 0
    ) -> BPKHorizontalNavigation.AnyOption<S> {
        return BPKHorizontalNavigation.AnyOption<S>(
            wrapped: CustomHorizontalNavigationOptionWithBackground<S>(title: title, tag: tag)
        )
    }
}
