# Backpack/Swap

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Swap)

## Overview

`BPKSwap` is a circular button with a swap icon that rotates 180 degrees when tapped. It's typically used to swap values, such as origin and destination in search controls.

## Styles

| Style | Background | Border | Use Case |
| --- | --- | --- | --- |
| `canvasDefault` | Canvas Contrast | Canvas | On canvas default backgrounds |
| `canvasContrast` | Surface Default | Canvas Contrast | On canvas contrast backgrounds |
| `surfaceContrast` | Surface Default | Core Primary | On surface contrast (dark) backgrounds |

## Usage

Make sure you provide a localized accessibility label that matches the function of the button.

### Basic Usage

```swift
import Backpack_SwiftUI

BPKSwap(accessibilityLabel: "Swap origin and destination") {
    print("Swap tapped")
}
```

### With Style

```swift
// On dark backgrounds
BPKSwap(
    style: .surfaceContrast,
    accessibilityLabel: "Swap origin and destination"
) {
    swapOriginAndDestination()
}
```

### In Search Controls

```swift
VStack(spacing: 0) {
    // Origin input
    BPKSearchInputSummary(...)
        .docking(.top)

    // Destination input with swap button overlay
    ZStack(alignment: .trailing) {
        BPKSearchInputSummary(...)
            .docking(.bottom)

        BPKSwap(
            style: .surfaceContrast,
            accessibilityLabel: "Swap"
        ) {
            // Swap logic
        }
        .offset(y: -24)
    }
}
```

## Animation

The swap icon automatically rotates 180 degrees with each tap to provide visual feedback to the user. The animation uses an ease-in-out timing curve with a duration of 0.3 seconds.

## Accessibility

- Always provide a meaningful `accessibilityLabel` that describes the action
- The button is automatically exposed as a button to assistive technologies
- Example labels: "Swap origin and destination", "Swap locations"
