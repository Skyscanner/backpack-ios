Switch

## Usage

### Text Switch
Use a string to set the text shown by the switch as a `BPKText` label

```swift
import Backpack_SwiftUI
@State var isEnabled = true

BPKSwitch(isOn: $isEnabled, text: "Enable")
```

### Custom Switch
Use a custom `View` as the label of the switch

```swift
import Backpack_SwiftUI
@State var isEnabled = true

BPKSwitch(isOn: $isEnabled) {
    BPKText("Enable")
        .paddding()
}
```
