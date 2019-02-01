# Backpack Disco Ninja

## Usage

### Objective-c

`Backpack/DiscoNinja.h` contains two classes. `BPKDiscoNinja` and `BPKDiscoNinjaContainer`. `BPKDiscoNinja` is used to enable Disco Ninjas globally within your app. In the main `AppDelegate.m` file, simply update the `didFinishLaunchingWithOptions` function as follows:

<pre>
<b>#import &ltBackpack/DiscoNinja.h&gt</b>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    <b>[BPKDiscoNinja startDancingYo];</b>
    return YES;
}
</pre>

With this done, any components that are placed inside an instance of `BPKDiscoNinjaContainer` will dance like disco ninjas!

### Swift


<pre>
<b>import Backpack</b>

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    // Override point for customization after application launch. Here you can out the code you want.
    <b>BPKDiscoNinja.startDancingYo()</b>
    return true
}
</pre>