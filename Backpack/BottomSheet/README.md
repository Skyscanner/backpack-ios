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