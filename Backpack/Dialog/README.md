# Backpack/Dialog

## Usage

`BPKDialogController`/`Backpack.DialogController` contains the Backpack Dialog component.


### Objective-C

```objective-c
#import <Backpack/Dialog.h>

...

BPKDialogScrimAction *scrimAction = [BPKDialogScrimAction actionWithHandler:^(BOOL didDismiss) {
    //
} shouldDismiss:YES];

BPKDialogButtonAction *mainAction = [BPKDialogButtonAction actionWithTitle:@"Continue" style:BPKButtonStylePrimary handler:^{
    //
}];

BPKDialogButtonAction *skipAction = [BPKDialogButtonAction actionWithTitle:@"Skip" style:BPKButtonStylePrimary handler:^{
    //
}];

[[BPKDialogIconDefinition alloc] initWithIcon:[BPKIcon templateIconNamed:BPKIconNameTick size:BPKIconSizeLarge]
                          iconBackgroundColor:BPKColor.green500];
BPKDialogController *dialogController = [BPKDialogController dialogControllerWithTitle:@"You are going to Tokyo!"
                                                                               message:@"Your flight is all booked. Why not check out some hotels now?"
                                                                                 style:BPKDialogControllerStyleAlert
                                                                        iconDefinition:iconDefinition];

dialogController.scrimAction = scrimAction;
[dialogController addButtonAction:mainAction];
[dialogController addButtonAction:skipAction];

[self presentViewController:dialogController animated:YES completion:nil];
```

### Swift:

```swift
let iconTemplate = Backpack.Icon.makeTemplateIcon(name: .tick, color: BPKColor.white, size: .large)
let iconDefinition = DialogIconDefinition(icon: iconTemplate, iconBackgroundColor: BPKColor.green500)
let dialogController  = DialogController(title: "You are going to Tokyo!",
                                        message: "Your flight is all booked. Why not check out some hotels now?",
                                        style: .alert,
                                        iconDefinition: iconDefinition

let mainAction = DialogButtonAction(title: "Continue", style: .primary) {
    print("Primary was tapped, action: \($0)")
}
let skipAction = DialogButtonAction(title: "Skip", style: .link) {
    print("Skip was tapped, action: \($0)")
}

let scrimAction = DialogScrimAction(handler: { (didDismiss) in
    print("Scrim tap \(didDismiss ? "dimissing" : "")")
}, shouldDismiss: true)

dialogController.addButtonAction(mainAction)
dialogController.addButtonAction(skipAction)
dialogController.scrimAction = scrimAction

self.present(dialogController, animated: true, completion: nil)
```
