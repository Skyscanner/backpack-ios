# Backpack/Dialog

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKDialog.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Dialog)

## Success

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___success_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___success_dm.png" alt="" width="375" /> |

## Warning

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___warning_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___warning_dm.png" alt="" width="375" /> |

## Destructive

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___destructive_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___destructive_dm.png" alt="" width="375" /> |

## Flare

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___flare_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___flare_dm.png" alt="" width="375" /> |

## Image

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___image_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___image_dm.png" alt="" width="375" /> |

## Usage 

Example of a success dialog with three buttons

```swift
// Basic definition
let iconTemplate = BPKIcon.makeLargeTemplateIcon(name: .tick)
let icon = BPKDialogIconDefinition(icon: iconTemplate, iconBackgroundColor: BPKColor.coreAccentColor)

let dialogController = BPKDialogController(
    title: "Title in here",
    message: "Description",
    iconDefinition: icon,
    flareView: nil
)

// Dialog buttons
let confirmation = BPKDialogButtonAction(title: "Confirmation", style: .featured) {_ in
    // Handle tap
}

let skip = BPKDialogButtonAction(title: "Skip", style: .secondary) {_ in
    // Handle tap
}

let optionalLink = BPKDialogButtonAction(title: "Optional link", style: .link) {_ in
    // Handle tap
}

dialogController.addButtonAction(confirmation)
dialogController.addButtonAction(skip)
dialogController.addButtonAction(optionalLink)

// Handling scrim tap
// If you don't set this, the dialog is not dismissed when tapping the scrim
let scrimAction = BPKDialogScrimAction(handler: { (didDismiss) in
    print("Scrim tap \(didDismiss ? "dimissing" : "")")
}, shouldDismiss: true)
dialogController.scrimAction = scrimAction

// Show the dialog
self.present(dialogController, animated: true)
```


Example of a flare dialog

```swift
// Flare view
let flareView = BPKFlareView(frame: .zero)
let image = UIImage(named: "dialog_flare")
let imageView = UIImageView.init(image: image)
imageView.contentMode = .scaleAspectFill
imageView.translatesAutoresizingMaskIntoConstraints = false

// Basic definition
let iconTemplate = BPKIcon.makeLargeTemplateIcon(name: .tick)
let icon = BPKDialogIconDefinition(icon: iconTemplate, iconBackgroundColor: BPKColor.coreAccentColor)

let dialogController = BPKDialogController(
    title: "Title in here",
    message: "Description",
    iconDefinition: icon,
    flareView: flareView
)

// Dialog buttons
let confirmation = BPKDialogButtonAction(title: "Confirmation", style: .featured) {_ in
    // Handle tap
}

let skip = BPKDialogButtonAction(title: "Skip", style: .secondary) {_ in
    // Handle tap
}

let optionalLink = BPKDialogButtonAction(title: "Optional link", style: .link) {_ in
    // Handle tap
}

dialogController.addButtonAction(confirmation)
dialogController.addButtonAction(skip)
dialogController.addButtonAction(optionalLink)

// Handling scrim tap
// If you don't set this, the dialog is not dismissed when tapping the scrim
let scrimAction = BPKDialogScrimAction(handler: { (didDismiss) in
    print("Scrim tap \(didDismiss ? "dimissing" : "")")
}, shouldDismiss: true)
dialogController.scrimAction = scrimAction

// Show the dialog
self.present(dialogController, animated: true)
```


Example of an image dialog

```swift
// Image view
let image = UIImage(named: "dialog_image")
let imageView = UIImageView.init(image: image)
imageView.contentMode = .scaleAspectFill
imageView.translatesAutoresizingMaskIntoConstraints = false

// Basic definition
let iconTemplate = BPKIcon.makeLargeTemplateIcon(name: .tick)
let icon = BPKDialogIconDefinition(icon: iconTemplate, iconBackgroundColor: BPKColor.coreAccentColor)

let dialogController = BPKDialogController(
    title: "Title in here",
    message: "Description",
    imageView: imageView,
    textAlignment: .left
)

// Dialog buttons
let confirmation = BPKDialogButtonAction(title: "Confirmation", style: .featured) {_ in
    // Handle tap
}

let skip = BPKDialogButtonAction(title: "Skip", style: .secondary) {_ in
    // Handle tap
}

let optionalLink = BPKDialogButtonAction(title: "Optional link", style: .link) {_ in
    // Handle tap
}

dialogController.addButtonAction(confirmation)
dialogController.addButtonAction(skip)
dialogController.addButtonAction(optionalLink)

// Handling scrim tap
// If you don't set this, the dialog is not dismissed when tapping the scrim
let scrimAction = BPKDialogScrimAction(handler: { (didDismiss) in
    print("Scrim tap \(didDismiss ? "dimissing" : "")")
}, shouldDismiss: true)
dialogController.scrimAction = scrimAction

// Show the dialog
self.present(dialogController, animated: true)
```