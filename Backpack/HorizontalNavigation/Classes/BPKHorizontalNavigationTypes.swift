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

/// A given size that `BPKHorizontalNavigation` supports.
///
/// While it's possible to conform to this protocol in new types
/// it is not recommended or supported.
public protocol BPKHorizontalNavigationSize {
    static var fontStyle: BPKFontStyle { get }

    static var verticalSpacing: CGFloat { get }
}

/// The default size of `BPKHorizontalNavigation`.
public enum BPKHorizontalNavigationSizeDefault: BPKHorizontalNavigationSize {
    public static var verticalSpacing: CGFloat { BPKSpacingLg }

    public static var fontStyle: BPKFontStyle { .textHeading5 }
}

/// The small size of `BPKHorizontalNavigation`.
public enum BPKHorizontalNavigationSizeSmall: BPKHorizontalNavigationSize {
    public static var verticalSpacing: CGFloat { BPKSpacingBase }

    public static var fontStyle: BPKFontStyle { .textLabel2 }
}

extension BPKHorizontalNavigationSize {
    static var horizontalSpacing: CGFloat { BPKSpacingBase }
}

/// A delegate of `BPKHorizontalNavigation`
public protocol BPKHorizontalNavigationDelegate: AnyObject {
    func horizontalNavigation<Size>(
        _ horizontalNavigation: BPKHorizontalNavigation<Size>,
        didSelectItemAtIndex index: Int,
        withTag tag: Int
    )
}

@objc
public enum BPKHorizontalNavigationAppearance: UInt {
    case normal = 0
    case alternate = 1
}

/// A protocol that describes a single **option** for a ``BPKHorizontalNavigation``.
///
/// Each option can be thought of as a model which is used to generate an **item**
/// that is ultimately displayed.
///
/// An option is similar in philosophy to ``UINavigationItem``.
///
/// See: ``BPKHorizontalNavigationItem``
public protocol BPKHorizontalNavigationOption: Equatable {
    associatedtype Size: BPKHorizontalNavigationSize

    /**
     * A tag representing the option, can be used to distinguish options from
     * eachother.
     */
    var tag: Int { get }

    /// Create an item for this option.
    ///
    /// Creates a ``UIControl`` subclass to use for rendering this item
    /// in a ``BPKHorizontalNavigation``. In addition to being a `UIControl`
    /// subclass it should implement the `BPKHorizontalNavigationItem` protocol.
    func makeItem() -> BPKHorizontalNavigationItem
}

public protocol BPKHorizontalNavigationItem: UIControl {
    var selectedColor: UIColor? { get set }

    var appearance: BPKHorizontalNavigationAppearance { get set }
}

/// A protocol that describes an icon used for options with icons
public protocol BPKHorizontalNavigationOptionIcon: Equatable {
    associatedtype Size: BPKHorizontalNavigationSize

    func makeImage() -> UIImage
    static var size: CGSize { get }
}

extension BPKSmallIconName: BPKHorizontalNavigationOptionIcon {
    public typealias Size = BPKHorizontalNavigationSizeSmall

    public func makeImage() -> UIImage {
        BPKIcon.makeSmallTemplateIcon(name: self)
    }

    public static var size: CGSize {
        BPKIcon.concreteSizeForSmallIcon
    }
}

extension BPKLargeIconName: BPKHorizontalNavigationOptionIcon {
    public typealias Size = BPKHorizontalNavigationSizeDefault

    public func makeImage() -> UIImage {
        BPKIcon.makeLargeTemplateIcon(name: self)
    }

    public static var size: CGSize {
        BPKIcon.concreteSizeForLargeIcon
    }
}
