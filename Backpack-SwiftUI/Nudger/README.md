# Backpack-SwiftUI/Nudger

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKNudger.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Nudger)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_nudger___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_nudger___default_dm.png" alt="" width="375" /> |

# Usage

an adjustable control that allows a user to select a numerical value between a min/max determined by the consumer.

```swift
struct NudgerExampleView: View {
    @State private var value = 0
    
    var body: some View {
        VStack {
            BPKNudger(value: $value, min: 1, max: 10, step: 1)
                .accessibilityLabel("Passengers")
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
        }
        .padding()
    }
}
```
