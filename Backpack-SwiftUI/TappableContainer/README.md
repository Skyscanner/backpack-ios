# TappableContainer

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKTappableContainer.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/TappableContainer)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_tappable-container___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_tappable-container___default_dm.png" alt="" width="375" /> |

## Usage

### Basic tappable container

Wrap any SwiftUI view to make it tappable with proper accessibility support.

    BPKTappableContainer(
        accessibilityLabel: "Tap to continue",
        action: { print("Container tapped") }
    ) {
        BPKText("Tap me!")
            .padding()
            .background(.surfaceDefaultColor)
            .clipShape(RoundedRectangle(cornerRadius: .sm))
    }

### Tappable container with no tap animation

Use `.noTapAnimation` button style when your content has its own interaction styling or you want to remove visual tap feedback.

    BPKTappableContainer(
        accessibilityLabel: "View flight details",
        action: { showFlightDetails() },
        buttonStyleType: .noTapAnimation
    ) {
        // Content with custom hover/press states
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

### Tappable card with complex content

    BPKTappableContainer(
        accessibilityLabel: "View flight details",
        action: { 
            // Navigate to flight details
            showFlightDetails() 
        }
    ) {
        HStack(spacing: .md) {
            BPKIconView(.aircraft, size: .large)
                .foregroundColor(.coreAccentColor)
            
            VStack(alignment: .leading, spacing: .sm) {
                BPKText("Flight Details", style: .heading5)
                BPKText("London to Paris", style: .caption)
                    .foregroundColor(.textSecondaryColor)
            }
            
            Spacer()
            
            BPKIconView(.chevronRight, size: .small)
                .foregroundColor(.textSecondaryColor)
        }
        .padding(.base)
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .lg))
    }

### Button style types

Choose between two button style types:

**Plain (default)**
- Preserves content appearance
- Provides standard iOS tap feedback
- Recommended for most use cases

    BPKTappableContainer(
        accessibilityLabel: "Standard tap feedback",
        action: { /* action */ },
        buttonStyleType: .plain
    ) { /* content */ }

**No Tap Animation**
- Removes visual tap feedback
- Use when content has custom interaction styling
- Ideal for cards or containers with their own press states

    BPKTappableContainer(
        accessibilityLabel: "No visual feedback",
        action: { /* action */ },
        buttonStyleType: .noTapAnimation
    ) { /* content */ }

### Accessibility considerations

Always provide a meaningful `accessibilityLabel` that describes what will happen when the container is tapped:

    // Good - describes the action
    BPKTappableContainer(
        accessibilityLabel: "Book flight from London to Paris for £150",
        action: { bookFlight() }
    ) { /* content */ }

    // Avoid - too generic
    BPKTappableContainer(
        accessibilityLabel: "Tap here",
        action: { bookFlight() }
    ) { /* content */ }

## Features

- **Accessibility Support**: Automatically adds button traits and uses provided accessibility labels
- **Flexible Button Styles**: Choose between plain style with feedback or no-animation style
- **Generic Content**: Accepts any SwiftUI view as content using `@ViewBuilder`
- **Touch Feedback**: Configurable touch feedback behavior based on button style
- **Flexible**: Works with simple text, complex cards, lists, or any SwiftUI view hierarchy

## Parameters

- `accessibilityLabel`: String describing what happens when tapped (required)
- `action`: Closure executed when the container is tapped (required)
- `buttonStyleType`: Button style type - `.plain` (default) or `.noTapAnimation` (optional)
- `content`: SwiftUI view builder containing the content to make tappable (required)
