# Backpack Themes

## Usage

There are four themes - `Default`, `Doha`, `HongKong`, and `London`.

To apply a theme globally, call the theme's `apply` method in `didFinishLaunchingWithOption` in `AppDelegate.m` or `AppDelegate.swift`. 
This will apply the theme to any Backpack components that are contained inside the appropriate theme container.

### Objective-C


#### Short example

```
[BPKLondonTheme apply];
```

#### Longer example

```
#import <Backpack/Themes.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [BPKLondonTheme apply];
    return YES;
}
```


### Swift

#### Short example

```
LondonTheme.apply()
```

#### Longer example

```
import Backpack

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    // Override point for customization after application launch. Here you can out the code you want.
    LondonTheme.apply()
    return true
}
```

With this done, any components that are placed inside an instance of `BPKLondonThemeContainer` will have the theme applied!

