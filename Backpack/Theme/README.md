# Backpack Themes

## Usage

There are four themes - `Default`, `Doha`, `HongKong`, and `London`.

To apply a theme globally, call the theme's `apply` method in `didFinishLaunchingWithOption` in `AppDelegate.m` or `AppDelegate.swift`. 
This will apply the theme to any Backpack components that are contained inside the appropriate theme container.

### Objective-C


#### Short example

```
id<BPKThemeDefinition> londonTheme = [BPKLondonTheme new];
[BPKTheme apply:londonTheme];
```

#### Longer example

```
#import <Backpack/Themes.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    id<BPKThemeDefinition> londonTheme = [BPKLondonTheme new];
    [BPKTheme apply:londonTheme];
    return YES;
}
```

With this done, any components that are placed inside an instance of `BPKLondonThemeContainer` will have the theme applied!

A primary color utility is provided by `BPKTheme` to give easy access to the relevant primary colour for your view.

Methods `gray50ColorFor`, `gray100ColorFor`, `gray300ColorFor`, `gray500ColorFor`, `gray700ColorFor`, and `gray900ColorFor` are available too.

```
BPKIconView *iconView = [[BPKIconView alloc] initWithIconName:BPKIconNameAccessibility size:BPKIconSizeLarge];
iconView.tintColor = [BPKTheme primaryColorFor:self];
```

### Swift

#### Short example

```
Theme.apply(londonTheme)
```

#### Longer example

```
import Backpack

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    // Override point for customization after application launch. Here you can out the code you want.
    let londonTheme = LondonTheme()
    Theme.apply(londonTheme)
    return true
}
```

With this done, any components that are placed inside an instance of `BPKLondonThemeContainer` will have the theme applied!


A primary color utility is provided by `BPKTheme` to give easy access to the relevant primary colour for your view.

Methods `gray50Color`, `gray100Color`, `gray300Color`, `gray500Color`, `gray700Color`, and `gray900Color` are available too.

```
let tickIcon: IconView = IconView(iconName: IconName.tick, size: BPKIconSize.small)
tickIcon.tintColor = Theme.primaryColor(for: self)
```

With this done, any components that are placed inside an instance of `BPKLondonThemeContainer` will have the theme applied!

