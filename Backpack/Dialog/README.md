# Backpack/Dialog

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKDialog.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Dialog)

## Alert

Alert dialogs fade in to the centre of the screen and can contain zero or more buttons. Used as a call to action.

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___with-cta_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___with-cta_dm.png) |

## Bottom sheet

Bottom sheet dialogs slide up from the bottom of the screen and can contain zero or more buttons. Used for confirmation.

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___delete-confirmation_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___delete-confirmation_dm.png) |

## Flare view

A dialog can be passed a BPKFlareView to show at the top.

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___in-app-messaging_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-dialog___in-app-messaging_dm.png) |

## Usage 

`BPKDialogController` contains the Backpack Dialog component.


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
let iconTemplate = BPKIcon.makeTemplateIcon(name: .tick, color: BPKColor.white, size: .large)
let iconDefinition = BPKDialogIconDefinition(icon: iconTemplate, iconBackgroundColor: BPKColor.green500)
let dialogController  = BPKDialogController(title: "You are going to Tokyo!",
                                          message: "Your flight is all booked. Why not check out some hotels now?",
                                          style: .alert,
                                          iconDefinition: iconDefinition

let mainAction = BPKDialogButtonAction(title: "Continue", style: .primary) {
    print("Primary was tapped, action: \($0)")
}
let skipAction = BPKDialogButtonAction(title: "Skip", style: .link) {
    print("Skip was tapped, action: \($0)")
}

let scrimAction = BPKDialogScrimAction(handler: { (didDismiss) in
    print("Scrim tap \(didDismiss ? "dimissing" : "")")
}, shouldDismiss: true)

dialogController.addButtonAction(mainAction)
dialogController.addButtonAction(skipAction)
dialogController.scrimAction = scrimAction

self.present(dialogController, animated: true, completion: nil)
```
