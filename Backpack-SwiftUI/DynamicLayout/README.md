# Backpack-SwiftUI/DynamicLayout

## Overview

Backpack provides layout wrapper components that adapt their structure based on various conditions:

- **`BPKDynamicLayout`** – A conditional, generic layout that switches between inner layouts, either following the window's horizontal size class or a condition you control.
- **`BPKDynamicTypeLayout`** – A Dynamic Type-aware layout that automatically switches between inner layouts based on the user's preferred text size.
- **`bpkReadableContentWidth()`** – Caps content at a readable width on wide windows.

## BPKDynamicLayout

`BPKDynamicLayout` is a conditional layout container that switches between a **primary** and **secondary** layout.

### Follow the window's width

Prefer this over checking the device type or the screen size. The window's horizontal size class changes with Split View, Slide Over, rotation, and folding or unfolding an iPhone Duo, and the layout follows it.

```swift
BPKDynamicLayout(
    primaryLayout: AnyLayout(HStackLayout(spacing: BPKSpacing.base.value)),
    secondaryLayout: AnyLayout(VStackLayout(spacing: BPKSpacing.base.value)),
    secondaryLayoutForHorizontalSizeClass: .compact
) {
    BPKText("This is the first text")
    BPKText("This is the second text")
}
```

### Switch on a condition you control

Pass a Boolean binding to decide yourself, for example from the user's settings.

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

---

## Readable content width

`bpkReadableContentWidth()` caps content at a readable width, 672 pt by default, and centres it. On a phone-sized window it changes nothing; on an iPad or an unfolded iPhone Duo it stops text and controls from stretching across the whole window.

```swift
VStack(alignment: .leading, spacing: BPKSpacing.base.value) {
    BPKText("Read before booking", style: .heading3)
    BPKText(details)
}
.bpkReadableContentWidth()
```
