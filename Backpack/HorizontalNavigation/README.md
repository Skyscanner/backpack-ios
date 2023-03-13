# Backpack/HorizontalNavigation

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKHorizontalNavigation.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/HorizontalNavigation)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-horizontal-navigation___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-horizontal-navigation___default_dm.png" alt="" width="375" /> |

## Small

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-horizontal-navigation___small_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-horizontal-navigation___small_dm.png" alt="" width="375" /> |

## With icons

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-horizontal-navigation___with-icons_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-horizontal-navigation___with-icons_dm.png" alt="" width="375" /> |

## With no line

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-horizontal-navigation___without-underline_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-horizontal-navigation___without-underline_dm.png" alt="" width="375" /> |

## Usage

`BPKHorizontalNavigation` is a component similar to [Segmented Control](https://developer.apple.com/design/human-interface-guidelines/ios/controls/segmented-controls/). It shows two or more segments, each being a distinct option for travellers to switch between. Each option is defined with a string, and optionally a `BPKIcon` name too.

### Swift

```swift
import Backpack

typealias DefaultNav = BPKHorizontalNavigation<BPKHorizontalNavigationSizeDefault>

let options = [
    .text("Flights", tag: 0),
    .text("Hotels", tag: 1),
    .text("Car Hire", tag: 2),
]
let horizontalNavigation: DefaultNav = DefaultNav(options: options, selectedItemIndex:0)
horizontalNavigation.showsSelectedBar = false
horizontalNavigation.appearance = .normal
```

### Objective-C

The component doesn't directly support Objective-C, but an Objective-C compatible shim is provided for the most common use cases.

If you need capabilities not provided by this shim use Swift instead of Objective-C and create your own Objective-C compatible variant
for use from Objective-C if you absolutely need the Objective-C support.

```objective-c
@import Backpack;

NSArray<id<BPKHorizontalNavigationOptionTypeObjc>> *options = @[
    [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Flights" tag:0 iconName:nil],
    [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Hotels" tag:1 iconName:nil],
    [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Car hire" tag:2 iconName:nil]
];
BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigationObjc alloc] initWithOptions:options selectedItemIndex:0];
horizontalNavigation.showsSelectedBar = YES;
horizontalNavigation.appearance = BPKHorizontalNavigationAppearanceNormal;
```

## Custom Horizontal Navigation Segments

Horizontal Navigation can use custom segments in Swift. To achieve this, implement a custom type that conforms to `BPKHorizontalNavigationOption` and return your own view (a subclass of `UIControl` that implements the protocol `BPKHorizontalNavigationItem`) for `makeItem`. Ensure the height of your view is similar to that of those rendered when the built-in options are used directly for all the sizes that the component supports.

## Theming

The component supports configuring the selection colour with `selectedColor`, but due to a bug with Swift/UIKit it does not support setting this via `UIAppearance`. Use an explicit wrapper view to support theming.

For example: 

```swift
import Backpack 

class MyNav: UIView {
  let nav: BPKHorizontalNavigation<BPKHorizontalNavigationSizeDefault>

  @objc dynamic var selectedColor: UIColor? {
      didSet {
        nav.selectedColor = selectedColor
      }
  }

  // ...omitted
}
```


