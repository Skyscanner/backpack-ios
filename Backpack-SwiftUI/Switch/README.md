Switch

## Usage

### Regular Switch
If you don't specify a `size`, it will use `.large`

```swift
import Backpack_SwiftUI
@State var isEnabled = true

BPKSwitch(isOn: $isEnabled)
```

### Switch with `small` size
```swift
import Backpack_SwiftUI
@State var isEnabled = true

BPKSwitch(isOn: $isEnabled, size: .small)
```
