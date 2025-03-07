# Backpack-SwiftUI/DynamicStack

## Horizonal DynamicStack

| Day | Night |
| --- | --- |
| <img src="https://github.com/user-attachments/assets/05b0a2fb-eaaf-4add-a7f9-08f61385a7a9" alt="" width="375" /> | <img src="https://github.com/user-attachments/assets/8cfa9336-fcd4-4412-a6de-79f37b453043" alt="" width="375" /> |

## Vertical DynamicStack

| Day | Night |
| --- | --- |
| <img src="https://github.com/user-attachments/assets/b9efd415-5739-433d-8f09-b51396cf87ef" alt="" width="375" /> | <img src="https://github.com/user-attachments/assets/77201543-2883-49be-8a58-1ad69ab447ff" alt="" width="375" /> |

## Usage

`BPKDynamicStack` works as a dynamic view manager, which determines the layout depending on the threshold.
It renders the contents of the view based on the magnification in the settings.

Using it doesn't require implementing any conditional rendering.

### Default usage

```swift
BPKDynamicStack {
    BPKText("First text")
    BPKText("Middle text")
    BPKText("Last text")
}
```

### Custom arguments

```swift
BPKDynamicStack(
    horizontalAlignment: .leading,
    verticalAlignment: .center,
    spacing: .md,
    threshold: .accessibility1
) {
    BPKText("First text", style: .heading1)
    BPKText("Middle text", style: .heading4)
    BPKText("Last text", style: .heading5)
}
```

### Custom arguments for any layout

```swift
BPKDynamicStack(
    threshold: .accessibility3,
    primaryLayout: AnyLayout(HStackLayout(alignment: .center, spacing: .md)),
    secondaryLayout: AnyLayout(VStackLayout(alignment: .leading, spacing: .md))
) {
    BPKText("First text", style: .heading1)
    BPKText("Middle text", style: .heading4)
    BPKText("Last text", style: .heading5)
}
```
