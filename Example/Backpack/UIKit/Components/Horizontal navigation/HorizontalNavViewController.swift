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

import UIKit
import Backpack

struct StoryIcon<Size: BPKHorizontalNavigationSize> {
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
}

extension StoryIcon: BPKHorizontalNavigationOptionIcon {
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

extension BPKHorizontalNavigation.AnyOption {
    static func withBackground<S: BPKHorizontalNavigationSize>(
        title: String, tag: NSInteger = 0
    ) -> BPKHorizontalNavigation.AnyOption<S> {
        return BPKHorizontalNavigation.AnyOption<S>(
            wrapped: CustomHorizontalNavigationOptionWithBackground<S>(title: title, tag: tag)
        )
    }
}

class HorizontalNavViewController: UIViewController, BPKTappableLinkLabelDelegate {
    lazy var largeHorizontalNav: BPKHorizontalNavigation<BPKHorizontalNavigationSizeDefault> = {
        let horizontalNav = BPKHorizontalNavigation<BPKHorizontalNavigationSizeDefault>(
            options: [], selectedItemIndex: 0
        )
        horizontalNav.translatesAutoresizingMaskIntoConstraints = false

        return horizontalNav
    }()

    lazy var smallHorizontalNav: BPKHorizontalNavigation<BPKHorizontalNavigationSizeSmall> = {
        let horizontalNav = BPKHorizontalNavigation<BPKHorizontalNavigationSizeSmall>(
            options: [], selectedItemIndex: 0
        )
        horizontalNav.translatesAutoresizingMaskIntoConstraints = false

        return horizontalNav
    }()

    var small: Bool = false
    var appearance: BPKHorizontalNavigationAppearance = .normal
    var showBar: Bool = true
    var showIcons: Bool = false
    var wide: Bool = false
    var showExtraContent = false
    var useCustomItems = false
    var showNotificationDot = false
    var useItemWithBadge = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bpk_background

        if small {
            view.addSubview(smallHorizontalNav)
            setUpConstraints(for: smallHorizontalNav)

            configureExample(for: smallHorizontalNav)
        } else {
            view.addSubview(largeHorizontalNav)
            setUpConstraints(for: largeHorizontalNav)

            configureExample(for: largeHorizontalNav)
        }
    }

    private func setUpConstraints(for innerView: UIView) {
        NSLayoutConstraint.activate([
            innerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BPKSpacingLg),
            innerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: wide ? -BPKSpacingLg : -(BPKSpacingXxl + BPKSpacingLg)
            ),
            innerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configureExample<Size: BPKHorizontalNavigationSize>(for nav: BPKHorizontalNavigation<Size>) {
        nav.options = [
            .text("Flights", tag: 0),
            .text("Hotels", tag: 1),
            .text("Car Hire", tag: 2)
        ]

        if showExtraContent {
            nav.options += [
                .text("Flights", tag: 3),
                .text("Hotels", tag: 4),
                .text("Car Hire", tag: 5)
            ]
        }

        if showIcons {
            nav.options = [
                .textAndIcon("Flights", icon: StoryIcon.flight, tag: 0),
                .textAndIcon("Hotels", icon: StoryIcon.hotels, tag: 1, showNotificationDot: showNotificationDot),
                .textAndIcon("Car Hire", icon: StoryIcon.cars, tag: 2)
            ]

            if showExtraContent {
                smallHorizontalNav.options += [
                    .textAndIcon("Flights", icon: StoryIcon.flight, tag: 3),
                    .textAndIcon("Hotels", icon: StoryIcon.hotels, tag: 4, showNotificationDot: showNotificationDot),
                    .textAndIcon("Car Hire", icon: StoryIcon.cars, tag: 5)
                ]
            }
        } else {
            if useCustomItems {
                nav.options = [
                    .withBackground(title: "Flights", tag: 0),
                    .withBackground(title: "Hotels", tag: 1),
                    .withBackground(title: "Car Hire", tag: 2)
                ]
            }

            if useItemWithBadge {
                nav.options = [
                    .textAndIcon("Flights", icon: StoryIcon.flight, tag: 0),
                    .textWithBadge("Hotels", badgeMessage: "NEW", tag: 1),
                    .textAndIcon("Cars", icon: StoryIcon.cars, tag: 2)
                ]
            }
        }

        nav.showsSelectedBar = showBar
        nav.appearance = appearance

        if appearance == .alternate {
            nav.backgroundColor = BPKColor.skyGray
        }
    }
}
