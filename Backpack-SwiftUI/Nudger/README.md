# Backpack-SwiftUI/Nudger

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKNudger.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Nudger)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_nudger___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_nudger___default_dm.png" alt="" width="375" /> |

## Labelled

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_nudger___labelled_lm.png" alt="Labelled Nudger" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_nudger___labelled_dm.png" alt="Labelled Nudger in dark mode" width="375" /> |

## Usage

An adjustable control that allows a user to select a numerical value within a range determined by the consumer.

```swift
import SwiftUI
import Backpack_SwiftUI

struct NudgerExampleView: View {
    @State private var value = 1
    @State private var enabled = true
    
    var body: some View {
        VStack {
            BPKNudger(value: $value, min: 1, max: 10, step: 1, enabled: enabled)
            BPKNudger(title: "Adults", subtitle: "Aged 16+", value: $value, min: 1, max: 10)
            BPKNudger(title: "Rooms", value: $value, min: 1, max: 10)
            BPKNudger(title: "Rooms", icon: .room, value: $value, min: 1, max: 10)
            BPKNudger(
                title: "Travellers",
                subtitle: "Aged 16 and older",
                icon: .adult,
                value: $value,
                min: 1,
                max: 10
            )
            .accessibilityPrefix("passengers")
        }
        .padding()
    }
}
```

### Disabled

Set `enabled` to `false` to prevent button and accessibility-adjustable interactions for the entire Nudger.
The parameter defaults to `true`, so existing Nudgers remain enabled when it is omitted.

```swift
BPKNudger(value: $value, min: 1, max: 10, enabled: false)
```

### Accessibility identifiers

Use `accessibilityPrefix(_:)` to identify the Nudger's decrement button, value label, and increment button.
Apply a unique prefix to each Nudger whose child identifiers are used by UI tests.

```swift
BPKNudger(value: $value, min: 1, max: 10)
    .accessibilityPrefix("passengers")
```

This produces the following accessibility identifiers:

- `passengers_minus`
- `passengers_value_label`
- `passengers_plus`

SwiftUI's standard `.accessibilityLabel(_:)` modifier can still be used when a custom spoken label is required;
it is not a Backpack-specific Nudger modifier.
