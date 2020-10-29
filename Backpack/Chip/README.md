# Backpack/Chip

## Installation

In `Podfile` add

```
pod 'Backpack/Chip'
```

and then run `pod install`.

## Usage

`Backpack/Chip` contains the Backpack Chip component in the class `BPKChip`. The chip is a simple padded control with a subtle outline and some text inside. It has two boolean properties, `selected` and `enabled`. `selected` is toggled when the user touches the chip.

```objective-c
#import <Backpack/Chip.h>

BPKChip *chip = [[BPKChip alloc] init];
chip.title = @"Some title";
chip.enabled = NO;
chip.backgroundTint = BPKColor.panjin;
chip.iconName = BPKIconNameMap;
```

```swift
import Backpack

let chip = BPKChip()
chip.title = "Some title"
chip.enabled = false
chip.backgroundTint = BPKColor.panjin
chip.iconName = .map
```

### Appearance attributes
`(UIColor)primaryColor`
