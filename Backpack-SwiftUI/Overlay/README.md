# Backpack-SwiftUI/Overlay

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKPrice.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Price)

## Solid

Requires a level to be set.

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___solid_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___solid_dm.png" alt="" width="375" /> |

```swift
Image("image")
    .resizable()
    .frame(width: 200, height: 200)
    .bpkOverlay(.solid(.high))
    .cornerRadius(8)
```

## Linear

Requires a level to be set, as well as a direction.

```swift
Image("image")
    .resizable()
    .frame(width: 200, height: 200)
    .bpkOverlay(.linear(.high, .leading))
    .cornerRadius(8)
```

### Top

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___top_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___top_dm.png" alt="" width="375" /> |

### Bottom

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___bottom_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___bottom_dm.png" alt="" width="375" /> |

### Leading

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___leading_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___leading_dm.png" alt="" width="375" /> |

### Trailing

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___trailing_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___trailing_dm.png" alt="" width="375" /> |

## Vignette

```swift
Image("image")
    .resizable()
    .frame(width: 200, height: 200)
    .bpkOverlay(.vignette)
    .cornerRadius(8)
```

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___vignette_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_overlay___vignette_dm.png" alt="" width="375" /> |

## Usage

`BPKOverlay` provides the `bpkOverlay(BPKOverlayType)` View modifier that can be used to add an overlay to any view.

```swift
import Backpack_SwiftUI

var body: some View {
    Image("image")
        .resizable()
        .frame(width: 200, height: 200)
        .bpkOverlay(.solid(.high))
        .cornerRadius(8)
}
```
