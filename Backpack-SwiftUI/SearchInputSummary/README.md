#  Backpack-SwiftUI/SearchInputSummary

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSearchInputSummary.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/SearchInputSummary)

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_search-input-summary___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_search-input-summary___default_dm.png" alt="" width="375" /> |

# Usage

Create a `BPKSearchInputSummary` and bind the `text` property to a `Binding<String>`.

```swift
@State var text: String = ""

BPKSearchInputSummary(text: $text)
```

### Setting a placeholder

```swift
BPKSearchInputSummary("Placeholder", text: $text)
```

### Setting an inputPrefix
Default value is `icon`.

```swift
BPKSearchInputSummary(inputPrefix: .icon, text: $text)
```

```swift
BPKSearchInputSummary(inputPrefix: .customText("From"), text: $text)
```

### Changing the State
    
```swift
BPKSearchInputSummary(text: $text)
    .inputState(.error)
    .inputState(.valid)
```

### Adding a clear button

```swift
@State var text: String = "some text"

BPKSearchInputSummary(text: $text)
    .inputState(
        .clear(
            accessibilityLabel: "Clear",
            action: { text = "" }
        )
    )
```

### Passing input focused value
Default value is `icon`.

```swift
BPKSearchInputSummary(inputPrefix: .icon, text: $text)
```

```swift
BPKSearchInputSummary(inputPrefix: .customText("From"), text: $text)
```
