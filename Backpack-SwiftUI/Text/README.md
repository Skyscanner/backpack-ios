#  Backpack-SwiftUI/Text

## Usage

### BPKText

```swift
import Backpack_SwiftUI

BPKText("Hello world")

BPKText("Hello world", style: .heading1)

BPKText("Hello world")
    .foregroundColor(.skyBlue)
    .lineLimit(2)
    
```

### BPKAttributedText

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
