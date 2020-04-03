# Backpack/DarkMode

## Usage

`Backpack/DarkMode`/`BPKDarkMode` contains utilities that help when developing applications which support dark mode.

`__DARK_MODE_SUPPORTED` is a macro which determines if dark-mode specific compiler features are available. For example, `UIViewController` `overrideUserInterfaceStyle` property, which is only available in XCode 11.

### Objective-C

**`__DARK_MODE_SUPPORTED`**

```objective-c
#import <Backpack/DarkMode.h>

#if __BPK_DARK_MODE_SUPPORTED
  self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
#endif
```

### Swift

**`__DARK_MODE_SUPPORTED`**

```swift
import BPKDarkMode

#if __BPK_DARK_MODE_SUPPORTED
  overrideUserInterfaceStyle = .light
#endif
```

