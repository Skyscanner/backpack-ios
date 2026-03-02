# Backpack-SwiftUI/CellItem

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKCellItem.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/CellItem)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_cell-item___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_cell-item___default_dm.png" alt="" width="375" /> |

## Usage

### Basic Cell

```swift
import Backpack_SwiftUI

BPKCellItem(title: "Settings")
```

### Cell with Body Text

```swift
BPKCellItem(
    title: "Notifications",
    body: "Manage your notification preferences"
)
```

### Cell with Icon

```swift
BPKCellItem(
    title: "Account",
    body: "View and edit your profile",
    icon: .accountCircle
)
```

### Interactive Cell

```swift
BPKCellItem(
    title: "Privacy Settings",
    icon: .lock,
    slot: .chevron,
    onClick: {
        // Navigate to privacy settings
    }
)
```

## Slot Types

### Chevron

Display a navigation indicator.

```swift
BPKCellItem(
    title: "Account Settings",
    slot: .chevron
)
```

### Switch

Embed a toggle control.

```swift
@State var isEnabled = true

BPKCellItem(
    title: "Push Notifications",
    slot: .switch(isOn: $isEnabled)
)
```

### Text

Display a secondary value.

```swift
BPKCellItem(
    title: "Language",
    slot: .text("English")
)
```

### Link

Display a tappable link.

```swift
BPKCellItem(
    title: "Privacy Policy",
    slot: .link(
        text: "View",
        url: "https://skyscanner.net/privacy",
        onCustomLink: { url in
            // Open URL
        }
    )
)
```

### Image

Display a trailing image.

```swift
BPKCellItem(
    title: "Partner Airlines",
    slot: .image(Image("partner-logo"))
)
```

## Styling

### Background Style

Set the background style to:
* `.surfaceDefault` - Standard background
* `.surfaceLowContrast` - Subtle background for grouped appearance

```swift
BPKCellItem(
    title: "Settings",
    style: .surfaceLowContrast
)
```

### Corner Radius

Set the corner treatment to:
* `.default` - Square corners (0 radius)
* `.rounded` - Rounded corners (8pt radius)

```swift
BPKCellItem(
    title: "Grouped Item",
    corner: .rounded
)
```

### Combined Styling

```swift
BPKCellItem(
    title: "Premium Feature",
    body: "Unlock exclusive benefits",
    icon: .star,
    style: .surfaceLowContrast,
    corner: .rounded,
    slot: .chevron,
    onClick: { /* upgrade */ }
)
```
