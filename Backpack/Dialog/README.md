# Backpack/Dialog

## Installation

In `Podfile` add

```
pod 'Backpack/Dialog'
```

and then run `pod install`.

## Usage

`Backpack/Dialog` contains the Backpack Dialog component in the class `BPKDialogController` .


### Objective-C
```
#import <Backpack/Dialog.h>

...

BPKAlertFaderAction *faderAction = [BPKAlertFaderAction actionWithHandler:^(BOOL didDismiss) {
    //
} shouldDismiss:YES];

BPKAlertButtonAction *buttonAction = [BPKAlertButtonAction actionWithTitle:@"Continue" style:BPKButtonStylePrimary handler:^{
    //
}];

BPKAlertDoneButtonAction *doneAction = [BPKAlertDoneButtonAction actionWithTitle:@"Done" isVisible:NO handler:^{
    //
}];

BPKAlertController *alertController = [BPKAlertController alertControllerWithTitle:@"Such Wow!"
                                                                           message:@"your description on the alert"
                                                                             style:BPKAlertControllerStyleAlert
                                                                       shadowStyle:BPKAlertControllerShadowStyleShadow
                                                                         headColor:BPKColor.blue500
                                                                         iconImage:[BPKIcon iconNamed:BPKIconNameTick color:BPKColor.white size:BPKIconSizeLarge]];

[alertController addFaderAction:faderAction];
[alertController addButtonAction:buttonAction];
[alertController addDoneButtonAction:doneAction];

[self presentViewController:alertController animated:NO completion:nil];

```

### Swift:
```
let alertController:AlertController = AlertController(title: "Such Wow!",
                                                    message: "Mauris auctor, arcu at consequat condimentum, sem lorem mollis turpis, sit amet tristique mi eros eget tellus. Integer pretium risus in ultrices maximus. In vitae convallis leo, ut ultricies metus. Proin molestie vestibulum lobortis. Maecenas a ultricies magna, vel iaculis nulla.",
                                                      style: .alert,
                                                shadowStyle: .noShadow,
                                                       head: Color.green500,
                                                  iconImage: Backpack.Icon.makeIcon(name: "tick", color: Color.white, size: .large))

let mainAction = AlertButtonAction(title: "Continue", style: .primary) {
    NSLog("Primary tapped")
}
let skipAction = AlertButtonAction(title: "skip", style: .link) {
    NSLog("skip tapped")
}

let doneAction = AlertDoneButtonAction(title: "Done", isVisible: true) {
    NSLog("Done pressed")
}

let faderAction = AlertFaderAction(handler: { (didDismiss) in
    NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
}, shouldDismiss: true)

alertController.addButtonAction(mainAction)
alertController.addButtonAction(skipAction);
alertController.addDoneButtonAction(doneAction);
alertController.addFaderAction(faderAction);

self.present(alertController, animated: false, completion: nil);
```
