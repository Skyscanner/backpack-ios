# Sponsored Inset Banner

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSponsoredInsetBanner.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/InsetBanner)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_sponsored-inset-banner___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_sponsored-inset-banner___default_dm.png" alt="" width="375" /> |

## Usage

`BPKSponsoredInsetBanner` is a specialized banner component designed for sponsored content. It requires a logo and a sponsored label with an information icon. The title, subheadline, and image are optional.

### Basic usage with logo and sponsored label

```swift 
BPKSponsoredInsetBanner(
    logo: Image("logo").resizable().scaledToFit(),
    sponsoredLabel: "Sponsored",
    onSponsoredLabelTapped: {
        // Handle sponsored info tap
    }
)
```

### With title and subheadline

```swift 
BPKSponsoredInsetBanner(
    logo: Image("logo").resizable().scaledToFit(),
    sponsoredLabel: "Sponsored",
    onSponsoredLabelTapped: {
        // Handle sponsored info tap
    },
    title: "Amazing offer just for you",
    subheadline: "Limited time only - book now"
)
```

### With optional image

The image will be displayed below the main content with a maximum height of 120pt:

```swift 
BPKSponsoredInsetBanner(
    logo: Image("logo").resizable().scaledToFit(),
    sponsoredLabel: "Sponsored",
    onSponsoredLabelTapped: {
        // Handle sponsored info tap
    },
    title: "Summer getaway",
    subheadline: "Save up to 40% on selected destinations",
    image: Image("destination").resizable().scaledToFit()
)
```

## Properties

- **logo** (required): The logo content to display. Can be any `View` but it's recommended to use an image or loading indicator. Maximum size: 88pt × 22pt.
- **sponsoredLabel** (required): The text for the sponsored label, typically "Sponsored".
- **onSponsoredLabelTapped** (required): Action to perform when the sponsored label with info icon is tapped.
- **title** (optional): The main title text.
- **subheadline** (optional): Additional descriptive text.
- **image** (optional): An image to display below the main content. Maximum height: 120pt.
