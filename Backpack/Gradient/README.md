# Backpack/Gradient

## Usage

`BPKGradient`/`Backpack.Gradient` contains the Backpack gradient definitions. Each instance has the four properties:

+ `colors`
+ `stops`
+ `startPoint`
+ `endPoint`

To render gradients `BPKGradientView`/`Backpack.GradientView` or `BPKGradientLayer`/`Backpack.GradientLayer` can be used.


### Objective-C

```objective-c
#import <Backpack/Gradient.h>

BPKGradient *gradientDefault = [BPKGradient primary];
BPKGradient *gradientTopRight =  [BPKGradient primaryWithDirection:BPKGradientDirectionTopRight];
```

### Swift

```swift
import Backpac

let gradientDefault = Backpack.Gradient.primary()
let gradientTopRight = Backpack.Gradient.primary(direction: .topRight)
```
