#  Backpack-SwiftUI/Text

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_text___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_text___default_dm.png) |

## Multiple font styles

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_text___multiple-font-styles_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_text___multiple-font-styles_dm.png) |

## Usage

### BpkText

```swift
import Backpack_SwiftUI

BPKText("Hello world")

BPKText("Hello world", style: .heading1)

BPKText("Hello world")
    .foregroundColor(.skyBlue)
    .lineLimit(2)
    
```

### BpkAttributedText

```swift
import Backpack_SwiftUI

let items: [BPKAttributedText.Item] = [
    .init("Default item, with .bodyDefault and .textPrimary "),
    .init("With custom style ", style: .heading1),
    .init("With custom color ", color: .skyBlue),
    .init("With custom everything ", style: .heading1, color: .skyBlue)
]

BPKAttributedText(items: items)
    
```
