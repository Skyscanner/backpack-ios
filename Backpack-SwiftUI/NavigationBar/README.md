# Backpack-SwiftUI/NavigationView

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKNavigationView.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/NavigationView)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_navbar___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_navbar___default_dm.png" alt="" width="375" /> |
 
## Transparent

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_navbar___transparent_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_navbar___transparent_dm.png" alt="" width="375" /> |
 
## Surface Contrast

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_navbar___surfaceContrast_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_navbar___surfaceContrast_dm.png" alt="" width="375" /> |
 
## Usage

Similar to SwiftUI's native `NavigationView`, `BPKNavigationView` is used to manage the navigation of a view hierarchy. You can set a title and an array of leading and trailing items.

### Leading and Trailing Items

An enum is defined with the different types of items that can be used as leading or trailing items. The available types are:

- `icon`
- `title`
- `backButton`
- `closeButton`

```swift
BPKNavigationView(
    title: "Title",
    leadingItems: [.init(type: .backButton("Back"), action: {})]
) {
    Text("Content")
}

BPKNavigationView(
    title: "Title",
    leadingItems: [.init(type: .closeButton("Close"), action: {})],
    trailingItems: [
        .init(type: .icon(.ai, "AI"), action: {},
        .init(type: .icon(.calendar, "Calendar"), action: {})
    ]
) {
    Text("Content")
}
```

### Customising the Navigation Bar

You can customise the navigation bar by setting the `style` property. All except for surfaceContrast support setting a `TitleDisplayMode`.

- `default(TitleDisplayMode)`
- `transparent(TitleDisplayMode)`
- `surfaceContrast` (only supports inline style)

#### Default

```swift
BPKNavigationView(
    title: "Title",
    style: .default(.large)
) {
    Text("Content")
}
```

#### Transparent

```swift
BPKNavigationView(
    title: "Title",
    style: .transparent(.automatic)
) {
    Text("Content")
}
```

#### Surface Contrast

```swift
BPKNavigationView(
    title: "Title",
    style: .surfaceContrast
) {
    Text("Content")
}
```