# Card

## Usage

### Basic card

```swift
import Backpack_SwiftUI
BPKCard {
    BPKText("Hello World")
}
```

### Set padding
Set the padding to:
* `.small`
* `.none`

```swift
BPKCard(padding: .none) {
    BPKText("Hello World")
}
```

### Set elevation
Set the elevation to:
* `.default`
* `.focus`
* `.none`

```swift
BPKCard(elevation: .focus) {
    BPKText("Hello World")
}
```

### Set corner radius
Set the corner radius to:
* `.small`
* `.large`

```swift
/// Set it's corner radius
BPKCard(cornerStyle: .large) {
    BPKText("Hello World")
}
```

### Set tap gesture
```swift
BPKCard {
    BPKText("You can tap me!")
}.onTapGesture {
    print("Card tapped!")
}
```