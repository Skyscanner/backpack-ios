#  Backpack-SwiftUI/Select

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSelect.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Select)

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_select___picker_open_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_select___picker_open_dm.png" alt="" width="375" /> |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_select___picker_closed_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_select___picker_closed_dm.png" alt="" width="375" /> |

# Usage

Create a `BPKSelect` and pass a `placeholder: String` , a set of `options: [String]` and provide the `selectedIndex` property as a `Binding<Int?>`.
If you want to show the placeholder text, provide a selectedIndex that is initially bound to `nil`

### Select Showing Placeholder
```swift
@State var selection: Int? = nil
@State var choices = ["Item 1", "Item 2", "Item 3"]

BPKSelect(placeholder: "Placeholder",
          options: choices,
          selectedIndex: $selection)
```

### Select With Item Selected
```swift
@State var selection: Int? = 0
@State var choices = ["Item 1", "Item 2", "Item 3"]

BPKSelect(placeholder: "Placeholder",
          options: choices,
          selectedIndex: $selection)
```

### Changing the State
    
```swift
BPKSelect(placeholder: "List Error State",
          options: badChoices,
          selectedIndex: $errorSelection)
          .inputState(.error)
    }
```
