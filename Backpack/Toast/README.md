# Backpack/Toast

## Installation

In `Podfile` add

```aspnet
pod 'Backpack/Toast'
```
and then run `pod install`.

## Usage

`Backpack/Toast` contains a Backpack Toast component in the class `BPKToast`.It can display a toast view with a title and details text, it also contains a spinner view.

```objective-c
#import <Backpack/Toast.h>

BPKToast *toast = [BPKToast showToastAddedTo:self.view animated:YES];
toast.mode = BPKToastModeIndeterminate; // This is the default;
toast.removeFromSuperViewOnHide = YES;
toast.labelText = @"Title text"
toast.detailsLabelText = @"Details text"
[toast hide:YES afterDelay:1.5];
```
