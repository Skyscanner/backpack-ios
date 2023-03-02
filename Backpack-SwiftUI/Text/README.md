#  Backpack-SwiftUI/Text

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKText.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Text)

## Body

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_text___body_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_text___body_dm.png" alt="" width="375" /> |

## Heading

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_text___heading_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_text___heading_dm.png" alt="" width="375" /> |

## Hero

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_text___hero_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_text___hero_dm.png" alt="" width="375" /> |

## Usage

### BpkText

```swift
import Backpack_SwiftUI

BPKText("Hello world")

BPKText("Hello world", style: .heading1)

BPKText("Hello world")
    .foregroundColor(.corePrimaryColor)
    .lineLimit(2)
    
```

### BpkAttributedText

```swift
import Backpack_SwiftUI

let items: [BPKAttributedText.Item] = [
    .init("Default item, with .bodyDefault and .textPrimary "),
    .init("With custom style ", style: .heading1),
    .init("With custom color ", color: .corePrimaryColor),
    .init("With custom everything ", style: .heading1, color: .corePrimaryColor)
]

BPKAttributedText(items: items)
    
```
