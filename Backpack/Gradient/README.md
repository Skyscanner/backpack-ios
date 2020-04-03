# Backpack/Gradient

## Usage

`BPKGradient` contains the Backpack gradient definitions. Each instance has the four properties:

+ `colors`
+ `stops`
+ `startPoint`
+ `endPoint`

To render gradients `BPKGradientView` or `BPKGradientLayer` can be used.


### Objective-C

```objective-c
#import <Backpack/Gradient.h>

BPKGradient *gradientDefault = [BPKGradient primary];
BPKGradient *gradientTopRight =  [BPKGradient primaryWithDirection:BPKGradientDirectionTopRight];
```

### Swift

```swift
import Backpack

let gradientDefault = BPKGradient.primary()
let gradientTopRight = BPKGradient.primary(direction: .topRight)
```
