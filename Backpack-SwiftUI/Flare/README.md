#  Backpack-SwiftUI/Flare

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKFlare.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Flare)

## All
| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_flare-view___all_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_flare-view___all_dm.png" alt="" width="375" /> |

## Usage

BPKFlareView receives a `ViewBuilder` that will be used to render the content of the flare.

### Centering content in the flare

You'll need to add extra padding to the `bottom` or `top` of the content depending on the direction of the flare.

```swift
BPKFlareView {
    Text("Hello World")
    .padding(.bottom)
}

BPKFlareView(direction: .top) {
    Text("Hello World")
    .padding(.top)
}
```

### Medium Flare Size

```swift
BPKFlareView {
    Text("Hello World")
}
```

### Rect Corners

```swift
BPKFlareView(roundedCorners: false) {
    Text("Hello World")
}
```

### Direction Top

```swift
BPKFlareView(direction: .top) {
    Text("Hello World")
}
```

### Small Flare Size

```swift    
BPKFlareView(size: .small) {
    Text("Hello World")
}
```

### Large Flare Size

```swift    
BPKFlareView(size: .large) {
    Text("Hello World")
}
```
