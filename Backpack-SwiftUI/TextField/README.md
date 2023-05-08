#  Backpack-SwiftUI/TextField

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKTextField.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/TextField)

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_text-field___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_text-field___default_dm.png" alt="" width="375" /> |

# Usage

Create a `BPKTextField` and bind the `text` property to a `Binding<String>`.

```swift
@State var text: String = ""

BPKTextField(text: $text)
```

### Setting a placeholder

```swift
BPKTextField("Placeholder", text: $text)
```

### Changing the State
    
```swift
BPKTextField(text: $text)
    .inputState(.error)
    .inputState(.valid)
```

### Adding a clear button

```swift
@State var text: String = "some text"

BPKTextField(text: $text)
    .inputState(
        .clear(
            accessibilityLabel: "Clear",
            action: { text = "" }
        )
    )
```
