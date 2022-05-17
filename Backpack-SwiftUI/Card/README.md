# Backpack / Card

## Usage

### SwiftUI

```swift
import Backpack_SwiftUI
BPKCard {
    BPKText("Hello World")
}
/// Set it's elevation
BPKCard(elevation: .focus) {
    BPKText("Hello World")
}
/// Set it's padding
BPKCard(padding: .none) {
    BPKText("Hello World")
}
/// Set it's corner radius
BPKCard(cornerStyle: .large) {
    BPKText("Hello World")
}
```
