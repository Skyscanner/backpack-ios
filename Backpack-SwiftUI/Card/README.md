#  Backpack-SwiftUI/Card

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKCard.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Card)

## Default
### `BPKCard`
| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_card___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_card___default_dm.png" alt="" width="375" /> |
### `BPKDividedCard`
| Day | Night |
| --- | ----- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_divided-card___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_divided-card___default_dm.png" alt="" width="375" /> |

## Usage

### `BPKCard`

**Basic card**

```swift
import Backpack_SwiftUI
BPKCard {
    BPKText("Hello World")
}
```

**Set padding**

Set the padding to:
* `.small`
* `.none`

```swift
BPKCard(padding: .none) {
    BPKText("Hello World")
}
```

**Set elevation**

Set the elevation to:
* `.default`
* `.focus`
* `.none`

```swift
BPKCard(elevation: .focus) {
    BPKText("Hello World")
}
```

**Set corner radius**

Set the corner radius to:
* `.small`
* `.large`

```swift
/// Set it's corner radius
BPKCard(cornerStyle: .large) {
    BPKText("Hello World")
}
```

**Set tap gesture**
```swift
BPKCard {
    BPKText("You can tap me!")
}.onTapGesture {
    print("Card tapped!")
}
```

### `BPKDividedCard`

**Default**
```swift
BPKDividedCard {
    BPKText("PrimaryContent")
} secondaryContent: {
    BPKText("SecondaryContent")
}.onTapGesture {
    print("Card tapped!")
}
```

**Elevation**
The same as `BPKCard`
```swift
BPKDividedCard(elevation: .focus) {
    BPKText("PrimaryContent")
} secondaryContent: {
    BPKText("SecondaryContent")
}
```

**Padded**
```swift
BPKDividedCard {
    BPKText("PrimaryContent")
        .padding()
} secondaryContent: {
    BPKText("SecondaryContent")
        .padding()
}
```

