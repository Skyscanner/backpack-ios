#  Backpack-SwiftUI/BannerAlert

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKBannerAlert.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/BannerAlert)

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_banner-alert___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_banner-alert___default_dm.png" alt="" width="375" /> |

# Usage

Banner alert comes in a number of types to indicate information, success, warning or error. Additionally, It supports two styles. 

## BPKBannerAlert

### How to initialize 

If you don't specify a `Style` it will use the `.default` style.

Supported `AlertType`s:
`info`, `success`, `warning`, `error`

Supported `Style`s:
`default`, `onContrast`

```swift
BPKBannerAlert(
    type: .warning(accessibilityLabel: "Warning"),
    style: .onContrast,
    message: "Hello World!",
    accessibilityIdentifier: "BannerAlertAccessibilityIdentifier"
)
```

### Using a custom icon

The custom icon will replace the type's default icon, but the type' color will be applied to it.

```swift
BPKBannerAlert(
    type: .error(accessibilityLabel: "Error"),
    style: style,
    message: "Mutliline banner with custom icon \nThis is a new line",
    customIcon: (BPKIcon.accountAdd, accessibilityLabel: "Account Add Icon")
)
```
