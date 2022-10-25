# Backpack-SwiftUI/Badge

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_badge___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_badge___default_dm.png) |
 
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