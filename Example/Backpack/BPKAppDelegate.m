/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import "BPKAppDelegate.h"
#import "Backpack_Native-Swift.h"

#import <Backpack/Appearance.h>
#import <Backpack/Color.h>
#import <Backpack/DarkMode.h>
#import <Backpack/Font.h>
#import <Backpack/Theme.h>

@import AppCenter;
@import AppCenterDistribute;
@import AppCenterAnalytics;
@import AppCenterCrashes;

@interface BPKAppDelegate ()
@property(assign, nonatomic, getter=isUITestingEnabled) BOOL UITestingEnabled;
@end

@implementation BPKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.UITestingEnabled = [NSProcessInfo.processInfo.arguments containsObject:@"UITests"];

    id<BPKFontDefinitionProtocol> relativeFontDefinition = [BPKRelativeFontDefinition new];
    UIFont *relativeTestFont = [UIFont fontWithName:relativeFontDefinition.regularFontFace size:12];
    if (relativeTestFont != nil) {
        [BPKFont setFontDefinition:relativeFontDefinition];
    }

    // Override point for customization after application launch.
    [UINavigationBar appearance].tintColor = BPKColor.textPrimaryColor;
    [UINavigationBar appearance].titleTextAttributes = @{
        NSForegroundColorAttributeName: BPKColor.textPrimaryColor,
        NSFontAttributeName: [[BPKFontManager sharedInstance] semiboldFontWithSize:17.0]
    };

    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName: BPKColor.textPrimaryColor,
        NSFontAttributeName: [[BPKFontManager sharedInstance] regularFontWithSize:17.0]
    }
                                                forState:UIControlStateNormal];

    [UINavigationBar appearance].largeTitleTextAttributes = @{
        NSForegroundColorAttributeName: BPKColor.textPrimaryColor,
        NSFontAttributeName: [[BPKFontManager sharedInstance] semiboldFontWithSize:34.0]
    };

    [BPKAppearance apply];

    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UINavigationController *navigationController = [UINavigationController new];

    BPKRootTableViewController *rootTableViewController = [BPKRootTableViewController new];
    navigationController.viewControllers = @[rootTableViewController];
    self.window.rootViewController = navigationController;

    if ([ThemeHelpers isThemingSupported]) {
        [ThemeHelpers applyAllThemes];

        id<BPKThemeDefinition> activeTheme = [ThemeHelpers themeDefinitionForTheme:Settings.sharedSettings.activeTheme];

        BPKThemeContainerController *themeContainerController =
            [[BPKThemeContainerController alloc] initWithThemeDefinition:activeTheme rootViewController:self.window.rootViewController];
        self.window.rootViewController = themeContainerController;
    }

    [self.window makeKeyAndVisible];

    // If simctl gets the ability to handle this then we should switch to using it.
    if ([ThemeHelpers forceDarkMode]) {
#if __BPK_DARK_MODE_SUPPORTED
        if (@available(iOS 13.0, *)) {
            self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
        }
#endif
    }

    [MSACAppCenter start:@"$(APP_CENTER_SECRET)" withServices:@[MSACAnalytics.class, MSACCrashes.class, MSACDistribute.class]];

    if (self.UITestingEnabled) {
        self.window.layer.speed = 100;
        [UIView setAnimationsEnabled:NO];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of
    // temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application
    // and it begins the transition to the background state. Use this method to pause ongoing tasks, disable timers, and
    // throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application
    // state information to restore your application to its current state in case it is terminated later. If your
    // application supports background execution, this method is called instead of applicationWillTerminate: when the
    // user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes
    // made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application
    // was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also
    // applicationDidEnterBackground:.
}

@end
