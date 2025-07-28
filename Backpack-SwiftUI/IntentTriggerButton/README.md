# BPKIntentTriggerButton

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKIntentTriggerButton.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/BPKIntentTriggerButton)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_intent-trigger-button___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_intent-trigger-button___default_dm.png" alt="" width="375" /> |

A SwiftUI button component that triggers App Intents when tapped, designed to integrate seamlessly with iOS system features like Siri, Shortcuts, and App Shortcuts.

**Note: This component requires iOS 17.0+ and must be wrapped in an availability check.**

## Features

- **App Intent Integration**: Uses the native iOS 17+ Button(intent:label:) initializer
- **Flexible Content**: Accepts any SwiftUI view as button content
- **System Integration**: Automatically integrates with Siri, Shortcuts, and App Shortcuts
- **Plain Button Style**: Uses `.plain` button style to maintain custom appearance
- **iOS 17+ Only**: Leverages the latest App Intents framework features

## Usage

### Basic Example

    import SwiftUI
    import AppIntents
    import Backpack_SwiftUI

    struct ContentView: View {
        var body: some View {
            if #available(iOS 17.0, *) {
                BPKIntentTriggerButton(
                    intent: RefreshWidgetIntent(),
                    label: {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 16)
                            Text("Refresh Widget")
                        }
                    }
                )
            }
        }
    }

### With ViewState Pattern (Widget Usage)

    if #available(iOS 17.0, *) {
        BPKIntentTriggerButton(
            intent: RefreshWidgetIntent(),
            label: {
                Image(viewState.refreshIcon, bundle: viewState.bundle)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
            }
        )
    }

## Creating App Intents

To use `BPKIntentTriggerButton`, you need to define your App Intent:

    import AppIntents

    struct RefreshWidgetIntent: AppIntent {
        static var title: LocalizedStringResource = "Refresh Widget"
        static var description = IntentDescription("Refreshes the widget data")
        
        func perform() async throws -> some IntentResult {
            // Your refresh logic here
            await refreshWidgetData()
            return .result()
        }
    }

## Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `intent` | `Intent: AppIntent` | The App Intent to trigger when the button is tapped |
| `label` | `@ViewBuilder` | A view builder that creates the button's visual content |

## Behavior

1. **Native Integration**: Uses the native iOS 17+ `Button(intent:label:)` initializer for optimal system integration.

2. **Automatic Handling**: The system automatically handles intent donation, execution, and integration with Siri and Shortcuts.

3. **Widget Support**: Perfect for use in WidgetKit extensions where you want interactive buttons.

4. **Plain Styling**: Applies `.plain` button style to preserve your custom button appearance.

## Accessibility

The button inherits accessibility features from the underlying SwiftUI `Button` and the content you provide. Make sure to add appropriate accessibility labels to your content views:

    if #available(iOS 17.0, *) {
        BPKIntentTriggerButton(
            intent: RefreshWidgetIntent(),
            label: {
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                    .accessibilityLabel("Refresh")
            }
        )
    }

## Requirements

- **iOS 17.0+** (for Button(intent:label:) initializer)
- SwiftUI
- App Intents framework
- Backpack-SwiftUI

## Notes

- **Always wrap in availability check**: This component must be wrapped in `if #available(iOS 17.0, *)` 
- **Widget compatibility**: Works seamlessly in WidgetKit extensions
- **System integration**: Intents are automatically available in Siri and Shortcuts app
- **Performance**: Uses the most efficient iOS 17+ implementation for intent buttons
