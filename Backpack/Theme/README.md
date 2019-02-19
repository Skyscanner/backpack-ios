# Backpack Themes

## Usage

### Objective-c

`Backpack/Themes.h` contains two themes, London and HongKong. `BPKHongKongTheme` and `BPKLondonTheme` are used to enable themes. To do this globally for the whole app, simply update the `didFinishLaunchingWithOptions` function in `AppDelegate.m`, as follows:

<pre>
<b>#import &ltBackpack/Themes.h&gt</b>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    <b>[BPKLondonTheme apply];</b>
    return YES;
}
</pre>

With this done, any components that are placed inside an instance of `BPKLondonThemeContainer` will have the theme applied!

To unapply the theme, you need to apply `BPKDefaultTheme` to instances of `BPKLondonThemeContainer` as follows:

```
  [BPKDefaultTheme applyWithContainer:BPKLondonThemeContainer.class];
```

### Swift


<pre>
<b>import Backpack</b>

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    // Override point for customization after application launch. Here you can out the code you want.
    <b>LondonTheme.apply()</b>
    return true
}
</pre>

To unapply the theme, you need to apply `DefaultTheme` to instances of `LondonThemeContainer` as follows:

```
  DefaultTheme.apply(withContainer: UIView.self)
```
