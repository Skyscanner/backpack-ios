# Backpack-SwiftUI/Radio

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKRadio.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Radio)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_radio___default_lm.png" alt="Radio in light mode" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_radio___default_dm.png" alt="Radio in dark mode" width="375" /> |

## Usage

`BPKRadio` renders the radio control without a visible label. The caller owns the selected value and decides how tapping an already selected option should be handled.

```swift
import Backpack_SwiftUI
import SwiftUI

struct RadioGroupExample: View {
    @State private var selectedOption = 0

    var body: some View {
        VStack(alignment: .leading) {
            option(label: "Direct flights", value: 0)
            option(label: "Any number of stops", value: 1)
        }
    }

    private func option(label: String, value: Int) -> some View {
        HStack {
            BPKRadio(
                isSelected: selectedOption == value,
                accessibilityLabel: label,
                action: { selectedOption = value }
            )
            BPKText(label)
        }
    }
}
```

### Styles

Use `.onContrast` when the control appears on a contrast background.

```swift
BPKRadio(
    isSelected: true,
    accessibilityLabel: "Direct flights",
    style: .onContrast,
    action: {}
)
.background(Color(.surfaceContrastColor))
```

### Status

`BPKRadioStatus` supports regular, error and disabled states. Only `.disabled` prevents interaction.

```swift
BPKRadio(
    isSelected: false,
    accessibilityLabel: "Direct flights",
    status: .error,
    action: {}
)
```

SwiftUI's `.disabled()` modifier remains supported when a parent needs to disable a larger section of the interface.

### Accessibility

Always provide a localized `accessibilityLabel` that identifies the option. `BPKRadio` exposes its selected state to assistive technologies.
