# Backpack/ProgressBar

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
