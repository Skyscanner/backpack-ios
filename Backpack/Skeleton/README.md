# Backpack/Skeleton

## Usage

`BPKSkeleton` contains the Backpack Skeleton component & Shimmer animation. It has 4 different types - image, circle, headline, body text.

Image has 2 styles: `default`(non-rounded), `rounded`. 1 default size, you also can pass custom size to `.custom(size:)`.
Circle has 2 sizes: `small`, `default`, you also can pass custom size to `.custom(size:)`. We will choose the short side as the diameter while width != height.
Headline has 3 sizes: `small`,` default`,` large`, you also can pass custom size to `.custom(size:)`.
Body text has 1 size: `default`, you also can pass custom size to `.custom(size:)`.


### Swift

```swift
import Backpack

let defaultImage = BPKSkeleton(type: .image)
let roundedImage = BPKSkeleton(type: .image, style: .rounded)
let customImage = BPKSkeleton(type: .image, size: .custom(size: CGSize(width: 160, height: 160)))

let defaultCircle = BPKSkeleton(type: .circle)
let small = BPKSkeleton(type: .circle, size: .small)
let customImage = BPKSkeleton(type: .circle, size: .custom(size: CGSize(width: 100, height: 120)))

let default = BPKSkeleton(type: .headline)
let small = BPKSkeleton(type: .headline, size: .small)
let large = BPKSkeleton(type: .headline, size: .large)
let custom = BPKSkeleton(type: .headline, size: .custom(size: CGSize(width: 88, height: 48)))
        
let bodytext = BPKSkeleton(type: .bodytext)
let custom = BPKSkeleton(type: .bodytext, size: .custom(size: CGSize(width: 260, height: 60)))

BPKSkeleton.startShimmer(view: yourView) // Make sure call this after yourView rendered.
BPKSkeleton.removeShimmer(view: yourView)
```
