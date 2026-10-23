# Backpack/Fold

## Overview

`UIView.bpkActiveFoldFrame` returns the fold of a partially folded foldable, such as an iPhone Duo in book or laptop pose, in the view's coordinate space. It is `nil` when the device is closed, fully open, or not a foldable.

Use it to keep controls, sheets and dialogs from straddling the fold. It reads the reserved regions that iOS 27.1 reports, so it needs the iOS 27.1 SDK; with older toolchains the extension is not compiled.

## Usage

```swift
if #available(iOS 27.1, *), let fold = view.bpkActiveFoldFrame {
    // Lay the content out in one half, for example the half before the fold.
    contentWidthConstraint.constant = fold.minX
}
```

For SwiftUI, see `bpkKeepClearOfFold(on:)` and `GeometryProxy.bpkActiveFoldFrame` in [DynamicLayout](../../Backpack-SwiftUI/DynamicLayout/README.md).
