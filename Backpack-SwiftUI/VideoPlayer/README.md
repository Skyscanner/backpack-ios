# Backpack-SwiftUI/VideoPlayer

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/VideoPlayer)

## Default controls

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_video-player___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_video-player___default_dm.png" alt="" width="375" /> |

## Custom overlay

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_video-player___custom-overlay_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_video-player___custom-overlay_dm.png" alt="" width="375" /> |

# Usage

A scale-to-fill video player with no enforced aspect ratio. By default it shows a built-in play/pause button. Pass a custom `overlay` closure to replace it with your own UI — the live `BPKVideoPlayerController` is passed in so you can wire controls directly.

## Simple — built-in controls

```swift
BPKVideoPlayer(url: videoURL)

// With autoplay and looping
BPKVideoPlayer(url: videoURL, autoPlay: true, loop: true)
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
BPKVideoPlayer(controller: controller)

// Fullscreen sheet — same controller, playback never resets
BPKVideoPlayer(controller: controller)
```

## Custom overlay

Pass a `@ViewBuilder` closure to replace the default controls. The controller is provided so you can bind your own UI:

```swift
BPKVideoPlayer(url: videoURL, autoPlay: true) { controller in
    VStack {
        Spacer()
        HStack {
            Spacer()
            Button(action: controller.toggle) {
                Image(systemName: controller.state.isPlaying ? "pause.fill" : "play.fill")
                    .foregroundColor(.white)
            }
            .padding()
        }
    }
}
```

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
| `.readyToPlay` | Asset ready — autoPlay will call `play()` if enabled |
| `.playing` | Playback active |
| `.paused` | Playback paused |
| `.buffering` | Rebuffering mid-playback |
| `.failed(Error)` | Load failed or timed out |

Convenience helpers on `BPKVideoPlayerState`:

```swift
controller.state.isPlaying  // true only when .playing
controller.state.isLoading  // true for .loading and .buffering
```

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

The player uses `AVAudioSession.ambient` with `.mixWithOthers` so it never interrupts the user's background music. Playback automatically pauses when the app backgrounds and resumes on foreground.

## Accessibility

- Reduced motion: autoplay is blocked and playback pauses when the user enables Reduce Motion in system settings.
- `BPKVideoPlayerDefaultControls` exposes `.accessibilityLabel`, `.accessibilityValue`, and `.accessibilityHint` on the play/pause button.
