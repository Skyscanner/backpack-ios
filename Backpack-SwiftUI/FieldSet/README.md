#  Backpack-SwiftUI/BannerAlert

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKFieldSet.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/BPKFieldSet)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_field-set___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_field-set___default_dm.png" alt="" width="375" /> |

## Error

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_field-set___error_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_field-set___error_dm.png" alt="" width="375" /> |

# Usage

FieldSet is a component which wraps its content (view) and optionally adds a title, description and error label (depending on the field's state) around it.

Supported states are Default, and Error. The states are dispatched to the wrapped view through the .environment modifier.


## BPKFieldSet

### Example of a FieldSet with Default state:

```swift
BPKFieldSet(label: "Label", description: "Description") {
    BPKTextField(placeholder: "Enter text", .constant(""))
}
```

### Example of a FieldSet with Error state:

```swift
BPKFieldSet(label: "Label", description: "Description") {
    BPKTextField(placeholder: "Enter text", .constant(""))
}
.inputState(.error(message: "Error Message"))
```
