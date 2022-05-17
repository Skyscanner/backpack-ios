# Backpack / Switch

## Usage

### SwiftUI

```swift
import Backpack_SwiftUI
@State var isEnabled = true

BPKSwitch(isOn: $isEnabled)

/// Set it's size
BPKSwitch(isOn: $isEnabled, size: .small)
```
