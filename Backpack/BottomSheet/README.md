# Backpack/BottomSheet

## Installation

In `Podfile` add

```
pod 'Backpack/BottomSheet'
```

and then run `pod install`.

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