# Backpack-SwiftUI/Switch

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSwitch.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Switch)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_switch___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_switch___default_dm.png" alt="" width="375" /> |

## Usage

### Text label

```swift
@State private var isOn = true

BPKSwitch(
    isOn: $isOn,
    text: "Enable notifications"
)
```

### Enabled state

`enabled` controls whether the switch accepts interaction and defaults to `true`.

```swift
BPKSwitch(
    isOn: $isOn,
    text: "Enable notifications",
    enabled: false
)
```

SwiftUI’s `.disabled()` modifier remains supported when a parent needs to disable a larger section of the interface.

### Truncation

`truncate` defaults to `true`. Set it to `false` to allow the label to wrap.

```swift
BPKSwitch(
    isOn: $isOn,
    text: "A longer label that can wrap over multiple lines",
    truncate: false
)
```

### Attributed text

```swift
private var attributedLabel: AttributedString {
    var label = AttributedString("Enable notifications")
    label.foregroundColor = Color(.coreAccentColor)
    return label
}

BPKSwitch(
    isOn: $isOn,
    text: attributedLabel
)
```

### Custom content

Custom content can capture the current binding value directly.

```swift
BPKSwitch(isOn: $isOn) {
    BPKText(isOn ? "Notifications enabled" : "Notifications disabled")
        .padding()
}
```

### Styles

```swift
BPKSwitch(
    isOn: $isOn,
    text: "Enable notifications",
    style: .default
)
```

The On Contrast style visually hides its internal Toggle label so that the custom off-track colour can be applied. Render a visible label alongside the switch when required.

```swift
HStack {
    BPKText("Enable notifications")
        .foregroundColor(.textOnDarkColor)
        .accessibilityHidden(true)

    Spacer()

    BPKSwitch(
        isOn: $isOn,
        text: "Enable notifications",
        style: .onContrast
    )
}
.background(Color(.surfaceContrastColor))
```

Always verify separately composed labels with VoiceOver.

## Alignment

`BPKSwitch` follows the native SwiftUI `Toggle` layout and does not expose a separate vertical-alignment parameter.
