# Nearby Airports information — DON-4084

The switch keeps a neutral information button on every visit. It opens a Backpack bottom sheet. A separate configuration enables an automatic native Apple TipKit introduction, using the same heading and message. The native tip also offers an action to open the bottom sheet.

The switch remains a standard on/off switch. The radio-row proposal is no longer part of this design.

## Try it

Open **Switches → SwiftUI → Open experimental switch**. The information button works with **Enable native introduction** off. Enable that separate option to assess the native tip. Apple owns its eligibility and display history; one stable ID shares one introduction across related selectors. The Example-only `SWITCH_INFORMATION_RESET` launch argument resets the test store before TipKit setup.

The consuming app configures TipKit once at launch. Only the introduction requires iOS 17; the button and bottom sheet remain available on Backpack's earlier supported versions. No iOS 26-only API is used. On iOS 17–18, native tips consume the first outside tap to dismiss; use the tip's information action or the persistent button after dismissal to open help.

At accessibility text sizes the sheet title moves into its scrollable content, keeping it separate from the close control. The sheet expands to full height when scrolling.

## Native captures

Captured on iPhone SE (third generation), iOS 18.5, with normal animations.

| Persistent button | Bottom sheet |
| --- | --- |
| ![Persistent information button](images/nearby-help-persistent-light.png) | ![Bottom sheet in light mode](images/nearby-help-sheet-light.png) |

| Optional Apple introduction | Bottom sheet, dark |
| --- | --- |
| ![Native Apple introduction](images/nearby-help-native-introduction.png) | ![Bottom sheet in dark mode](images/nearby-help-sheet-dark.png) |

Largest text, after expanding the sheet:

![Scrollable large-text information](images/nearby-help-sheet-large-text-scrolled.png)

## Validation

- All 15 Switch tests passed on the repository CI simulator: iPhone SE third generation, iOS 18.5, arm64. Existing references are unchanged; new information references cover light, dark, RTL and larger text.
- Four native UI scenarios passed on both iOS 18.5 (SE third generation) and iOS 26.2 (iPhone 12 mini), with normal animations. They cover independent repeatable help, preserved switch values and content frames, the native tip action, persisted dismissal after relaunch, dark mode and the largest accessibility text size.
- The 44-point touch-target check allows only 0.001 point for simulator coordinate rounding; the actual control remains 44 points.
- VoiceOver navigation and iPad have not been manually assessed.
