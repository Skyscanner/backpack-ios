# Backpack/Chip

## Installation

In `Podfile` add

```
pod 'Backpack/Chip'
```

and then run `pod install`.

## Usage

`Backpack/Chip` contains the Backpack Chip component in the class `BPKChip`. The chip is a simple padded control with a subtle shadow and some text inside. It has two boolean properties, `selected` and `enabled`. `selected` is toggled when the user touches the chip.
It also has a property `shadowEnabled`. Chips have shadows by default.


```objective-c
#import <Backpack/Chip.h>

BPKChip *chip = [[BPKChip alloc] init];
chip.title = @"Some title";
chip.enabled = NO;
chip.shadowEnabled = NO;
chip.backgroundTint = Color.panjin;
```

### Appearance attributes
`(UIColor)primaryColor`
