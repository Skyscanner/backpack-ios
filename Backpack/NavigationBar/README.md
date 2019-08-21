# Backpack/NavigationBar

## Usage

`BPKNavigationBar`/`Backpack.NavigationBar` is an implementation of parts of UIKit's UINavigationBar, specifically the large
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

// In scrollViewDidScroll:

[navigationBar updateWithScrollView:scrollView];
```

### Swift

```swift
import Backpack

let navigationBar = Backpack.NavigationBar(frame: .zero)

// In viewDidLoad

navigationBar.setUp(for: myScrolView)

// In scrollViewDidScroll:

navigationBar.update(with: scrollView)
```

### Appearance attributes

`(UIColor *)largeTitleTextColor`
