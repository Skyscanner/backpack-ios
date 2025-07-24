# TappableContainer & IntentTriggerButton

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/TappableContainer)

Interactive container components for wrapping content with tap functionality.

## TappableContainer

Wraps any SwiftUI view to make it tappable with proper accessibility support.

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_tappable-container___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_tappable-container___default_dm.png" alt="" width="375" /> |

### Usage

**Basic tappable container**

    BPKTappableContainer(
        accessibilityLabel: "Tap to continue",
        action: { print("Container tapped") }
    ) {
        BPKText("Tap me!")
            .padding()
            .background(.surfaceDefaultColor)
            .clipShape(RoundedRectangle(cornerRadius: .sm))
    }

**Tappable card with no animation**

    BPKTappableContainer(
        accessibilityLabel: "View flight details",
        action: { showFlightDetails() },
        buttonStyleType: .noTapAnimation
    ) {
        HStack(spacing: .md) {
            BPKIconView(.aircraft, size: .large)
            BPKText("Flight Details", style: .heading5)
            Spacer()
            BPKIconView(.chevronRight, size: .small)
        }
        .padding(.base)
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .lg))
    }

### Button Style Types
- **`.plain` (default)**: Standard iOS tap feedback
- **`.noTapAnimation`**: No visual feedback - use for custom interaction styling

### Parameters
- `accessibilityLabel`: String describing what happens when tapped (required)
- `action`: Closure executed when the container is tapped (required)
- `buttonStyleType`: Button style type - `.plain` or `.noTapAnimation` (optional)
- `content`: SwiftUI view builder containing the content to make tappable (required)

---

## IntentTriggerButton

**iOS 17.0+ only** - Triggers App Intents for system integration with Siri, Shortcuts, and widgets.

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_intent-trigger-button___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_intent-trigger-button___default_dm.png" alt="" width="375" /> |

### Usage

**Basic example**

    if #available(iOS 17.0, *) {
        BPKIntentTriggerButton(
            intent: RefreshWidgetIntent(),
            label: {
                HStack {
                    BPKIconView(.refresh, size: .small)
                    BPKText("Refresh Data", style: .bodyDefault)
                }
            }
        )
    }

**Widget-style button**

    if #available(iOS 17.0, *) {
        BPKIntentTriggerButton(
            intent: RefreshWidgetIntent(),
            label: {
                BPKIconView(.refresh, size: .small)
                    .foregroundColor(.coreAccentColor)
            }
        )
    }

### Creating App Intents

Define your App Intent to use with the button:

    import AppIntents

    struct RefreshWidgetIntent: AppIntent {
        static var title: LocalizedStringResource = "Refresh Widget"
        static var description = IntentDescription("Refreshes the widget data")
        
        func perform() async throws -> some IntentResult {
            // Your refresh logic here
            return .result()
        }
    }

### Parameters
- `intent`: The App Intent to trigger when the button is tapped (required)
- `label`: View builder that creates the button's visual content (required)

### Requirements
- iOS 17.0+ (must be wrapped in availability check)
- App Intents framework
- Perfect for WidgetKit extensions and system integration

## Accessibility

Always provide meaningful accessibility labels:

    // Good - describes the action
    BPKTappableContainer(
        accessibilityLabel: "Book flight from London to Paris for £150",
        action: { bookFlight() }
    ) { /* content */ }

    // For IntentTriggerButton, add labels to content views
    BPKIconView(.refresh, size: .small)
        .accessibilityLabel("Refresh")