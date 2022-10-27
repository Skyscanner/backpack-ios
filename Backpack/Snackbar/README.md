# Backpack/Snackbar

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKSnackbar.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Snackbar)

## With text

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-snack-bar___with-text_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-snack-bar___with-text_dm.png) |

## With text and button

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-snack-bar___with-text-and-button_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-snack-bar___with-text-and-button_dm.png) |

## With text and icon only button

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-snack-bar___with-text-and-icon-only-button_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-snack-bar___with-text-and-icon-only-button_dm.png) |

## Installation

In `Podfile` add

```
pod 'Backpack/Snackbar'
```

and then run `pod install`.

## Usage

`Backpack/Snackbar` contains a Backpack Snackbar component in the class `BPKSnackbar`. It can display a view at the bottom of the screen that appears and disappear with an animation.


```objective-c
#import <Backpack/Snackbar.h>

BPKSnackbar *snackBar = [[BPKSnackbar alloc] initWithTitle:@"Snackbar Title"
                                                  duration:BPKSnackbarDurationShort
                                            viewController:self.parentViewController
                                                  delegate:nil];
[snackBar show];

```

```swift
import Backpack

let snackbar = BPKSnackbar.init(title: "Snackbar Title",
                             duration: .long,
                       viewController: self,
                             delegate: nil)

snackbar.show()
```
