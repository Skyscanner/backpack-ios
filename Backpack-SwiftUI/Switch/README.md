# Backpack-SwiftUI/Switch

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_switch___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_switch___default_dm.png) |

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
