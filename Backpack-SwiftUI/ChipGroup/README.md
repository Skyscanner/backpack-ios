# Backpack/ChipGroup

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Classes/BPKSingleSelectChipGroup.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/ChipGroup)

## Rail - Single Select

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group___rail_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group___rail_dm.png" alt="" width="375" /> |

## Wrap - Single Select

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group___wrap_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group___wrap_dm.png" alt="" width="375" /> |


## Usage

Create ChipItems that used in the BPKSingleSelectChipGroup
```swift
let chips: [BPKSingleSelectChipGroup.ChipItem] = [
    .init(text: "Shenzhen", icon: .city),
    .init(text: "London", icon: .city),
    .init(text: "Edinburgh"),
    .init(text: "Manchester"),
    .init(text: "Belfast"),
    .init(text: "Glasgow"),
    .init(text: "Gurham")
]
```

Single line group without default selected item: 
```swift
BPKSingleSelectChipGroup(
    chips: chips,
    selectedIndex: .constant(nil)
) {
    print("Chip item tapped")
}
```

Single line group with specific selected item: 
```swift
BPKSingleSelectChipGroup(
    chips: chips,
    selectedIndex: .constant(2)
) {
    print("Chip item tapped")
}
```

Single line group on dark background: 
```swift
BPKSingleSelectChipGroup(
    chips: chips,
    style: .onDark,
    selectedIndex: .constant(2)
) {
    print("Chip item tapped")
}
```

Single line group on an image background: 
```swift
BPKSingleSelectChipGroup(
    chips: chips,
    style: .onImage,
    selectedIndex: .constant(2)
) {
    print("Chip item tapped")
}
```

Multiple lines of chips group 
```swift
BPKSingleSelectChipGroup(
    chips: chips,
    selectedIndex: .constant(2),
    type: .wrap
) {
    print("Chip item tapped")
}
```
