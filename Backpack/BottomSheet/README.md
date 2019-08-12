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

### Objective-C

```objective-c
#import <Backpack/Backpack-Swift.h>

MyContentViewController *contentViewController = ... // A view controller that contains any kind of scroll view
BPKBottomSheet *bottomSheet = [[BPKBottomSheet alloc] initWithContentViewController:contentViewController
                                                                  scrollViewToTrack:contentViewController.scrollView
                                                        bottomSectionViewController:nil];
[bottomSheet presentInViewController:self animated:YES completion:nil];
```

# With a fixed bottom section

```objective-c
#import <Backpack/Backpack-Swift.h>

MyContentViewController *contentViewController = ... // A view controller that contains any kind of scroll view
MyFixedBottomSectionViewController *fixedBottomSectionViewController = ... // A view controller that will be fixed at the bottom (won't scroll)
BPKBottomSheet *bottomSheet = [[BPKBottomSheet alloc] initWithContentViewController:contentViewController
                                                                  scrollViewToTrack:contentViewController.scrollView
                                                        bottomSectionViewController:fixedBottomSectionViewController];
[bottomSheet presentInViewController:self animated:YES completion:nil];
```

### Swift

```swift
import Backpack

let contentViewController = ... // A view controller that contains any kind of scroll view
let bottomSheet = BottomSheet(contentViewController: contentViewController,
                              scrollViewToTrack: contentViewController.scrollView)
bottomSheet.present(in: self, animated: true, completion: nil)
```

# With a fixed bottom section

```swift
import Backpack

let contentViewController = ... // A view controller that contains any kind of scroll view
let fixedBottomSectionViewController = ... // A view controller that will be fixed at the bottom (won't scroll)
let bottomSheet = BottomSheet(contentViewController: contentViewController,
                              scrollViewToTrack: contentViewController.scrollView,
                              bottomSectionViewController: fixedBottomSectionViewController)
bottomSheet.present(in: self, animated: true, completion: nil)
```
