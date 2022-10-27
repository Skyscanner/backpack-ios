# Backpack/NavigationBar

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKNavigationBar.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/NavigationBar)

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-navigation-bar___full-height_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-navigation-bar___full-height_dm.png) |

## Collapsed

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-navigation-bar___collapsed_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-navigation-bar___collapsed_dm.png) |

## With buttons

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-navigation-bar___full-height-with-buttons_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-navigation-bar___full-height-with-buttons_dm.png) |

## Usage

`BPKNavigationBar` is an implementation of parts of UIKit's UINavigationBar, specifically the large
title behaviour from iOS 11 and later. It is intended to be used when the main view of a view controller scrolls in which case
the navigation bar tracks the state of the scroll view.

`largeTitleTextColor` can be used to adjust the colour of the large title and `largeTitleLayoutMargins` can be used to adjust
the layout position of the large title.

### Objective-C

```objective-c
#import <Backpack/NavigationBar.h>

BPKNavigationBar *navigationBar = [[BPKNavigationBar alloc] initWithFrame:CGRectZero];

// In viewDidLoad

[navigationBar setUpForScrollview:myScrollView];

// Optional setup of custom navigation buttons
navigationBar.leftButton.hidden = NO;
navigationBar.leftButton.title = @"Back";
[navigationBar.leftButton addTarget:self action:@selector(leftButtonPressed) forControlEvents:UIControlEventTouchUpInside];

navigationBar.rightButton.hidden = NO;
navigationBar.rightButton.title = @"Done";
[navigationBar.rightButton addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];

// In scrollViewDidScroll:

[navigationBar updateWithScrollView:scrollView];

// In scrollViewDidEndDecelerating:

[navigationBar makeTitleVisibleWithScrollView:scrollView];

// In scrollViewDidEndDragging:

if (!willDecelerate) {
  [navigationBar makeTitleVisibleWithScrollView:scrollView];
}
```

### Swift

```swift
import Backpack

let navigationBar = BPKNavigationBar(frame: .zero)

// In viewDidLoad

navigationBar.setUp(for: myScrolView)

// Optional setup of custom navigation buttons
navigationBar.leftButton.isHidden = false
navigationBar.leftButton.title = "Back"
navigationBar.leftButton.addTarget(self, action: #selector(leftButtonPressed), for: .touchUpInside)

navigationBar.rightButton.isHidden = false
navigationBar.rightButton.title = "Done"
navigationBar.rightButton.addTarget(self, action: #selector(rightButtonPressed), for: .touchUpInside)

// In scrollViewDidScroll:

navigationBar.update(with: scrollView)

// In scrollViewDidEndDecelerating:

navigationBar.makeTitleVisible(with: scrollView)

// In scrollViewDidEndDragging:

if !decelerate {
  navigationBar.makeTitleVisible(with: scrollView)
}
```

### Appearance attributes

- `(UIColor *)largeTitleTextColor`
