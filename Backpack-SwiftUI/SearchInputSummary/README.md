#  Backpack-SwiftUI/SearchInputSummary

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSearchInputSummary.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/SearchInputSummary)

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_search-input-summary___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_search-input-summary___default_dm.png" alt="" width="375" /> |

# Basic Usage

Create a `BPKSearchInputSummary` and bind the `text` property to a `Binding<String>`. Another mandatory property is `clearAction` which is a struct with an accessibility label for the action, where you can explain what happens when a user clicks on the button, also you need provide an action as a closure.

```swift
@State var text: String = ""

BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "Clear", action: { $text = "" }), text: $text)
```

### Setting a placeholder

```swift
BPKSearchInputSummary(placeholder: "Enter", clearAction: .init(accessibilityLabel: "Clear", action: {}), .constant(""))
```

### Setting an inputPrefix
Default value is `icon`.

```swift
BPKSearchInputSummary(inputPrefix: .icon, clearAction: .init(accessibilityLabel: "Clear", action: {}), text: $text)
```

```swift
BPKSearchInputSummary(inputPrefix: .customText("From"), clearAction: .init(accessibilityLabel: "Clear", action: {}), text: $text)
```

### Making the field in focused style
In case you need to make a field in focus visually (make borders look selected) you can set a `focused` style. This style is not affecting the keboard appearance or editing state in a field, it's only about the field appearance.
    
```swift
BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "Clear", action: {}), text: $text)
    .customStyle(.focused) // or .customStyle(.default)
```

### Read only mode
In case you need a field would be uneditable you can pass `readonly` property into an inialiser. It prevents any actions on the text field, but the clear button would be still clickable.

```swift
BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "Clear", action: { $text = "" }), readonly: true, text: $text)
```

### UI Testing
To use the component in UI or smoke tests it's possible to access this element using the accessibility identifier: `search_field`

### Accessibility

By default, BPKSearchInputSummary provides an accessibility value and traits. However, it's a good practice to set an accessibility label as well.

```swift
BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "Clear", action: { $text = "" }), text: $text)
    .accessibilityLabel("Custom input field")
```

There is a built-in announcement of a current value. However, if it's necessary, the custom value could be passed as a parameter. It can be useful for announcing dates, for example. 

```swift
BPKSearchInputSummary(placeholder: "Date", clearAction: .init(accessibilityLabel: "Clear", action: {}), customAccessibilityValue: , .constant("Mon 01 Jan"))
```

Accessibility Label is always a value from `placeholder` parameter.