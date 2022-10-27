# Backpack/Toast

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKToast.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Toast)

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-toast___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-toast___default_dm.png) |

## Installation

In `Podfile` add

```ruby
pod 'Backpack'
```
and then run `pod install`.

## Usage

`Backpack/Toast` contains a Backpack Toast component in the class `BPKToast`.It can display a toast view with a title and details text, it also contains a spinner view.

### Swift

```swift
import Backpack

let toast = BPKToast.showAdded(to: self.view, animated: true, accessibilityAnnouncement: "Announcement for VoiceOver")
toast.mode = .indeterminate // This is the default
toast.labelText = "This is the title"
toast.detailsLabelText = "Details label text"
toast.hide(true, afterDelay: 1.5)
```

### Objective-C

```objective-c
#import <Backpack/Toast.h>

BPKToast *toast = [BPKToast showToastAddedTo:self.view animated:YES accessibilityAnnouncement:@"Announcement for VoiceOver"];
toast.mode = BPKToastModeIndeterminate; // This is the default;
toast.removeFromSuperViewOnHide = YES;
toast.labelText = @"Title text"
toast.detailsLabelText = @"Details text"
[toast hide:YES afterDelay:1.5];
```

### Accessibility

Make sure you provide a translated string for the `accessibilityAnnouncement` property. This will be used to trigger a VoiceOver announcement whenever the Toast is presented.
