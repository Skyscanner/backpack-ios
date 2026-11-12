# Backpack/NavigationBarAppearance

## Overview

`BPKNavigationBarAppearance` styles UIKit's own navigation bar with Backpack colours and type, and `UIBarButtonItem.bpkIconButton(_:accessibilityLabel:action:)` makes a bar button from a Backpack icon.

Prefer the system bar to a custom header view. It respects every safe area, keeps its buttons at a 44 pt touch target, and adapts to the device by itself: on iPhone Duo its buttons move into the side rail with the status bar, which a custom header cannot do. It also works with the iOS 27 bar APIs, such as `UIBarButtonItem.visibilityPriority` and `UINavigationItem.verticalBarCompressionBehavior`.

## Styles

The same styles as the SwiftUI `BPKNavigationView`: `.default`, `.transparent`, `.surfaceContrast` and `.canvasContrast`.

## Usage

```swift
import Backpack

let navigationController = UINavigationController(rootViewController: settings)
BPKNavigationBarAppearance.apply(to: navigationController.navigationBar, style: .default)

settings.title = "Settings"
settings.navigationItem.rightBarButtonItems = [
    .bpkIconButton(.heart, accessibilityLabel: "Save", action: UIAction { _ in save() }),
    .bpkIconButton(.share, accessibilityLabel: "Share", action: UIAction { _ in share() })
]
```

To style a single screen differently, set its navigation item's appearances with `BPKNavigationBarAppearance.makeAppearance(style:)`.
