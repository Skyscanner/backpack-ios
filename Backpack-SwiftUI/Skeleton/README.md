# Skeleton

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
import Backpack_SwiftUI

BPKSkeleton.image()
BPKSkeleton.image(style: .rounded)
BPKSkeleton.image(size: .custom(size: CGSize(width: 120, height: 120)))
```  
  

### **Circle skeleton**

Set the size to:

|  Size Options   | Size  |
|  ----  | ----  |
| `.small`  |  diameter: 32 |
| `.default`  |  diameter: 48 |
| `.custom(size: CGSize(width: xxx, height: xxx))`  |  We will choose the short side as the diameter while width != height |


```swift
import Backpack_SwiftUI

BPKSkeleton.circle(size: .small)
BPKSkeleton.circle() // Default size
BPKSkeleton.circle(size: .custom(size: CGSize(width: 120, height: 120)))
```


### **Headline skeleton**

|  Size Options   | Size  |
|  ----  | ----  |
| `.small`  |   size: 80 * 8 |
| `.default`  |  size: 80 * 16 |
| `.large`  |   size: 80 * 32 |
| `.custom(size: CGSize(width: xxx, height: xxx))`  |  N/A|

```swift
import Backpack_SwiftUI

BPKSkeleton.headline(size: .small)
BPKSkeleton.headline() // Default size
BPKSkeleton.headline(size: .large)
BPKSkeleton.headline(size: .custom(size: CGSize(width: 120, height: 120)))
```

### **Body text skeleton**

|  Size Options   | Size  |
|  ----  | ----  |
| `.default`  |  size: 200 * 40 |
| `.custom(size: CGSize(width: xxx, height: xxx))`  |   N/A |


```swift
import Backpack_SwiftUI

BPKSkeleton.bodytext() // Default size
BPKSkeleton.bodytext(size: .custom(size: CGSize(width: 280, height: 61)))
```

### **Shimmer animation**

```swift
import Backpack_SwiftUI

yourView {
}
.shimmering()
```

