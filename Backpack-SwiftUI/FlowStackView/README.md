# Backpack-SwiftUI/FlowStackView

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKFlowStackView.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/FlowStackView)

## Usage
 
`BPKFlowStackView` is a SwiftUI view that arranges its children in a grid with a flexible number of columns and rows.
This view adjusts the number of columns based on the available width and the widths of the children.
If a child does not fit in the current row, it is placed in the next row.

### With default spacing and alignment

```swift
BPKFlowStackView(data: Array(0...20)) { item, index in
    BPKBadge("\(index)")
}
```

### Specifying spacing with a `BPKSpacing` value

```swift
BPKFlowStackView(
    data: Array(0...20),
    spacing: .sm
) { item, index in
    BPKBadge("\(index)")
}
```

### Specifying spacing with `.center` alignment

```swift
BPKFlowStackView(
    data: Array(0...20),
    alignment: .center,
) { item, index in
    BPKBadge("\(index)")
}
```
