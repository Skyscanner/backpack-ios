# Backpack-SwiftUI/NavigationTab

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKNavigationTabGroup.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/NavigationTab)

## Default Vertical

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_navigationTab___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_navigationTab___default_dm.png" alt="" width="375" /> |

## Default Vertical On Dark

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_navigationTab___onDark_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_navigationTab___onDark_dm.png" alt="" width="375" /> |

## Usage

A group of navigation tabs that allows a single tab to be selected at a time.

### Basic Usage

```swift
import Backpack_SwiftUI

@State var selectedIndex = 0

let tabs: [BPKNavigationTabGroup.Item] = [
    .init(text: "Explore", icon: .explore),
    .init(text: "Flights", icon: .flight),
    .init(text: "Hotels", icon: .hotels),
    .init(text: "Car Hire", icon: .cars)
]

BPKNavigationTabGroup(
    tabs: tabs,
    selectedIndex: $selectedIndex
) { index in
    print("Selected tab: \(index)")
}
```

### Styles

Two styles are available: `.default`, `.onDark`

#### Default style (light backgrounds)

```swift
BPKNavigationTabGroup(
    tabs: tabs,
    style: .default,
    selectedIndex: $selectedIndex
) { index in }
```

#### On dark style (dark backgrounds)

```swift
BPKNavigationTabGroup(
    tabs: tabs,
    style: .onDark,
    selectedIndex: $selectedIndex
) { index in }
```

### Tab Items

Each tab is defined using `BPKNavigationTabGroup.Item`:

```swift
let tab = BPKNavigationTabGroup.Item(
    text: "Flights",
    icon: .flight,  // Optional BPKIcon
    accessibilityIdentifier: "flightsTab"  // Optional, defaults to "navigationTab" + text
)
```
