# Backpack-SwiftUI/NavigationTab

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKNavigationTabGroup.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/NavigationTab)

## Default (Horizontal)

| Day | Night |
| --- | --- |
| <img src="../Tests/NavigationTab/__Snapshots__/BPKNavigationTabGroupTests/test_default.light-mode.png" alt="" width="375" /> | <img src="../Tests/NavigationTab/__Snapshots__/BPKNavigationTabGroupTests/test_default.dark-mode.png" alt="" width="375" /> |

## On Dark

| Day | Night |
| --- | --- |
| <img src="../Tests/NavigationTab/__Snapshots__/BPKNavigationTabGroupTests/test_dark.light-mode.png" alt="" width="375" /> | <img src="../Tests/NavigationTab/__Snapshots__/BPKNavigationTabGroupTests/test_dark.dark-mode.png" alt="" width="375" /> |

## On Dark Alternate

| Day | Night |
| --- | --- |
| <img src="../Tests/NavigationTab/__Snapshots__/BPKNavigationTabGroupTests/test_darkAlternate.light-mode.png" alt="" width="375" /> | <img src="../Tests/NavigationTab/__Snapshots__/BPKNavigationTabGroupTests/test_darkAlternate.dark-mode.png" alt="" width="375" /> |

## Vertical

| Day | Night |
| --- | --- |
| <img src="../Tests/NavigationTab/__Snapshots__/BPKNavigationTabGroupTests/test_vertical.light-mode.png" alt="" width="375" /> | <img src="../Tests/NavigationTab/__Snapshots__/BPKNavigationTabGroupTests/test_vertical.dark-mode.png" alt="" width="375" /> |

## Vertical On Dark

| Day | Night |
| --- | --- |
| <img src="../Tests/NavigationTab/__Snapshots__/BPKNavigationTabGroupTests/test_verticalOnDark.light-mode.png" alt="" width="375" /> | <img src="../Tests/NavigationTab/__Snapshots__/BPKNavigationTabGroupTests/test_verticalOnDark.dark-mode.png" alt="" width="375" /> |

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

Three styles are available: `.default`, `.onDark`, and `.onDarkAlternate`.

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

#### On dark alternate style (dark backgrounds with darker blue selection)

```swift
BPKNavigationTabGroup(
    tabs: tabs,
    style: .onDarkAlternate,
    selectedIndex: $selectedIndex
) { index in }
```

### Item Alignment

Two alignments are available: `.horizontal` (default) and `.vertical`.

#### Horizontal alignment (icon beside text)

```swift
BPKNavigationTabGroup(
    tabs: tabs,
    itemAlignment: .horizontal,
    selectedIndex: $selectedIndex
) { index in }
```

#### Vertical alignment (icon above text, pill shape)

```swift
BPKNavigationTabGroup(
    tabs: tabs,
    itemAlignment: .vertical,
    selectedIndex: $selectedIndex
) { index in }
```

### Combining Style and Alignment

```swift
// Vertical tabs on dark background
BPKNavigationTabGroup(
    tabs: tabs,
    style: .onDark,
    itemAlignment: .vertical,
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
