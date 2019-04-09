# Backpack Color tokens

## Usage

### Objective-c

`Backpack/Color.h` contains our color palette contained in a single class `BPKColor`.

```objective-c
#import <Backpack/Color.h>

BPKColor.blue500;
BPKColor.gray900;
```

Combining colours can be done using the following method:

```objective-c
[BPKColor blend:BPKColor.white with:BPKColor.gray900 weight:0.85f];
```

### Swift

`Backpack.Color` contains our color palette.

```swift
import Backpack

Backpack.Color.blue500
Backpack.Color.gray900
```

Combining colours can be done using the following method:

```swift
Color.blend(Color.white, with: Color.gray900, weight: 0.85f)
```
