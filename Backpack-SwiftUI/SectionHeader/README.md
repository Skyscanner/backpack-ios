# Section Header

[![CocoaPods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSectionHeader.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/SectionHeader)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_section-header___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_section-header___default_dm.png" alt="" width="375" /> |

## On Dark

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_section-header___on-dark_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_section-header___on-dark_dm.png" alt="" width="375" /> |

## Usage

### Basic Section Header

When `style` is omitted, the Default style is used.

```swift
import SwiftUI
import Backpack_SwiftUI

struct SectionHeaderExampleView: View {
    var body: some View {
        BPKSectionHeader(
            title: "Section title"
        )
    }
}
```

### Section header with a title and description.

```swift
BPKSectionHeader(
    title: "Section title",
    description: "Description about this section"
)
```

### Accessibility header trait

The title has the accessibility header trait by default. Set `accessibilityHeaderEnabled` to `false` when another view already provides the appropriate heading semantics.

```swift
BPKSectionHeader(
    title: "Section title",
    accessibilityHeaderEnabled: false
)
```

### Trailing button

```swift
BPKSectionHeader(
    title: "Section title",
    description: "Description about this section"
) {
    BPKButton(
        icon: .addCircle,
        accessibilityLabel: "Add item"
    ) {
        print("Tap add button")
    }
}
```

SectionHeader automatically overrides the supplied button style:

- Default SectionHeader uses `.primary`.
- On Dark SectionHeader uses `.primaryOnDark`.

Callers do not need to set the button style themselves.

### On Dark

```swift
BPKSectionHeader(
    title: "Section title",
    description: "Description about this section",
    style: .onDark
) {
    BPKButton(
        icon: .addCircle,
        accessibilityLabel: "Add item"
    ) {
        print("Tap add button")
    }
}
```

## Cross-platform naming

The appearance parameter is named `style` on iOS and `type` on Android. iOS retains `style` to follow SwiftUI naming conventions and to avoid a breaking change to the existing public API.

Android exposes the equivalent accessibility control as
`accessibilityHeaderTagEnabled: Boolean?`. iOS uses the shorter
`accessibilityHeaderEnabled: Bool` name with a default value of `true`. The iOS
API does not need a nullable state because Backpack always supplies a concrete
enabled or disabled default. A non-optional Boolean follows Swift API
conventions for simple binary configuration while preserving equivalent
cross-platform behaviour.
