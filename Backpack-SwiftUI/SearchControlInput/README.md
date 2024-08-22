#  Backpack-SwiftUI/SearchControlInput

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSearchControlInput.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/SearchControlInput)

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_search-control-input___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_search-control-input___default_dm.png" alt="" width="375" /> |

# Usage

Create a `BPKSearchControlInput` and set properties: `placeholder`, `label`, `value`, `icon`, `style` (default value: `.regular`), `accessibilityLabel`, `action`, and `accessibilityValueHandler` (optional property).

```swift
@State var value: String?

let clickAction = {
    // Place action handler here
}

BPKSearchControlInput(placeholder: "Placeholder", value: value, icon: .calendar, accessibilityLabel: "Input Field", action: clickAction)
```

### Setting a style
Default value is `regular`.

```swift
BPKSearchControlInput(placeholder: "Placeholder", value: value, icon: .regular, accessibilityLabel: "Input Field", action: clickAction)
```

```swift
BPKSearchControlInput(placeholder: "Placeholder", value: value, icon: .onContrast, accessibilityLabel: "Input Field", action: clickAction)
```

### Using accessibilityValueHandler

When a value is not suitable for Accessibility announcments, this optional handler lets you to return a formatted string.
For example, when a displayed value is "13 - 20 Sep", it's better to adapt for accessibility users, so it would be like "From September 13 to September 20"
    
```swift
BPKSearchControlInput(
    placeholder: "Placeholder", 
    value: value, 
    icon: .onContrast, 
    accessibilityLabel: "Input Field",
    accessibilityValueHandler: {
        let formattedText = formatter.adapt(value)
        return formattedText
    },
    action: clickAction
)
```

### UI Testing

In purpose of using the component in UI or smoke tests the accessibility identifier should be set in the place where the component is used.

```swift
BPKSearchControlInput(placeholder: "Placeholder", value: value, icon: .regular, accessibilityLabel: "Input Field", action: clickAction)
    .accessibilityIdentifier("search_control_input_custom_field")
```

This element could be found in UI test as a button.
```swift
let searchControlInput = app.buttons["search_control_input_custom_field"]
```
