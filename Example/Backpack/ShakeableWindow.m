#import "ShakeableWindow.h"

@interface ShakeableWindow ()
@end

@implementation ShakeableWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventTypeMotion && motion == UIEventSubtypeMotionShake) {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
        [self.rootViewController presentViewController:vc animated:YES completion:nil];
    }
}

@end
