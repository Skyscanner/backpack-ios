# Backpack/Gradient

## Installation

In `Podfile` add

```
pod 'Backpack/Gradient'
```

and then run `pod install`.

## Usage

`Backpack/Gradient` contains the Backpack gradient definitions in the class `BPKGradient`. `BPKGradient` has the four properties:

+ `colors`
+ `stops`
+ `startPoint`
+ `endPoint`


```objective-c
#import <Backpack/Gradient.h>

BPKGradient *gradientDefault = [BPKGradient gradient];
BPKGradient *gradientTopRight =  [BPKGradient primaryWithDirection:BPKGradientDirectionTopRight];
```
