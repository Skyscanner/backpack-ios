# Inset Banner

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKInsetBanner.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/InsetBanner)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_inset-banner___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_inset-banner___default_dm.png" alt="" width="375" /> |
.

## Usage

All text fields in `BPKInsetBanner` are optional, though it requires having either a logo, title or subheading (or a combination). The background colour is customizable, while the text and info icon's colour rely on the `variant`.

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

### Inserting logo content

The `logoContent` to be inserted can be any `View` but **it is not recommended to insert anything but an image or a loading indicator**:



```swift 
BPKInsetBanner(
    logoContent: Image("skyland").resizable().scaledToFit(),
    title: "Title",
    subheadline: "Subheading",
    callToAction: .init(
        text: "Sponsored",
        accessibilityHint: "Double tap for more information",
        showIcon: true),
    bodyText: "You can change your destination, date of travel," +
    " or both, with no change fee. Valid for all " +
    "new bookings made up to 31 May for travel between now and 31 December 2023.",
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