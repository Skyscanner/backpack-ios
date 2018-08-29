# Backpack/Gradient

## Installation

In `Podfile` add

```
pod 'Backpack/Gradient'
```

and then run `pod install`.

## Usage

`Backpack/Gradient` contains the Backpack gradient definitions in the class `BPKGradient`. `BPKGradient` has the two properties:

* `colors` of type `NSArray<UIColor *> *`
* `stops` encoded as `CGPoints` with components in the range 0-1 encoded as `NSValue`s in an `NSArray<NSValue *> *`


```objective-c
#import <Backpack/Gradient.h>

BPKGradient *gradientDefault = [BPKGradient gradient];
BPKGradient *gradientTopRight =  [BPKGradient primaryWithDirection:BPKGradientDirectionTopRight];
```
