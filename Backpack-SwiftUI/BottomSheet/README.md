
# Backpack-SwiftUI/Bottom sheet

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKBottomSheet.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/BPKBottomSheet)

## Default Bottom Sheet

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___default_dm.png" alt="" width="375" /> |

## Default Closeable Bottom Sheet

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___default-closeable_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___default-closeable_dm.png" alt="" width="375" /> |

 
## Modal Bottom Sheet

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___modal_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___modal_dm.png" alt="" width="375" /> |

## Modal Closeable Bottom Sheet

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___modal-closeable_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___modal-closeable_dm.png" alt="" width="375" /> |

## Usage

`BPKBottomSheet` works as a `ViewModifier` that can be applied to any SwiftUI `View`.
It's presented by binding the `isPresented` property to a `Binding<Bool>`.

The default bottom sheet can be set or dragged to any height.

The closeable bottom sheet can have a header with close icon, title and any action you want. All of them are optional to set.

You can close the bottom sheet by dragging the handle, tapping the close icon, or swiping to dismiss.

### Default Bottom Sheet

```swift
BPKButton("Show bottom sheet") {
    showBottomSheet.toggle()
}
.bpkBottomSheet(
    isPresented: $showBottomSheet,
    maxHeight: 600,
    contentMode: .fullSize,
    bottomSheetContent: {
        content
    }
)
```

### Default Closeable Bottom Sheet

```swift
BPKButton("Show bottom sheet") {
    showBottomSheet.toggle()
}
.bpkCloseableBottomSheet(
    isPresented: $showBottomSheet,
    maxHeight: 600,
    contentMode: .fullSize,
    closeButtonAccessibilityLabel: "Close button",
    title: "Title",
    action: BPKBottomSheetAction(
        title: "Action",
        action: {
            print("Action button tapped")
        }
    )
) { content }
```

### Modal Bottom Sheet

```swift
BPKButton("Show bottom sheet") {
    showBottomSheet.toggle()
}
.bpkBottomSheet(
    isPresented: $showBottomSheet,
    maxHeight: 600,
    contentMode: .regular,
    bottomSheetContent: {
        content
    }
)
```


### Modal Closeable Bottom Sheet

```swift
BPKButton("Show bottom sheet") {
    showBottomSheet.toggle()
}
.bpkCloseableBottomSheet(
    isPresented: $showBottomSheet,
    maxHeight: 600,
    contentMode: .regular,
    closeButtonAccessibilityLabel: "Close button",
    title: "Title",
    action: BPKBottomSheetAction(
        title: "Action",
        action: {
            print("Action button tapped")
        }
    )
) { content }
```
