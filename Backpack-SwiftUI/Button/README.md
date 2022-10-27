# Button

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKButton.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Button)

## Primary

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___primary_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___primary_dm.png) |

## PrimaryOnLight

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___primaryOnLight_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___primaryOnLight_dm.png) |

## PrimaryOnDark

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___primaryOnDark_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___primaryOnDark_dm.png) |

## Secondary

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___secondary_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___secondary_dm.png) |

## Featured

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___featured_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___featured_dm.png) |


## Destructive

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___destructive_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___destructive_dm.png) |

## Link

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___link_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_button___link_dm.png) |

## Usage

### Basic button with a title and action closure. 
If you don't specify a `.buttonStyle(<type>)` it will use the `.primary` type

```swift
BPKButton("Button title") {
    print("Button tap closure")
}
```

### Styled .secondary Button.

```swift 
BPKButton("Button title") {
    print("Button tap closure")
}
.buttonStyle(.secondary)
```

### Button with a title and icon. 

Set the icon to:
* `.leading(icon: <BPKIcon>)` 
* `.trailing(icon: <BPKICon>)`

```swift
BPKButton(
    "Button title",
    icon: .leading(icon: .longArrowRight)
) {
    print("Button tap closure")
}

BPKButton(
    "Button title",
    icon: .trailing(icon: .longArrowRight)
) {
    print("Button tap closure")
}
```

### Button with loading state. 

Pass in a `@State` variable or use `.constant(true)` 

```swift
BPKButton(
    "Button title",
    loading: $isLoading
) {
    print("Button tap closure")
}
```

### Button with disabled state. 

Pass in a `@State` variable or use `.constant(true)` 

```swift
BPKButton(
    "Button title",
    enabled: $isEnabled
) {
    print("Button tap closure")
}
```

### Button with icon only
> Pass in `accessibilityLabel` when creating a button with just an icon

```swift
BPKButton(
    icon: .longArrowRight,
    accessibilityLabel: "Button label"
) {
    print("Button tap closure")
}
```

### Button with large size

```swift
BPKButton(
    "Button title",
    size: .large
) {
    print("Button tap closure")
}
```