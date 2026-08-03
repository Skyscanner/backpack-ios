# BPKVideoPlayer default-controls accessibility API

## Context

`BPKVideoPlayer` exposes built-in play/pause controls when constructed without a custom overlay. Those controls need caller-supplied accessibility text so Backpack does not hard-code English strings.

Android is the reference implementation:

```kotlin
BpkVideoPlayerDefaultControls(
    controller = controller,
    playContentDescription = "Play video",
    pauseContentDescription = "Pause video",
)
```

The current iOS API instead puts `playAccessibilityLabel` and `pauseAccessibilityLabel` on the `BPKVideoPlayer(url:)` initializer. Although it avoids hard-coded text, it makes default-control configuration part of the player construction API and is not a natural fit for a caller that switches between default and custom overlays.

This document covers accessibility text for the **built-in controls only**. A custom overlay owns its own accessibility semantics. A separate player/surface description, if needed later, should not be coupled to these control labels.

## Goals

- No English accessibility strings in Backpack's video-player implementation.
- Make it explicit that configuration applies only to built-in controls.
- Keep custom overlays fully responsible for their own accessibility.
- Make the iOS behaviour conceptually consistent with Android: callers provide play and pause descriptions.
- Avoid expanding the API to state/value/hint strings that Android does not expose for this component.

## Non-goals

- Defining accessibility text for consumer-provided overlays.
- Adding player playback state, hints, or a surface-level label as part of this API.
- Making control text configurable after the view has been created outside SwiftUI's normal state updates.

## Options

### Option A — Keep labels on `BPKVideoPlayer`'s default initializer

```swift
BPKVideoPlayer(
    url: videoURL,
    playAccessibilityLabel: "Play video",
    pauseAccessibilityLabel: "Pause video"
)
```

**Pros**

- Simple implementation with compile-time-required strings.
- The labels are close to the built-in-controls construction path.

**Cons**

- The player initializer carries concerns owned by one optional overlay implementation.
- It does not compose well: changing to a custom overlay means those parameters disappear.
- It differs structurally from Android, where labels belong to `BpkVideoPlayerDefaultControls`.

**Verdict:** Not recommended.

### Option B — Expose only `BPKVideoPlayerDefaultControls` configuration

```swift
BPKVideoPlayer(controller: controller) { controller in
    BPKVideoPlayerDefaultControls(
        controller: controller,
        playAccessibilityLabel: "Play video",
        pauseAccessibilityLabel: "Pause video"
    )
}
```

**Pros**

- Closest direct mapping to Android.
- Strong ownership: the default-controls view receives the text it uses.
- Compile-time-required strings.

**Cons**

- Removes the convenient no-overlay/default-controls `BPKVideoPlayer(url:)` path, or leaves two different ways to get default controls.
- Callers must create an overlay closure purely to supply accessibility text.

**Verdict:** Sound but less ergonomic for the simple/default use case.

### Option C — Environment-backed custom modifier for default controls

```swift
BPKVideoPlayer(url: videoURL)
    .bpkVideoPlayerDefaultControlsAccessibility(
        play: "Play video",
        pause: "Pause video"
    )
```

The modifier writes an optional configuration value to a private `EnvironmentKey`. `BPKVideoPlayerDefaultControls` reads it from the environment and applies the appropriate label for the current playback state.

```swift
private struct BPKVideoPlayerDefaultControlsAccessibilityKey: EnvironmentKey {
    static let defaultValue: BPKVideoPlayerDefaultControlsAccessibility? = nil
}

public extension View {
    /// Applies only to BPKVideoPlayer's built-in controls. Custom overlays
    /// must provide their own accessibility labels.
    func bpkVideoPlayerDefaultControlsAccessibility(
        play: String,
        pause: String
    ) -> some View
}
```

`BPKVideoPlayerDefaultControls` stores the environment value as optional. When present, it applies `play` or `pause`; when absent, it does not add a Backpack-provided label. This deliberately avoids a hidden English fallback and allows the modifier to update normally when its input changes.

**Pros**

- Matches the requested modifier-based call site.
- Keeps the simple `BPKVideoPlayer(url:)` initializer focused on playback configuration.
- Applies only when the built-in controls are in the view hierarchy; custom overlays are unaffected.
- Supports ordinary SwiftUI updates: changing the modifier inputs recomputes the environment and the visible controls update automatically.
- A concise doc comment can clearly state the scope and responsibility boundary.

**Cons**

- Missing configuration is detected at runtime rather than compile time.
- A caller who omits the modifier gets no explicit label from Backpack, so documentation and tests must make the requirement prominent.
- It is an iOS-specific shape rather than Android's direct composable parameter list.

**Verdict:** Recommended, provided the API documentation explicitly states that it applies only to default controls and consumers must supply equivalent accessibility semantics for custom overlays.

### Option D — A modifier carrying a public configuration value

```swift
BPKVideoPlayer(url: videoURL)
    .bpkVideoPlayerDefaultControlsAccessibility(
        .init(play: "Play video", pause: "Pause video")
    )
```

This is Option C with a public `BPKVideoPlayerDefaultControlsAccessibility` value type.

**Pros**

- Easier to reuse a localized configuration across several video players.
- Extensible if a future platform-agreed control property is added.

**Cons**

- More public API for only two strings.
- Premature extension surface; a public type should not exist solely to support an implementation detail.

**Verdict:** Defer. Start with Option C's two-argument modifier. Introduce a value type only if real consumers need reuse or a future shared Android/iOS model demands it.

## Recommendation

Implement **Option C**.

1. Remove `playAccessibilityLabel` and `pauseAccessibilityLabel` from `BPKVideoPlayer` initializers.
2. Add `View.bpkVideoPlayerDefaultControlsAccessibility(play:pause:)`.
3. Store its values in an optional environment configuration read by `BPKVideoPlayerDefaultControls`.
4. Add inline documentation: “Applies only to BPKVideoPlayer's built-in controls. Custom overlays must provide their own accessibility labels.”
5. When no modifier is supplied, do not hard-code or synthesize English text.
6. Keep `BPKVideoPlayerDefaultControls` public for consumers who choose a custom overlay; its explicit constructor remains the direct analogue of Android's API.

This yields an ergonomic iOS default path while preserving Android's ownership principle: accessibility text is consumed by, and only affects, default controls.

## Implementation plan

1. Define a private environment key and small internal configuration type in the VideoPlayer module.
2. Add the public modifier with the scoped doc comment above.
3. Change default controls to read the optional environment value and conditionally apply the current state's label.
4. Restore the no-label `BPKVideoPlayer(url:autoPlay:loop:)` initializer.
5. Keep the explicit labels on `BPKVideoPlayerDefaultControls` for custom-overlay callers, matching Android's direct controls API.
6. Update the README to show the modifier directly below the basic default-controls example and state that custom overlays own their labels.
7. Update the example app to use the modifier.
8. Add tests for:
   - play label applied in a ready/paused state;
   - pause label applied while playing;
   - labels update when modifier input changes;
   - a custom overlay does not inherit or depend on the default-controls modifier.
9. Run the VideoPlayer test target and update snapshots only if the rendered view changes (it should not).

## Decision needed before implementation

Confirm Option C. The remaining intentional trade-off is compile-time enforcement versus modifier ergonomics: an omitted modifier has no Backpack-supplied label. If that is unacceptable, choose Option B instead.
