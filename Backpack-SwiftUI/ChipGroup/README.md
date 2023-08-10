# Backpack/ChipGroup

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Classes/BPKSingleSelectChipGroup.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/ChipGroup)

## Rail - Single Select

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group-single___rail_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group-single___rail_dm.png" alt="" width="375" /> |

## Wrap - Single Select

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group-single___wrap_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group-single___wrap_dm.png" alt="" width="375" /> |

## Rail - Multi Select

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group-multi___rail_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group-multi___rail_dm.png" alt="" width="375" /> |

## Wrap - Multi Select

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group-multi___wrap_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip-group-multi___wrap_dm.png" alt="" width="375" /> |


## Usage

### Single Select

Create ChipItems to be used in the group.

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

#### Single line group

```swift
@State var selectedIndex: Int? = nil
BPKSingleSelectChipGroup(
    chips: chips,
    selectedIndex: selectedIndex,
    type: .rail
) {
    print("Chip item tapped")
}
```

#### Single line group on dark background: 

```swift
BPKSingleSelectChipGroup(
    chips: chips,
    style: .onDark,
    selectedIndex: selectedIndex
) {
    print("Chip item tapped")
}
```

#### Single line group on an image background: 

```swift
BPKSingleSelectChipGroup(
    chips: chips,
    style: .onImage,
    selectedIndex: selectedIndex
) {
    print("Chip item tapped")
}
```

#### Multiple lines of chips group 

```swift
BPKSingleSelectChipGroup(
    chips: chips,
    selectedIndex: selectedIndex,
    type: .wrap
) {
    print("Chip item tapped")
}
```

### Multiple Select

Create ChipItems to be used in the group.

```swift
@State var chips: [BPKMultiSelectChipGroup.ChipItem] = [
    .init(text: "Shenzhen", icon: .city, selected: true),
    .init(text: "London", icon: .city, selected: true),
    .init(text: "Edinburgh", selected: false),
    .init(text: "Manchester", selected: false),
    .init(text: "Belfast", selected: false),
]
```

#### Single line group

```swift
BPKMultiSelectChipGroup(
    chips: chips,
    type: .rail(stickyChip: nil)
)
```

#### Single line group on dark background: 

```swift
BPKMultiSelectChipGroup(
    chips: chips,
    style: .onDark
)
```

#### Single line group on an image background: 

```swift
BPKMultiSelectChipGroup(
    chips: chips,
    style: .onImage
)
```

#### Single line group with a sticky chip: 

```swift
BPKMultiSelectChipGroup(
    chips: chips,
    type: .rail(stickyChip: .init(accessibilityLabel: "Filters", icon: .filter, selected: false))
)
```

#### Multiple lines of chips group 

```swift
BPKMultiSelectChipGroup(
    chips: chips,
    type: .wrap
)
```