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

import Foundation
import UIKit

/**
 * A `BPKHorizontalNavigation` is a control comprising of multiple segments, where each acts as a discrete button.
 *
 * It's typically used like a ``UISegementedControl`` e.g. to control which out of many potential
 * views are being displayed in a given view.
 */
// swiftlint:disable:next type_body_length
public class BPKHorizontalNavigation<Size: BPKHorizontalNavigationSize>: UIControl {
    struct TextOption<Size: BPKHorizontalNavigationSize>: BPKHorizontalNavigationOption {
        let name: String
        let tag: Int
        let showNotificationDot: Bool

        init(name: String, tag: Int, showNotificationDot: Bool) {
            self.name = name
            self.tag = tag
            self.showNotificationDot = showNotificationDot
        }

        func makeItem() -> BPKHorizontalNavigationItem {
            let item = BPKHorizontalNavigationItemDefault<Size>(name: name, showNotificationDot: showNotificationDot)
            item.tag = tag

            return item
        }
    }

    struct TextWithIconOption<
        Size: BPKHorizontalNavigationSize, Icon: BPKHorizontalNavigationOptionIcon
    >: BPKHorizontalNavigationOption {
        let name: String
        let icon: Icon
        let tag: Int
        let showNotificationDot: Bool

        init(name: String, tag: Int, icon: Icon, showNotificationDot: Bool) {
            self.name = name
            self.tag = tag
            self.icon = icon
            self.showNotificationDot = showNotificationDot
        }

        func makeItem() -> BPKHorizontalNavigationItem {
            BPKHorizontalNavigationItemDefault<Size>(
                name: name,
                iconDefinition: .init(image: icon.makeImage(), size: Icon.size),
                showNotificationDot: showNotificationDot
            )
        }

        // MARK: Equatable
        static func == (
            lhs: BPKHorizontalNavigation<Size>.TextWithIconOption<Size, Icon>,
            rhs: BPKHorizontalNavigation<Size>.TextWithIconOption<Size, Icon>
        ) -> Bool {
            return lhs.name == rhs.name &&
                lhs.tag == rhs.tag &&
                lhs.icon == rhs.icon &&
                lhs.showNotificationDot == rhs.showNotificationDot
        }
    }

    struct TextWithBadge<Size: BPKHorizontalNavigationSize>: BPKHorizontalNavigationOption {
        let name: String
        let tag: Int
        let badgeMessage: String

        func makeItem() -> BPKHorizontalNavigationItem {
            let item = BPKHorizontalNavigationItemWithBadge<Size>(title: name, badgeMessage: badgeMessage)
            item.tag = tag

            return item
        }
    }

    /// Type erased option representing a single item in a BPKHorizontalNavigation
    public struct AnyOption<Size>: Equatable {
        private let _makeItem: () -> BPKHorizontalNavigationItem
        private let getTag: () -> Int

        /// Create a type erased option from a specific type that implements
        /// `BPKHorizontalNavigationOption`.
        ///
        /// - Parameter wrapped: The option to type erase
        public init<O: BPKHorizontalNavigationOption>(wrapped: O) where O.Size == Size {
            _makeItem = wrapped.makeItem
            getTag = { wrapped.tag }
        }

        /// Creates an option with text title.
        ///
        /// - Parameters:
        ///   - name: The text to display in the resulting item.
        ///   - tag: The tag to use for the resulting item.
        ///   - showNotificationDot: Whether the resulting item should show a notificaiton dot
        /// - Returns: A type erased option.
        public static func text<S: BPKHorizontalNavigationSize>(
            _ name: String,
            tag: Int = 0,
            showNotificationDot: Bool = false
        ) -> AnyOption<S> {
            return AnyOption<S>(wrapped: TextOption<S>(name: name, tag: tag, showNotificationDot: showNotificationDot))
        }

        /// Creates an option with a title and icon.
        ///
        /// - Parameters:
        ///   - name: The text to display in the resulting item.
        ///   - icon: The icon to display in the result item.
        ///   - tag: The tag to use for the resulting item.
        ///   - showNotificationDot: Whether the resulting item should show a notificaiton dot
        /// - Returns: A type erased option.
        public static func textAndIcon<
            S,
            Icon: BPKHorizontalNavigationOptionIcon
        >(_ name: String, icon: Icon, tag: Int = 0, showNotificationDot: Bool = false) -> AnyOption<S>
        where Icon.Size == S {
            return AnyOption<S>(
                wrapped: TextWithIconOption<S, Icon>(
                    name: name, tag: tag, icon: icon, showNotificationDot: showNotificationDot
                )
            )
        }

        /// Creates an option with a title and badge.
        ///
        /// - Parameters:
        ///   - name: The text to display in the resulting item.
        ///   - badgeMessage: The message to display in th badge in the resulting item.
        ///   - tag: The tag to use for the resulting item.
        /// - Returns: A type erased option.
        public static func textWithBadge<S: BPKHorizontalNavigationSize>(
            _ name: String, badgeMessage: String, tag: Int = 0
        ) -> AnyOption<S> {
            return AnyOption<S>(wrapped: TextWithBadge<S>(name: name, tag: tag, badgeMessage: badgeMessage))
        }

        // MARK: Equatable
        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.tag == rhs.tag
        }

        // MARK: Internal API
        func makeItem() -> BPKHorizontalNavigationItem {
            _makeItem()
        }

        var tag: Int {
            getTag()
        }
    }

    /// The color to use for selected item highlight.
    ///
    /// This is used for the bar and text colour/icon tint
    /// in the default implementation.
    ///
    /// **Theming:** Unfortunately, due to a bug in Swift/UIKit,
    /// this component does not support theming. To support theming
    /// pleases use a wrapper view to acheive theming via ``UIAppearance``.
    public var selectedColor: UIColor? {
        didSet {
            updateBarColor()
            updateSelectedItemsColor()
        }
    }

    /// The current appearance of the receiver.
    public var appearance: BPKHorizontalNavigationAppearance = .normal {
        didSet {
            updateItemsAppearance()
        }
    }

    /**
     * The options to display within the navigation.
     *
     * see ``AnyOption``
     */
    public var options: [AnyOption<Size>] {
        didSet {
            repopulateStackView()
        }
    }

    /**
     * Whether to show a bar under the selected item
     */
    public var showsSelectedBar: Bool = true {
        didSet {
            updateBarAppearance()
        }
    }
    /**
     * The index of the currently selected item.
     * By default the first item is selected.
     * If the index is out of bounds for the options available (eg -1) then no item will be selected.
     */
    public var selectedItemIndex: Int = 0 {
        didSet {
            if options.count > 0 {
                assert(
                    selectedItemIndex >= 0 && selectedItemIndex < self.options.count,
                    "selectedItemIndex must be within range of the number of options available"
                )
            }

            setItemSelectionStates()
        }
    }

    /// The delegate of the receiver.
    public weak var delegate: BPKHorizontalNavigationDelegate?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally

        return stackView
    }()

    private lazy var barView: UIView = {
        let barView = UIView(frame: .zero)
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.isHidden = true
        barView.accessibilityIdentifier = "BarView"

        return barView
    }()

    private var barTopConstraint: NSLayoutConstraint?
    private var barHeightConstraint: NSLayoutConstraint?
    private var barConstraints: [NSLayoutConstraint]?

    private static var barHeight: CGFloat {
        BPKBorderWidthXl
    }

    private static var barSpacing: CGFloat {
        3 * BPKSpacingSm
    }

    /**
     * Create a `BPKHorizontalNavigation` with a set of options and an initally selected option.
     *
     * @param options [AnyOption<Size>] the options displayed.
     * @param selectedItemIndex Int the initially selected item.
     */
    public required init(options: [AnyOption<Size>], selectedItemIndex: Int) {
        self.options = options
        self.selectedItemIndex = selectedItemIndex

        super.init(frame: .zero)

        setUp(with: options, selectedItemIndex: selectedItemIndex)
    }

    private func setUp(
        with options: [AnyOption<Size>], selectedItemIndex: Int
    ) {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        updateBarColor()
        scrollView.addSubview(barView)

        let btc = barView.topAnchor.constraint(
            equalTo: stackView.bottomAnchor, constant: Self.barSpacing
        )
        let bhc = barView.heightAnchor.constraint(
            equalToConstant: Self.barHeight
        )
        barTopConstraint = btc
        barHeightConstraint = bhc
        NSLayoutConstraint.activate([btc, bhc])

        NSLayoutConstraint.activate([
            // Stack View
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor),

            // Scroll View
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            bottomAnchor.constraint(equalTo: barView.bottomAnchor)
        ])

        repopulateStackView()
        self.selectedItemIndex = selectedItemIndex
        setItemSelectionStates()
        updateBarAppearance()
    }

    private func forEachItem(_ callback: ((BPKHorizontalNavigationItem, Int) -> Void)) {
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            let item = view as? BPKHorizontalNavigationItem
            assert(
                item != nil,
                """
                Every item in a `BPKHorizontalNavigation` should be a UIControl subclass \
                that conforms to `BPKHorizontalNavigationItem`.
                """
            )

            if let item = item {
                callback(item, index)
            }
        }
    }

    private func updateBarAppearance() {
        if !showsSelectedBar || selectedItemIndex >= stackView.arrangedSubviews.count {
            barView.isHidden = true
            barTopConstraint?.constant = 0
            barHeightConstraint?.constant = 0
        } else {
            barView.isHidden = false
            barTopConstraint?.constant = Self.barSpacing
            barHeightConstraint?.constant = Self.barHeight

            let selectedItem = stackView.arrangedSubviews[selectedItemIndex]
            let animationDuration = UIAccessibility.isReduceMotionEnabled ? 0.0 : 0.2

            layoutIfNeeded()

            UIView.animate(withDuration: animationDuration) {
                self.adjustBarConstraints(for: selectedItem)

                self.layoutIfNeeded()
            }
        }
    }

    private func adjustBarConstraints(for view: UIView) {
        if let constraints = barConstraints {
            NSLayoutConstraint.deactivate(constraints)
        }

        let constraints = [
            barView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: Self.barSpacing
            ),
            barView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -Self.barSpacing
            )
        ]

        barConstraints = constraints
        NSLayoutConstraint.activate(constraints)
    }

    private func setItemSelectionStates() {
        forEachItem {
            $0.isSelected = selectedItemIndex == $1
        }

        updateBarAppearance()
    }

    private func updateSelectedItemsColor() {
        forEachItem { item, _ in
            item.selectedColor = selectedColor
        }
    }

    private func updateItemsAppearance() {
        forEachItem { item, _ in
            item.appearance = appearance
        }
    }

    private func updateBarColor() {
        barView.backgroundColor = self.selectedColor ?? BPKColor.primaryColor
    }

    private func repopulateStackView() {
        for view in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        for option in options {
            let control = option.makeItem()
            control.tag = option.tag

            control.addTarget(self, action: #selector(updateSelection), for: .touchUpInside)

            if let selectedColor = self.selectedColor {
                control.selectedColor = selectedColor
            }

            stackView.addArrangedSubview(control)
        }

        selectedItemIndex = 0

        setNeedsLayout()
        layoutIfNeeded()
    }

    @objc
    private func updateSelection(sender: UIControl) {
        guard let newIndex = stackView.arrangedSubviews.firstIndex(of: sender) else {
            return
        }
        selectedItemIndex = newIndex

        delegate?.horizontalNavigation(
            self,
            didSelectItemAtIndex: newIndex,
            withTag: sender.tag
        )

    }

    @available(*, unavailable)
    override init(frame: CGRect) {
        fatalError("\(#function) has not been implemented use init(options:selectedItemIndex:)")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented use init(options:selectedItemIndex:)")
    }
    // swiftlint:disable:next file_length
}
