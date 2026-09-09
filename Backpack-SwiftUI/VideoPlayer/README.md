# Backpack-SwiftUI/VideoPlayer

[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/VideoPlayer)

## Default controls

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/Backpack-SwiftUI/Tests/VideoPlayer/__Snapshots__/BPKVideoPlayerTests/test_defaultControls_paused.light-mode.png" alt="Video player default controls in light mode" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/Backpack-SwiftUI/Tests/VideoPlayer/__Snapshots__/BPKVideoPlayerTests/test_defaultControls_paused.dark-mode.png" alt="Video player default controls in dark mode" width="375" /> |

## GraphicPromo with video

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/Backpack-SwiftUI/Tests/VideoPlayer/__Snapshots__/BPKVideoPlayerTests/test_customOverlay_cornerControl.light-mode.png" alt="Video player custom overlay in light mode" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/Backpack-SwiftUI/Tests/VideoPlayer/__Snapshots__/BPKVideoPlayerTests/test_customOverlay_cornerControl.dark-mode.png" alt="Video player custom overlay in dark mode" width="375" /> |

# Usage

A scale-to-fill video player with no enforced aspect ratio. By default it shows a built-in play/pause button. Pass a custom `overlay` closure to replace it with your own UI — the live `BPKVideoPlayerController` is passed in so you can wire controls directly.

## Simple — built-in controls

```swift
BPKVideoPlayer(
    url: videoURL
)
.controlsAccessibilityLabels(
    play: "Play video",
    pause: "Pause video"
)

// With autoplay and looping
BPKVideoPlayer(
    url: videoURL,
    autoPlay: true,
    loop: true
)
.controlsAccessibilityLabels(
    play: "Play video",
    pause: "Pause video"
)
```

## Shared controller — continuous playback across transitions

Create a `BPKVideoPlayerController` and inject it into multiple views. Playback continues uninterrupted when the view changes (e.g. card → fullscreen sheet).

```swift
@StateObject private var controller = BPKVideoPlayerController(
    url: videoURL,
    autoPlay: true,
    loop: true
)

// Card view
BPKVideoPlayer(controller: controller) { _ in EmptyView() }

// Fullscreen sheet — same controller, playback never resets
BPKVideoPlayer(controller: controller) { _ in EmptyView() }
```

## Custom overlay

Pass a `@ViewBuilder` closure to replace the default controls. The controller is provided so you can bind your own UI:

Custom overlays must provide their own accessibility labels; `controlsAccessibilityLabels` applies only to the built-in controls.

```swift
BPKVideoPlayer(url: videoURL, autoPlay: true) { controller in
    VStack {
        Spacer()
        HStack {
            Spacer()
            Button(action: controller.toggle) {
                Image(systemName: controller.state.isPlaying ? "pause.fill" : "play.fill")
                    .foregroundColor(.textOnDarkColor)
            }
            .padding()
        }
    }
}
```

## Mute control

`BPKVideoPlayerController` exposes the observable `isMuted` state and `mute()`, `unmute()`, and `toggleMute()` actions for custom controls:

```swift
BPKVideoPlayer(url: videoURL, autoPlay: true) { controller in
    Button(action: controller.toggleMute) {
        Image(systemName: controller.isMuted ? "speaker.slash.fill" : "speaker.fill")
    }
    .accessibilityLabel(controller.isMuted ? "Unmute video" : "Mute video")
    .accessibilityValue(controller.isMuted ? "Muted" : "Unmuted")
}
```

The existing `player` property remains available for source compatibility, and direct `player.isMuted` changes are reflected in `controller.isMuted`.

## No controls — as a video background

Return `EmptyView()` from the overlay closure to get a pure video surface, e.g. as the background of a `BPKGraphicPromo`:

```swift
BPKGraphicPromo(
    headline: "Three peaks challenge",
    background: {
        BPKVideoPlayer(controller: controller) { _ in EmptyView() }
    },
    overlay: .linear(.high, .bottom),
    sponsorTitle: "Sponsored",
    partnerLogo: Image(decorative: "skyland"),
    sponsoredAccessibilityLabel: "Sponsored by Skyland",
    callToAction: .init(
        accessibilityLabel: "Learn more about our sponsor",
        onClick: { }
    )
)
```

## Playback state

`BPKVideoPlayerController` exposes a single `@Published state: BPKVideoPlayerState` that drives all UI. No separate flags needed.

```swift
switch controller.state {
case .loading:
    ProgressView()
case .readyToPlay, .paused:
    playButton
case .playing:
    pauseButton
case .buffering:
    ProgressView()
case .failed(let error):
    ErrorView(error: error)
}
```

### State reference

| State | Meaning |
| --- | --- |
| `.loading` | Asset is being fetched or decoded |
| `.readyToPlay` | The initial asset is ready; `autoPlay` starts it only when enabled and not explicitly paused |
| `.playing` | Playback active |
| `.paused` | Playback paused |
| `.buffering` | Rebuffering mid-playback or loading a replacement item during a loop handoff |
| `.failed(Error)` | Load failed or timed out |

Convenience helpers on `BPKVideoPlayerState`:

```swift
controller.state.isPlaying  // true only when .playing
controller.state.isLoading  // true for .loading and .buffering
controller.state.isActive   // true for .playing and .buffering
```

## Playback metrics

`BPKVideoPlayerController` exposes normalized playback metrics without requiring consumers to depend on AVFoundation:

```swift
@StateObject private var controller = BPKVideoPlayerController(
    url: videoURL,
    autoPlay: true,
    loop: true
)

BPKVideoPlayer(controller: controller) { _ in EmptyView() }
    .onReceive(controller.progressPublisher) { progress in
        print(progress.playTime)
        print(progress.duration)
        print(progress.fractionPlayed)
    }
```

The URL-owned player also provides a concise callback:

```swift
BPKVideoPlayer(url: videoURL, autoPlay: true, loop: true)
    .onProgress { progress in
        print(progress.fractionPlayed)
    }
```

`progress` is `nil`, and the publisher remains silent, until the video has a finite, positive duration. Each emitted `BPKVideoPlayerProgress` contains:

| Property | Meaning |
| --- | --- |
| `playTime` | Cumulative media time that actually advanced. Pauses and buffering do not add time; loops continue accumulating. |
| `duration` | The finite, positive media duration in seconds. |
| `fractionPlayed` | The current playhead fraction, clamped to `0...1`. It resets when playback starts again. |

Updates are delivered on the main queue at a best-effort cadence and duplicate snapshots are suppressed. Calling `seek(to:)` or `resetToStart()` updates `fractionPlayed` immediately without counting the seek distance as played time. Cumulative `playTime` is preserved across those operations.

Progress values are playback facts rather than analytics events. Consumers remain responsible for visibility, threshold definitions, one-shot event delivery, and impression/session boundaries.

## Carousel use case — tap to play, reset on scroll

```swift
BPKVideoPlayer(url: videoURL, autoPlay: false) { controller in
    if !controller.state.isPlaying {
        Button("Play") { controller.play() }
    }
}
.onDisappear {
    controller.resetToStart() // pause + seek to frame 0
}
```

## Audio behaviour

The player defaults to `AVAudioSession.ambient` with `.mixWithOthers`, so it respects the Ring/Silent switch and does not interrupt the user's background music. Playback automatically pauses when the app backgrounds and resumes on foreground.

For content whose audio should play through Silent mode, opt in to the playback policy. It continues to mix with background audio:

```swift
let controller = BPKVideoPlayerController(
    url: videoURL,
    audioSessionPolicy: .playback
)
```

## Accessibility

- Reduced motion: autoplay is blocked and playback pauses when the user enables Reduce Motion in system settings.
- `BPKVideoPlayerDefaultControls` exposes `.accessibilityLabel`, `.accessibilityValue`, and `.accessibilityHint` on the play/pause button.
