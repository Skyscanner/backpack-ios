# Backpack-SwiftUI/Badge

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKBadge.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Badge)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_badge___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_badge___default_dm.png" alt="" width="375" /> |
 
## Usage

### Basic text badge
If you don't specify a `.badgeStyle(<style>)` it will use the `.default` type

```swift
import Backpack_SwiftUI

BPKBadge("Hello World")

BPKBadge("Hello World")
    .badgeStyle(.destructive)
```

### Badge with icon
If you don't specify a `.badgeStyle(<style>)` it will use the `.default` type

```swift
import Backpack_SwiftUI

BPKBadge("Hello World", icon: .tickCircle)

BPKBadge("Hello World", icon: .tickCircle)
    .badgeStyle(.destructive)
```