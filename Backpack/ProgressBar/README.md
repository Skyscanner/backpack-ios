# Backpack/ProgressBar

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKProgressBar.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/ProgressBar)

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-progress-bar___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-progress-bar___default_dm.png) |

## Usage

`Backpack/ProgressBar` is a simple [`UIProgressView`](https://developer.apple.com/documentation/uikit/uiprogressview#) with Skyscanner styling applied.

```objective-c
#import <Backpack/ProgressBar.h>

BPKProgressBar *progressBar = [[BPKProgressBar alloc] initWithFrame:CGRectZero];
progressBar.progress = 0.5;
[progressBar setProgress:0.75 animated:YES];
```

```swift
#import Backpack

let progressBar = BPKProgressBar()
progressBar.progress = 0.5
progressBar.set(progress:0.75 animated:true)
```

### Appearance attributes

- `(UIColor)fillColor`
