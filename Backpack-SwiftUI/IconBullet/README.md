# IconBullet

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKIconBullet.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/IconBullet)

Icon Bullet renders a single icon inside a filled circular container, in one of three sizes and three color types.

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_icon-bullet___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_icon-bullet___default_dm.png" alt="" width="375" /> |

## Usage

If you don't specify a `.iconBulletStyle(<style>)` and a `.iconBulletSize(<size>)` it will use the `.legacy` style and the `.small` size.

```swift
import Backpack_SwiftUI

BKPIconBullet(.trendDown)

BKPIconBullet(.trendDown)
    .iconBulletStyle(.brand)
    .iconBulletSize(.medium)
```


### Available styles

`BPKIconBullet` supports three styles:
- `.strong`
- `.brand`
- `.loyalty`
                   
and three sizes:
- `.small`
- `.medium`
- `.large`
