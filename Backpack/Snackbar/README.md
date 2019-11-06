# Backpack/Snackbar

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

let snackbar = Snackbar.init(title: "Snackbar Title",
                          duration: .long, 
                    viewController: self,
                          delegate: nil)

snackbar.show()
```
