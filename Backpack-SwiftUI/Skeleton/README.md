# Skeleton

## Usage

### Image skeleton

Set the border radius to:
* `.rounded`
* `.default`

Set the custom size:
* `.custom(size: CGSize(width: xxx, height: xxx))`

```swift
import Backpack_SwiftUI

BPKSkeleton.image()
BPKSkeleton.image(style: .rounded)
BPKSkeleton.image(size: .custom(size: CGSize(width: 120, height: 120)))
```

### Circle skeleton

Set the size to:
* `.small`
* `.default`
* `.custom(size: CGSize(width: xxx, height: xxx))` // We will choose the short side as the diameter while width != height


```swift
import Backpack_SwiftUI

BPKSkeleton.circle(size: .small)
BPKSkeleton.circle() // Default size
BPKSkeleton.circle(size: .custom(size: CGSize(width: 120, height: 120)))
```

### Bodytext skeleton

Set the size to:
* `.default`
* `.custom(size: CGSize(width: xxx, height: xxx))` 


```swift
import Backpack_SwiftUI

BPKSkeleton.bodytext() // Default size
BPKSkeleton.bodytext(size: .custom(size: CGSize(width: 280, height: 61)))
```

### Headline skeleton

Set the size to:
* `.small`
* `.default`
* `.large`
* `.custom(size: CGSize(width: xxx, height: xxx))` 

```swift
import Backpack_SwiftUI

BPKSkeleton.headline(size: .small)
BPKSkeleton.headline() // Default size
BPKSkeleton.headline(size: .large)
BPKSkeleton.headline(size: .custom(size: CGSize(width: 120, height: 120)))
```

### Shimmer animation

```swift
import Backpack_SwiftUI

yourView {
}
.shimmering()
```
