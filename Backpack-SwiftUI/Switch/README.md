# Backpack-SwiftUI/Switch

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSwitch.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Switch)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_switch___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_switch___default_dm.png" alt="" width="375" /> |

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
