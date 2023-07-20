# Section Header

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSectionHeader.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/SectionHeader)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_section-header___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_section-header___default_dm.png" alt="" width="375" /> |

## On Dark

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_section-header___on-dark_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_section-header___on-dark_dm.png" alt="" width="375" /> |

## Usage

### Basic section header with a title. 
If you don't specify a `style` parameter it will use the `.default` type

```swift
BPKSectionHeader(title: "Section title")
```

### Section header with a title and description. 

```swift 
BPKSectionHeader(
    title: "Section title",
    description: "Description about this section"
)
```

### Section header with a title, description and trailing button. 

```swift 
BPKSectionHeader(
    title: "Section title",
    description: "Description about this section") {
        BPKButton(icon: .addCircle, accessibilityLabel: "Add item") {
            print("Tap add button")
        }
}
```

### Section header with a title, description, trailing button and onDark style. 

```swift 
BPKSectionHeader(
    title: "Section title",
    description: "Description about this section",
    style: .onDark) {
        BPKButton(icon: .addCircle, accessibilityLabel: "Add item") {
            print("Tap add button")
        }
}
```
