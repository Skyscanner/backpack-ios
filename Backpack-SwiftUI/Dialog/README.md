# Backpack-SwiftUI/Dialog

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKDialog.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Dialog)

## Success

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_dialog___success_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_dialog___success_dm.png" alt="" width="375" /> |
 
## Warning

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_dialog___warning_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_dialog___warning_dm.png" alt="" width="375" /> |

## Destructive

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_dialog___destructive_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_dialog___destructive_dm.png" alt="" width="375" /> |

## Image

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_dialog___image_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_dialog___image_dm.png" alt="" width="375" /> |

## Flare

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_dialog___flare_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_dialog___flare_dm.png" alt="" width="375" /> |

## Usage

`BPKDialog` works as a `ViewModifier` that can be applied to any SwiftUI `View`.
It's presented by binding the `presented` property to a `Binding<Bool>`.

```swift
@State var isPresented = false

var body: some View {
    BPKButton("Show dialog") {
        isPresented.toggle()
    }
    .bpkSuccessDialog(
        presented: $isPresented,
        title: "Success Dialog!",
        text: "You have completed this task.",
        confirmButton: BPKDialogButton("Confirm") { isPresented.toggle() }
    )
}
```

### Setting Actions

Dialogs can have actions associated with them, in the form of buttons or by tapping outside of the dialog. These are represented by `BPKDialogButton` instances.

The dialog will decide what style of button to use based on the type of dialog.

You can also set the action to be performed when the dialog is dismissed by tapping outside of it by setting the `onTouchOutside` property.

```swift
Text("Screen content")
    .bpkSuccessDialog(
        presented: $isPresented,
        title: "Success Dialog!",
        text: "You have completed this task.",
        confirmButton: BPKDialogButton("Confirm") { isPresented.toggle() },
        secondaryButton: BPKDialogButton("Secondary") { isPresented.toggle() },
        linkButton: BPKDialogButton("Learn more") { isPresented.toggle() },
        onTouchOutside: { isPresented.toggle() }
    )
```

### Success Dialog

```swift
Text("Screen content")
    .bpkSuccessDialog(
        presented: $isPresented,
        title: "Success Dialog!",
        text: "You have completed this task.",
        confirmButton: BPKDialogButton("Confirm") { isPresented.toggle() }
    )
```

### Warning Dialog

```swift
Text("Screen content")
    .bpkWarningDialog(
        presented: $isPresented,
        title: "Warning Dialog!",
        text: "Be careful with this task.",
        confirmButton: BPKDialogButton("Confirm") { isPresented.toggle() }
    )
```

### Destructive Dialog

```swift
Text("Screen content")
    .bpkDestructiveDialog(
        presented: $isPresented,
        title: "Destructive Dialog!",
        text: "This task is very dangerous.",
        confirmButton: BPKDialogButton("Confirm") { isPresented.toggle() }
    )
```

### Image Dialog

```swift
Text("Screen content")
    .bpkImageDialog(
        presented: $isPresented,
        image: Image("your_image"),
        title: "Look at this image!",
        text: "Isn't it great?",
        confirmButton: BPKDialogButton("Confirm") { isPresented.toggle() }
    )
```

### Flare Dialog

```swift
Text("Screen content")
    .bpkFlareDialog(
        presented: $isPresented,
        image: Image("your_flare_image"),
        title: "Look at this flare!",
        text: "Isn't it great?",
        confirmButton: BPKDialogButton("Confirm") { isPresented.toggle() }
    )
```
