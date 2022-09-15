# Backpack/Skeleton

## Usage

### **Image skeleton**


| Style Options   | Border radius  |
|  ----  | ----  |
| `.rounded`  | 8 px |
| `.default`  | 0 |

Set the custom size:

`// Default size: 96 * 96`
* `.custom(size: CGSize(width: xxx, height: xxx))`


```swift
import Backpack

let defaultImage = BPKSkeleton(type: .image)
let roundedImage = BPKSkeleton(type: .image, style: .rounded)
let customImage = BPKSkeleton(type: .image, size: .custom(size: CGSize(width: 160, height: 160)))
```

### **Circle skeleton**

Set the size to:

|  Size Options   | Size  |
|  ----  | ----  |
| `.small`  |  diameter: 32 |
| `.default`  |  diameter: 48 |
| `.custom(size: CGSize(width: xxx, height: xxx))`  |  We will choose the short side as the diameter while width != height |
```swift
import Backpack

let defaultCircle = BPKSkeleton(type: .circle)
let small = BPKSkeleton(type: .circle, size: .small)
let customImage = BPKSkeleton(type: .circle, size: .custom(size: CGSize(width: 100, height: 120)))
```


### **Headline skeleton**

|  Size Options   | Size  |
|  ----  | ----  |
| `.small`  |   size: 80 * 8 |
| `.default`  |  size: 80 * 16 |
| `.large`  |   size: 80 * 32 |
| `.custom(size: CGSize(width: xxx, height: xxx))`  |  N/A|

```swift
import Backpack

let default = BPKSkeleton(type: .headline)
let small = BPKSkeleton(type: .headline, size: .small)
let large = BPKSkeleton(type: .headline, size: .large)
let custom = BPKSkeleton(type: .headline, size: .custom(size: CGSize(width: 88, height: 48)))
```

### **Body text skeleton**

|  Size Options   | Size  |
|  ----  | ----  |
| `.default`  |  size: 200 * 40 |
| `.custom(size: CGSize(width: xxx, height: xxx))`  |   N/A |


```swift
import Backpack
        
let bodytext = BPKSkeleton(type: .bodytext)
let custom = BPKSkeleton(type: .bodytext, size: .custom(size: CGSize(width: 260, height: 60)))
```

### Shimmer animation
```swift
import Backpack

BPKSkeleton.startShimmer(view: yourView) // Make sure call this after yourView rendered.
BPKSkeleton.removeShimmer(view: yourView)

```