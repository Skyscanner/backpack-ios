# Backpack/BottomSheet

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKBottomSheet.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/BottomSheet)

## Default 

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-bottom-sheet___with-bottom-section_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-bottom-sheet___with-bottom-section_dm.png" alt="" width="375" /> |

## Installation

Add the `Backpack` product from the [backpack-ios](https://github.com/Skyscanner/backpack-ios)
Swift package to your target, then

```swift
import Backpack
```

## Usage

### Bottom Sheet

`Backpack/BottomSheet` is a component for presenting a floating panel similar to the one used in Apple Maps, Stocks and other native Apple apps.

### Swift

```swift
import Backpack

let contentViewController = ... // A view controller that contains any kind of scroll view
let bottomSheet = BPKBottomSheet(contentViewController: contentViewController,
                              scrollViewToTrack: contentViewController.scrollView)
bottomSheet.present(in: self, animated: true, completion: nil)
```

# With an intrinsic height

When you want to present a view that does not scroll, you can create a  Bottom Sheet without passing in a scroll view. The view will then use the size of the contents to determine the size.

```swift
import Backpack

let contentViewController = ... // A view controller
let bottomSheet = BPKBottomSheet(contentViewController: contentViewController)
bottomSheet.present(in: self, animated: true, completion: nil)
```

# With a fixed bottom section

```swift
import Backpack

let contentViewController = ... // A view controller that contains any kind of scroll view
let fixedBottomSectionViewController = ... // A view controller that will be fixed at the bottom (won't scroll)
let bottomSheet = BPKBottomSheet(contentViewController: contentViewController,
                              scrollViewToTrack: contentViewController.scrollView,
                              bottomSectionViewController: fixedBottomSectionViewController)
bottomSheet.present(in: self, animated: true, completion: nil)
```

# Persistent presentation style, similar to the one used in Apple Maps.

```swift
import Backpack

let contentViewController = ... // A view controller that contains any kind of scroll view
let fixedBottomSectionViewController = ... // A view controller that will be fixed at the bottom (won't scroll)
let bottomSheet = BPKBottomSheet(contentViewController: contentViewController,
                              scrollViewToTrack: contentViewController.scrollView,
                              bottomSectionViewController: fixedBottomSectionViewController,
                              presentationStyle: .persistent)
bottomSheet.addPanel(toParent: self)
```

# Moving the Bottom Sheet

You can move the  Bottom Sheet, by calling the move function. In snapshot tests you need to set animated to false, to make sure you get the correct  Bottom Sheet state.

The animated parameter is optional and has a default value of true

```swift
bottomSheet.move(to: <BPKFloatingPanelPosition>, animated: false)
```
# Adapting to the window

The bottom sheet follows the window it's shown in, so it needs no extra code for iPad, Split View or foldables such as the iPhone Duo:

- **Width.** On a phone-sized window the sheet fills the full width, and its background runs under side safe areas such as the iPhone Duo's side rail. Its content keeps the safe-area insets, so it stays clear of the rail. On a window wider than 672 pt, the readable content width, the sheet is centred at that width, like a native sheet.
- **Height.** The `half` and `tip` positions never cover more than 60% of the window's safe-area height, so a short window, such as a phone in landscape, keeps part of the screen behind the sheet visible.
- **Size changes.** When the window changes size, for example when an iPhone Duo is folded or unfolded, the sheet recomputes its positions for the new size.
