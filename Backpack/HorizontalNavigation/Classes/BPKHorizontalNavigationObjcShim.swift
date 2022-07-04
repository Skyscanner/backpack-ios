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

/// An Objective-C compatible version of ``BPKHorizontalNavigationSize`` for
/// use with ``BPKHorizontalNavigationObjc``.
@objc
public enum BPKHorizontalNavigationSizeObjc: UInt {
    /// The default size.
    case `default` = 0
}

/// An Objective-C compatible version of ``BPKHorizontalNavigationItem``.
///
/// See ``BPKHorizontalNavigationItem`` for further details.
@objc
public protocol BPKHorizontalNavigationItemObjc {
    var selectedColor: UIColor? { get set }

    var appearance: BPKHorizontalNavigationAppearance { get set }
}

/// An Objective-C compatible version of ``BPKHorizontalNavigationOption``.
@objc
public protocol BPKHorizontalNavigationOptionTypeObjc {
    /// The tag of the resulting item
    var tag: Int { get }

    /// Construct an item
    ///
    /// See ``BPKHorizontalNavigationItem.makeItem``
    func makeItem() -> BPKHorizontalNavigationItemObjc
}

/// An Objective-C compatible version of an **option** for
/// use with `BPKHorizontalNavigationObjc`.
///
/// See ``BPKHorizontalNavigationOption`` for more details.
@objcMembers
public class BPKHorizontalNavigationOptionObjc: NSObject, BPKHorizontalNavigationOptionTypeObjc {
    /**
     * Name of the optional icon used in the option.
     */
    public let iconName: BPKLargeIconName?

    /**
     * Whether the option has an icon. True if `iconName` is non-nil.
     */
    public var hasIcon: Bool { iconName != nil }

    /**
     * A tag representing the option, can be used to distinguish options from
     * eachother.
     */
    public let tag: Int

    /**
     * Name of the option displayed in the horizontal nav.
     */
    public let name: String

    public init(name: String, tag: Int = 0, iconName: BPKLargeIconName? = nil) {
        self.name = name
        self.tag = tag
        self.iconName = iconName

        super.init()
    }

    public init(name: String, tag: Int = 0) {
        self.name = name
        self.tag = tag
        self.iconName = nil

        super.init()
    }

    public func makeItem() -> BPKHorizontalNavigationItemObjc {
        let iconDefinition = iconName.map {
            BPKHorizontalNavigationItemDefault<BPKHorizontalNavigationSizeDefault>.IconDefinition(
                image: BPKIcon.makeLargeTemplateIcon(name: $0),
                size: BPKIcon.concreteSizeForLargeIcon
            )
        }

        guard let icon = iconDefinition else {
            let item = BPKHorizontalNavigationItemDefault<BPKHorizontalNavigationSizeDefault>(name: name)
            item.tag = tag

            // This is safe because `BPKHorizontalNavigationItemDefault<Size>`
            // provides both `selectedColor` and `appearance` properties
            return item
        }

        let item = BPKHorizontalNavigationItemDefault<BPKHorizontalNavigationSizeDefault>(
            name: name, iconDefinition: icon
        )
        item.tag = tag

        return item
    }

}

/// An Objective-C compatible version of ``BPKHorizontalNavigationDelegate``
@objc
public protocol BPKHorizontalNavigationDelegateObjc {
    func horizontalNavigation(
        _ horizontalNavigation: BPKHorizontalNavigationObjc,
        didSelectItemAtIndex index: Int,
        withTag tag: Int
    )
}

/// A limited version of ``BPKHorizontalNavigation`` that can be used from Objective-C.
///
/// ``BPKHorizontalNavigation`` isn't usable from Swift due to its API.
/// This class provides an Objective-C compatible wrapper with limited functionality
/// to use in its place in Objective-C code.
///
/// It's recommended that the Swift version is used, but this class exists as an
/// alternative.
@objcMembers
public class BPKHorizontalNavigationObjc: UIView {
    private let horizontalNav: BPKHorizontalNavigation<BPKHorizontalNavigationSizeDefault>

    public var options: [BPKHorizontalNavigationOptionTypeObjc] {
        didSet {
            updateOptions()
        }
    }

    public var appearance: BPKHorizontalNavigationAppearance {
        get {
            horizontalNav.appearance
        }
        set {
            horizontalNav.appearance = newValue
        }
    }

    /// :nodoc:
    public dynamic var selectedColor: UIColor? {
        get {
            horizontalNav.selectedColor
        }
        set {
            horizontalNav.selectedColor = newValue
        }
    }

    public var selectedItemIndex: Int {
        get {
            horizontalNav.selectedItemIndex
        }
        set {
            horizontalNav.selectedItemIndex = newValue
        }
    }

    public var showsSelectedBar: Bool {
        get {
            horizontalNav.showsSelectedBar
        }
        set {
            horizontalNav.showsSelectedBar = newValue
        }
    }

    public weak var delegate: BPKHorizontalNavigationDelegateObjc?

    public init(options: [BPKHorizontalNavigationOptionTypeObjc], selectedItemIndex: Int) {
        self.options = options
        horizontalNav = BPKHorizontalNavigation(
            options: Self.convertOptions(from: options),
            selectedItemIndex: selectedItemIndex
        )
        super.init(frame: .zero)

        horizontalNav.delegate = self

        setUp()
    }

    private func setUp() {
        addSubview(horizontalNav)
        horizontalNav.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalNav.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalNav.topAnchor.constraint(equalTo: topAnchor),
            horizontalNav.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalNav.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func updateOptions() {
        horizontalNav.options = Self.convertOptions(from: options)
    }

    private static func convertOptions(
        from objcOptions: [BPKHorizontalNavigationOptionTypeObjc]
    ) -> [BPKHorizontalNavigation<BPKHorizontalNavigationSizeDefault>.AnyOption<BPKHorizontalNavigationSizeDefault>] {
        return objcOptions.compactMap {
            guard let item = $0 as? BPKHorizontalNavigationOptionObjc else {
                return nil
            }

            if let iconName = item.iconName {
                return .textAndIcon(
                    item.name,
                    icon: iconName,
                    tag: item.tag
                )
            } else {
                return .text(item.name, tag: item.tag)
            }
        }
    }

    @available(*, unavailable)
    override init(frame: CGRect) {
        fatalError("\(#function) has not been implemented use init(options:selectedItemIndex:)")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented use init(options:selectedItemIndex:)")
    }
}

extension BPKHorizontalNavigationObjc: BPKHorizontalNavigationDelegate {
    public func horizontalNavigation<Size>(
        _ horizontalNavigation: BPKHorizontalNavigation<Size>,
        didSelectItemAtIndex index: Int,
        withTag tag: Int
    ) where Size: BPKHorizontalNavigationSize {
        self.delegate?.horizontalNavigation(
            self, didSelectItemAtIndex: index, withTag: tag
        )
    }
}
