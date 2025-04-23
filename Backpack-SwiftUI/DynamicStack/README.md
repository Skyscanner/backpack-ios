# Backpack-SwiftUI/DynamicStack

## Overview

Backpack provides two stack components that adapt layout based on different conditions:

- **`BPKDynamicStack`** – A conditional generic stack that switches layout manually (e.g., based on device orientation or other runtime state).
- **`BPKDynamicTypeStack`** – A Dynamic Type-aware stack that automatically switches layout based on the user's preferred text size.


## BPKDynamicStack

`BPKDynamicStack` is a conditional layout container that switches between a **primary** and **secondary** layout based on a Boolean binding you control (e.g., device orientation, screen size, etc).

### Example (based on landscape mode)

```swift
struct DynamicStackExampleView: View {
    let horizontalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        let isLandscape = horizontalSizeClass == .regular
        return BPKDynamicStack(
            primaryLayout: AnyLayout(HStackLayout(alignment: .center)),
            secondaryLayout: AnyLayout(VStackLayout(alignment: .leading)),
            activateSecondaryLayout: .constant(!isLandscape)
        ) {
    		BPKText("This is the first text")
    		BPKText("This is the second text")
    		BPKText("This is the third text")
        }
        .environment(\.horizontalSizeClass, horizontalSizeClass)
    }
}
```

---

## BPKDynamicTypeStack

`BPKDynamicTypeStack` automatically observes the user’s Dynamic Type size and switches between horizontal and vertical layouts when the size crosses a specified threshold (default is `.accessibility1`).

### Default usage

```swift
BPKDynamicTypeStack {
    BPKText("This is the first text")
    BPKText("This is the second text")
    BPKText("This is the third text")
}
```

### Demo

<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/f1840efd1bf0e12db17ba941a5c56d8337476f95/Backpack-SwiftUI/Tests/DynamicStack/__Snapshots__/BPKDynamicStackTests/test_dynamicTypeStack_accessibility.a11y.png" alt="" width="375" />


### With layout parameters

```swift
BPKDynamicTypeStack(
    primaryHStackAlignment: .center,
    primaryHStackSpacing: .md,
    secondaryVStackAlignment: .leading,
    secondaryVStackSpacing: .lg,
    threshold: .accessibility2
) {
    BPKText("First text", style: .heading1)
    BPKText("Middle text", style: .heading4)
    BPKText("Last text", style: .heading5)
}
```

### With custom layouts

```swift
BPKDynamicTypeStack(
    threshold: .accessibility3,
    primaryLayout: AnyLayout(HStackLayout(alignment: .top, spacing: .md)),
    secondaryLayout: AnyLayout(VStackLayout(alignment: .leading, spacing: .lg))
) {
    BPKText("First text", style: .heading1)
    BPKText("Middle text", style: .heading4)
    BPKText("Last text", style: .heading5)
}
```

---
