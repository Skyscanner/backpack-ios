# Snippet

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSnippet.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Snippet)

## Landscape (default)

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_snippet___landscape_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_snippet___landscape_dm.png" alt="" width="375" /> |

## Square

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_snippet___square_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_snippet___square_dm.png" alt="" width="375" /> |

## Portrait

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_snippet___portrait_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_snippet___portrait_dm.png" alt="" width="375" /> |

## Usage

### Snippet with image only
All text fields are optional, which means by default `BPKSnippet` only has an image.
If you don't specify an `imageOrientation` parameter it will use the `.landscape` type

```swift
BPKSnippet(
    image: Image("dialog_image", bundle: TestsBundle.bundle)
)
```

### Snippet with all text fields 

```swift 
BPKSnippet(
    image: Image("dialog_image", bundle: TestsBundle.bundle),
    headline: "Headline Text",
    subheading: "Description",
    bodyText: "Body Text"
)
```

### Snippet with action to be performed on tap
Optionally, Snippet can also perform an action on tap, passing in the `onClick` closure argument:

```swift 
BPKSnippet(
    image: Image("dialog_image", bundle: TestsBundle.bundle),
    onClick: {
        print("Do some action here")
    }
)
```

The button accessibility trait is only applied when `onClick` is provided, so a
Snippet without an action isn't announced as a button.

### Accessibility header trait

The headline has the accessibility header trait by default. Set `accessibilityHeaderEnabled` to `false` when another view already provides the appropriate heading semantics.

```swift
BPKSnippet(
    image: Image("dialog_image", bundle: TestsBundle.bundle),
    headline: "Headline Text",
    accessibilityHeaderEnabled: false
)
```

## Cross-platform naming

Android exposes the equivalent accessibility control as `accessibilityHeaderTagEnabled: Boolean?`. iOS uses the shorter `accessibilityHeaderEnabled: Bool` name with a default value of `true`, following the same convention used on `BPKSectionHeader`.

The subheading parameter is also named differently across platforms: `subheading` on iOS and `subHeading` on Android. This is a known, intentional discrepancy rather than a bug.