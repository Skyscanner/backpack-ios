# Inset Banner

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKInsetBanner.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/InsetBanner)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_inset-banner___landscape_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_inset-banner___landscape_dm.png" alt="" width="375" /> |


## Usage

All text fields are optional, which means by default `BPKInsetBanner` has no content (it only shows the padding). The background colour is customizable, while the text and info icon's colour rely on the `variant`.

```swift 
BPKInsetBanner(
    title: "Title",
    subheadline: "Subheading",
    callToAction: .init(
        text: "Sponsored",
        accessibilityLabel: "More Information"),
    bodyText: "This text shows when tapping the banner",
    variant: .onDark,
    backgroundColor: Color(red: 1.000, green: 0.400, blue: 0.004, opacity: 1.000)
)
```

The info icon can be disabled passing the `showIcon` value in `callToAction`: 

```swift 
BPKInsetBanner(
    title: "Title",
    subheadline: "Subheading",
    callToAction: .init(
        text: "Sponsored",
        accessibilityLabel: "More Information",
        showIcon: false),
    bodyText: "This text shows when tapping the banner",
    variant: .onDark,
    backgroundColor: Color(red: 1.000, green: 0.400, blue: 0.004, opacity: 1.000)
)
```