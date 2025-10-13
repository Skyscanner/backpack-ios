# Backpack-SwiftUI/Link

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKLink.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Link)

## Usage

### Basic link

```swift
import Backpack_SwiftUI

BPKLink(
    markdown: "By continuing you agree to the [Terms of Use](https://www.example.com/terms)."
)
```

### Handling custom schemes

```swift
import Backpack_SwiftUI
import Backpack_Common

BPKLink(
    markdown: "Read the [terms](app://terms) and [privacy policy](app://privacy).",
    style: .onContrast
) { url in
    switch url.host ?? url.path {
    case "terms", "/terms":
        presentTermsSheet()
    case "privacy", "/privacy":
        presentPrivacySheet()
    default:
        break
    }
}
.background(Color(BPKColor.surfaceContrastColor))
```
