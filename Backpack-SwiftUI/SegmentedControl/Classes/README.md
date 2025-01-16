# Backpack-SwiftUI/SegmentedControl

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSegmentedControl.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/SegmentedControl)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_segmented-control___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_segmented-control___default_dm.png" alt="" width="375" /> |

## Usage

Use an array of strings to set the texts shown by the segmented control as a `BPKText` label

```swift
    import Backpack_SwiftUI
    @State var selectedIndex = 0
    private let accessibilityLabel = "bpk_segmented_control_example"
    private let items: [String] = ["1", "2", "3"]

            BPKSegmentedControl(
                items: items,
                selectedIndex: $selectedIndex,
                accessibilityLabel: accessibilityLabel)
```

