# Backpack Color tokens

## Usage

### Objective-c

`Backpack/Color.h` contains our color palette contained in a single class `BPKColor`.

```objective-c
#import <Backpack/Color.h>

BPKColor.skyBlue;
BPKColor.skyGrayTint01;
```

Combining colours can be done using the following method:

```objective-c
[BPKColor blend:BPKColor.white with:BPKColor.skyGrayTint01 weight:0.85f];
```

The colours are also available as a category on `UIColor`.

```objective-c
UIColor.bpk_skyBlue;
UIColor.bpk_skyGrayTint01;
```

### Swift

`BPKColor` contains our color palette.

```swift
import Backpack

BPKColor.blue500
BPKColor.gray900
```

Combining colours can be done using the following method:

```swift
BPKColor.blend(.bpk_white, with: .bppk_skyGrayTint01, weight: 0.85f)
```

The colours are also available as a category on `UIColor`, this means that in Swift they can be used in situations where the type is known contextually.

```swift
UIColor.bpk_skyBlue
UIColor.bpk_skyGrayTint01
```

Contextually

```swift
myView.backgroundColor = .bpk_skyBlue
```


