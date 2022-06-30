# Badge
 
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