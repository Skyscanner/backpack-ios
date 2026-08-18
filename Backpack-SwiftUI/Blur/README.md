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

## Platform Parity & Gradient Notes

### Shader parity: iOS Metal vs Android AGSL

Both platforms apply progressive blur only to the bottom half of the view/composable, ramping intensity
from the vertical midpoint (no blur) to the bottom edge (maximum blur). However, the two implementations
scale intensity differently:

- **iOS (`bpkProgressiveBlur`)**: the mask alpha driving the Metal shader's blur radius only reaches `0.5`
  at the bottom edge (see gradient stops below), so the effective maximum blur is roughly half of the
  nominal `radius: 24` passed to the shader (~12pt).
- **Android AGSL**: `blurSigma` is interpolated linearly from `0` at the midpoint to the *full* `uMaxSigma`
  (4dp) at the bottom edge, with no equivalent 0.5 cap.

This is an accepted, documented difference rather than a defect: the two shaders use different units
(points vs dp) and different intensity curves by design, but both produce the same qualitative effect
(no blur at the midpoint, strongest blur at the bottom edge, confined to the bottom 50% of the view).
Visual comparison of the recorded snapshots (`screenshots/iPhone-swiftui_blur-progessive___default_lm.png`
on iOS vs `BpkBlurTest_progressiveBlur.png` on Android) confirms the falloff shape is perceptually similar,
though iOS's effective peak intensity is lower relative to its nominal radius.

### `bpkProgressiveBlurFallback` vs `bpkProgressiveBlur` gradient differences

The two iOS implementations use different gradient distributions and affect different regions of the view,
which can produce visibly different results depending on which one is selected for a given OS version:

| | `bpkProgressiveBlurFallback` (< iOS 17) | `bpkProgressiveBlur` (iOS 17+) |
| --- | --- | --- |
| Region affected | Full height (0%–100%) | Bottom half only (50%–100%) |
| Mechanism | Fixed 10pt blur, revealed via an alpha cross-fade mask | Continuously variable blur radius (0–24pt) driven directly by the shader mask |
| Gradient stops | `0.0` clear, `0.25` clear, `0.5` @ 50% opacity, `0.75` @ 100% opacity, `1.0` @ 100% opacity | `0.0` @ 50% opacity, `0.5` @ 30% opacity, `1.0` clear |
| Effective peak intensity | Full 10pt blur visible from 75% down to the bottom | ~12pt effective (24pt nominal × 0.5 mask cap), only right at the bottom edge |

Because the fallback blurs the entire view while the Metal version only blurs the bottom half, and the
fallback's blur becomes fully visible well before the bottom edge (at 75% down) while the Metal version's
effective intensity is lower and concentrated at the very edge, the same call to `bpkProgressiveBlur()`
can look meaningfully different depending on whether a device is running iOS 16 or iOS 17+. This is a
known, accepted platform limitation rather than a bug — callers should not assume identical visual output
across OS versions.

---

## Accessibility

These visual effects are non-interactive and should be combined with accessible labels or containers as appropriate.

---

