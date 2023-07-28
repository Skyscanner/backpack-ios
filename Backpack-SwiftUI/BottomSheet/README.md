
# Backpack-SwiftUI/Bottom sheet

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKBottomSheet.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/BPKBottomSheet)

## Large Bottom Sheet

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bottom-sheet___large_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bottom-sheet___large_dm.png" alt="" width="375" /> |

## Medium Bottom Sheet

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bottom-sheet___medium_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bottom-sheet___medium_dm.png" alt="" width="375" /> |

 
## Content Fit Bottom Sheet

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bottom-sheet___content-fit_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bottom-sheet___content-fit_dm.png" alt="" width="375" /> |

## Modal Closeable Bottom Sheet

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bottom-sheet___closable_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bottom-sheet___closable_dm.png" alt="" width="375" /> |

## Usage

`BPKBottomSheet` works as a `ViewModifier` that can be applied to any SwiftUI `View`.
It's presented by binding the `isPresented` property to a `Binding<Bool>`.

The `medium` bottom sheet can be dragged to full screen.

You can close the bottom sheet by dragging the handle, tapping the close icon or by tapping the scrim.

### Large Bottom Sheet

```swift
BPKButton("Show bottom sheet") {
    showBottomSheet.toggle()
}
.bpkBottomSheet(
    isPresented: $showBottomSheet,
    contentMode: .large) {
        content
    }
```

### Closeable Bottom Sheet

```swift
BPKButton("Show bottom sheet") {
    showBottomSheet.toggle()
}
.bpkCloseableBottomSheet(
    isPresented: $showBottomSheet,
    contentMode: .medium,
    closeButtonAccessibilityLabel: "Close button") {
        content
    }
```

### Content Fit Bottom Sheet

```swift
BPKButton("Show bottom sheet") {
    showBottomSheet.toggle()
}
.bpkBottomSheet(
    isPresented: $showBottomSheet,
    contentMode: .contentFit) {
        content
    }
```
