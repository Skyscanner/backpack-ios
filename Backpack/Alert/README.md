# Backpack/Alert

## Installation

In `Podfile` add

```
pod 'Backpack/Alert'
```

and then run `pod install`.

## Usage

`Backpack/Alert` contains the Backpack Alert component in the class `BPKAlertController` .

#### Make sure you have a retained BPKAlertController, else you wont be able to dismiss the alert!

### Objective-C
```
#import <Backpack/Alert.h>

...

_alertController = [[BPKAlertController alloc] init];

...

BPKAlertButtonConfiguration *primaryButtonConfiguration = [BPKAlertButtonConfiguration configurationWithStyle:BPKButtonStylePrimary title:@"Continue" actionHandler:^{
    NSLog(@"Continue tapped");
}];
    
BPKAlertButtonConfiguration *skipButtonConfiguration = [BPKAlertButtonConfiguration configurationWithStyle:BPKButtonStyleLink title:@"Skip" actionHandler:^{
    NSLog(@"Skip tapped");
}];
    
BPKAlertFaderConfiguration *faderConfiguration = [BPKAlertFaderConfiguration configurationWithActionHandler:^(BOOL didDismiss) {
    NSLog(@"fader tapped, didDismiss? %@", @(didDismiss));
} shouldDismiss:YES];
    
BPKAlertDoneButtonAction *doneButtonConfiguration = [BPKAlertDoneButtonAction configurationWithActionHandler:^{
    NSLog(@"Done tapped tapped");
} isVisible:NO titleText:@"Done"];
    
BPKAlertConfiguration *configuration = [[BPKAlertConfiguration alloc] initWithCircleColor:BPKColor.green500
                                                                                     icon:[BPKIcon iconNamed:@"tick" color:BPKColor.white size:BPKIconSizeLarge]
                                                                                titleText:@"Title"
                                                                          descriptionText:@"Lorem Ipsum Dolor Sit Amet"
                                                                     buttonConfigurations:@[primaryButtonConfiguration, skipButtonConfiguration]
                                                                                hasShadow:YES
                                                                  doneButtonConfiguration:doneButtonConfiguration
                                                                       faderConfiguration:faderConfiguration
                                                                             isFullScreen:NO];
    
[_alertController alertWithConfiguration:configuration onView:self.view.window];
...
```

### Swift:
```
let primaryBtnConfig = AlertButtonConfiguration.init(style: .primary, title: "Continue", actionHandler: {
    NSLog("Primary tapped")
})
    
let skipBtnConfig = AlertButtonConfiguration.init(style: .link, title: "skip", actionHandler: {
    NSLog("skip tapped")
})

let faderConfig = AlertFaderConfiguration.init(actionHandler: { (didDismiss) in
    NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
}, shouldDismiss: true)
    
let alertConfig = AlertConfiguration.init(circleColor: Color.green500,
                                          icon:Backpack.Icon.makeIcon(name: "tick", color: Color.white, size: .large),
                                          titleText: "Such Wow!",
                                          descriptionText: "Mauris auctor, arcu at consequat condimentum, sem lorem mollis turpis, sit amet tristique mi eros eget tellus. Integer pretium risus in ultrices maximus. In vitae convallis leo, ut ultricies metus. Proin molestie vestibulum lobortis. Maecenas a ultricies magna, vel iaculis nulla.",
                                          buttonConfigurations: [primaryBtnConfig, skipBtnConfig],
                                          hasShadow: true,
                                          doneButtonConfiguration: nil,
                                          faderConfiguration: faderConfig,
                                          isFullScreen: false)
self.alertController.alert(with: alertConfig, on: self.view.window!)
```