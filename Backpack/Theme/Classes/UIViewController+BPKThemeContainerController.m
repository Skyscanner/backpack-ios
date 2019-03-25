/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2019 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "UIViewController+BPKThemeContainerController.h"

#import "BPKThemeContainerController.h"

NS_ASSUME_NONNULL_BEGIN
@implementation UIViewController (BPKThemeContainerController)

- (nullable BPKThemeContainerController *)themeContainerController {
    UIViewController *parent = self;

    while (parent != nil) {
        if ([parent isKindOfClass:[BPKThemeContainerController class]]) {
            return (BPKThemeContainerController *)parent;
        }

        parent = parent.parentViewController;
    }

    return nil;
}

+(UIViewController*) findBestViewController:(UIViewController*)vc {

    if (vc.presentedViewController) {
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;

        if (svc.viewControllers.count > 0){
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        }else{
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;

        if (svc.viewControllers.count > 0) {

            return [UIViewController findBestViewController:svc.topViewController];
        }        else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;

        if (svc.viewControllers.count > 0){
            return [UIViewController findBestViewController:svc.selectedViewController];
        }else{
            return vc;
        }
    }

    // Default. Return the original `UIViewController`
    return vc;
}

+(UIViewController*) currentViewController {
    UIViewController* rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:rootViewController];
}

@end

NS_ASSUME_NONNULL_END
