# Backpack/Icon

## Usage

`BPKIcon`/`Backpack.Icon` contains the Backpack Icon component. It supports rendering any Backpack icon to `UIImage`s using a caching mechanism to reduce performance impact.

### Objective-C

```objective-c
#import <Backpack/Icon.h>
#import <Backpack/Color.h>

UIImage *renderedIcon = [BPKIcon iconNamed:@"flight" color:[BPKolor gray900] size:BPKIconSizeSmall];
```

### Swift

```swift
import Backpack

let renderedIcon = Backpack.Icon.makeIcon(name: .flight, color: Backpack.Color.gray900, size:.small);
```

