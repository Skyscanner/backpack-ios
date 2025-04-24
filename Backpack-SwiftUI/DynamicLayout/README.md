# Backpack-SwiftUI/DynamicLayout

## Overview

Backpack provides layout wrapper components that adapt their structure based on various conditions:

- **`BPKDynamicLayout`** – A conditional, generic layout that switches between inner layouts manually (e.g., based on device orientation or other runtime states).
- **`BPKDynamicTypeLayout`** – A Dynamic Type-aware layout that automatically switches between inner layouts based on the user's preferred text size.

## BPKDynamicLayout

`BPKDynamicLayout` is a conditional layout container that switches between a **primary** and **secondary** layout based on a Boolean binding you control (e.g., device orientation, screen size, etc.).

### Example (switch layouts based on landscape mode)

```swift
struct DynamicLayoutExampleView: View {
    let horizontalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        let isLandscape = horizontalSizeClass == .regular
        return BPKDynamicLayout(
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

## BPKDynamicTypeLayout

`BPKDynamicTypeLayout` automatically observes the user’s Dynamic Type size and switches between horizontal and vertical layouts when the size crosses a specified threshold (default is `.accessibility1`).

### Default usage

```swift
BPKDynamicTypeLayout {
    BPKText("This is the first text")
    BPKText("This is the second text")
    BPKText("This is the third text")
}
```

### Demo

<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/f1840efd1bf0e12db17ba941a5c56d8337476f95/Backpack-SwiftUI/Tests/DynamicStack/__Snapshots__/BPKDynamicStackTests/test_dynamicTypeStack_accessibility.a11y.png" alt="" width="375" />


### With layout parameters

```swift
BPKDynamicTypeLayout(
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
BPKDynamicTypeLayout(
    threshold: .accessibility3,
    primaryLayout: AnyLayout(HStackLayout(alignment: .top, spacing: .md)),
    secondaryLayout: AnyLayout(VStackLayout(alignment: .leading, spacing: .lg))
) {
    BPKText("First text", style: .heading1)
    BPKText("Middle text", style: .heading4)
    BPKText("Last text", style: .heading5)
}
```
