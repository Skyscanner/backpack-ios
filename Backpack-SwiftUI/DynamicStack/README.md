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
            BPKText("First text")
            BPKText("Middle text")
            BPKText("Last text")
        }
        .environment(\.horizontalSizeClass, horizontalSizeClass)
    }
}
```

---

## BPKDynamicTypeStack

---

## Horizontal BPKDynamicTypeStack

| Day | Night |
| --- | --- |
| <img src="https://github.com/user-attachments/assets/05b0a2fb-eaaf-4add-a7f9-08f61385a7a9" alt="" width="375" /> | <img src="https://github.com/user-attachments/assets/8cfa9336-fcd4-4412-a6de-79f37b453043" alt="" width="375" /> |

## Vertical BPKDynamicTypeStack

| Day | Night |
| --- | --- |
| <img src="https://github.com/user-attachments/assets/b9efd415-5739-433d-8f09-b51396cf87ef" alt="" width="375" /> | <img src="https://github.com/user-attachments/assets/77201543-2883-49be-8a58-1ad69ab447ff" alt="" width="375" /> |

---

`BPKDynamicTypeStack` automatically observes the user’s Dynamic Type size and switches between horizontal and vertical layouts when the size crosses a specified threshold (default is `.accessibility1`).

### Default usage

```swift
BPKDynamicTypeStack {
    BPKText("First text")
    BPKText("Middle text")
    BPKText("Last text")
}
```

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
