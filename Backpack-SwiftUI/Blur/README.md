# Blur Effects

[![License](https://img.shields.io/cocoapods/l/Backpack-SwiftUI.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0)
[![SwiftUI Compatibility](https://img.shields.io/badge/SwiftUI-Compatible-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BlurEffects.html)
[![View on GitHub](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Blur)

## Previews

| Uniform | Progressive Blur iOS 17 fallback | Progressive Blur iOS 17+ |
| ------------ | ---------------- | ---------- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_blur-uniform___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_blur-progessive-17-lower___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_blur-progessive___default_lm.png" alt="" width="375" /> |

## Usage

### Uniform Blur

Applies a fixed-radius blur to any SwiftUI view.

```swift
BPKUniformBlur(opaque: Bool)
```

**Example:**

```swift
Text("Blurred Content")
    .blur(BPKUniformBlur(opaque: false))

Image("example-image")
    .resizable()
    .blur(BPKUniformBlur(opaque: true))
```

---

### Progressive Blur - iOS 17 fallback

Applies a blur that increases gradually from the top of the view to the bottom.

```swift
.someView()
    .bpkProgressiveBlurFallback()
```

**Example:**

```swift
Image("example-image")
    .resizable()
    .bpkProgressiveBlurFallback()
```

---

### Metal Progressive Blur - iOS 17+

Applies a Metal-based GPU-accelerated variable blur using a vertical gradient mask.

```swift
.someView()
    .bpkProgressiveBlur()
```

**Example:**

```swift
Image("example-image")
    .resizable()
    .bpkProgressiveBlur()
```

---

## Blur Types

### `BPKUniformBlur`

- **Type**: Static blur
- **Radius**: 4pt (default)
- **Performance**: High
- **Use case**: Simple, consistent blur overlays, opaque bool depending on image background

### `BPKProgressiveBlur`

- **Type**: Vertical gradient blur
- **Radius**: 10pt (default)
- **Performance**: Medium
- **Use case**: iOS 17 fallback

### `bpkProgressiveMetalBlur`

- **Type**: Shader-based mask blur
- **Radius**: 24pt (default)
- **Performance**: GPU-accelerated
- **Use case**: iOS 17+

---

## Accessibility

These visual effects are non-interactive and should be combined with accessible labels or containers as appropriate.

---

