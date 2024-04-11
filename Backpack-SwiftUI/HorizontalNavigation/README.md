# HorizontalNavigation

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKBadge.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Badge)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_horizontal-navigation___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_horizontal-navigation___default_dm.png" alt="" width="375" /> |

## Usage

```swift
@State var selectedTab: Int = 0
BPKHorizontalNavigation(
    tabs: [
        .init(title: "Flights", icon: .flight),
        .init(title: "Hotels", icon: .hotel),
        .init(title: "Cars", icon: .car)
    ],
    selectedTab: $selectedTab
)
```

### Setting the Size

BPkHorizontalNavigation supports both a `default` and a `small` size.

```swift
@State var selectedTab: Int = 0
BPKHorizontalNavigation(
    tabs: [
        .init(title: "Flights", icon: .flight),
        .init(title: "Hotels", icon: .hotel),
        .init(title: "Cars", icon: .car)
    ],
    size: .small,
    selectedTab: $selectedTab
)
```

### Tabs withou icons

```swift
@State var selectedTab: Int = 0
BPKHorizontalNavigation(
    tabs: [
        .init(title: "Flights"),
        .init(title: "Hotels"),
        .init(title: "Cars")
    ],
    selectedTab: $selectedTab
)
```
