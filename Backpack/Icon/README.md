# Backpack/Icon

## Installation

In `Podfile` add

```
pod 'Backpack/Icon'
```

and then run `pod install`.

## Usage

`Backpack/Icon` contains the Backpack Icon component in the class `BPKIcon`. It supports rendering any Backpack icon to `UIImage`s using a caching mechanism to reduce performance impact.


```objective-c
#import <Backpack/Icon.h>
#import <Backpack/Color.h>

UIImage *renderedIcon = [BPKIcon iconNamed:@"flight" color:[BPKolor gray900] size:BPKIconSizeSmall];
```
