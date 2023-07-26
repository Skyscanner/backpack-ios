
# Backpack-SwiftUI/Bottom sheet

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKDialog.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Dialog)

## Default Bottom Sheet

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___fullsize_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___fullsize_dm.png" alt="" width="375" /> |
 
## Modal Bottom Sheet

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___regular_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_bittom-sheet___regular_dm.png" alt="" width="375" /> |

## Usage

`BPKBottomSheet` works as a `ViewModifier` that can be applied to any SwiftUI `View`.
It's presented by binding the `isPresented` property to a `Binding<Bool>`.

You can close the bottom sheet by dragging the handle.

### Default Bottom Sheet

```swift
@State var isPresented = false

var body: some View {
    BPKButton("Show bottom sheet") {
        showBottomSheet.toggle()
    }
    .bpkBottomSheet(
        isPresented: $showBottomSheet,
        maxHeight: 500,
        bottomSheetContent: {
            content
        }
    )
}
```

### Modal Bottom Sheet

The modal bottom sheet can have a header with close icon, title and any action you want. All of them are optional to set.

Always launches at 50% height.

You can close the modal bottom sheet by tapping the close icon, or swiping to dismiss.

```swift
BPKButton("Show bottom sheet") {
    showBottomSheet.toggle()
}
.bpkCloseableBottomSheet(
    isPresented: $showBottomSheet,
    maxHeight: 600,
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
