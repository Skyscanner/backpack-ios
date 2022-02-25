/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

#import <Backpack/Color.h>
#import <Backpack/Icon.h>
#import <Backpack/TabBarController.h>

#import "BPKSnapshotTest.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKTabBarControllerSnapshotTest : FBSnapshotTestCase
@end

@implementation BPKTabBarControllerSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)createTabBarController {
    BPKTabBarController *tabBarController = [[BPKTabBarController alloc] init];
    tabBarController.tabBar.unselectedItemTintColor = BPKColor.textQuaternaryColor;
    tabBarController.tabBar.tintColor = BPKColor.primaryColor;

    UIViewController *tabOne = [[UIViewController alloc] init];
    UITabBarItem *tabOneBarItem = [[UITabBarItem alloc] initWithTitle:@"Tab 1" image:nil tag:1];
    UIViewController *tabTwo = [[UIViewController alloc] init];
    UITabBarItem *tabTwoBarItem = [[UITabBarItem alloc] initWithTitle:@"Tab 2" image:nil tag:2];

    tabOne.tabBarItem = tabOneBarItem;
    tabTwo.tabBarItem = tabTwoBarItem;

    tabBarController.viewControllers = @[tabOne, tabTwo];

    return tabBarController.view;
}

- (void)testTabBarController {
    UIView *lightView = [self createTabBarController];
    UIView *darkView = [self createTabBarController];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createTabBarControllerWithIcons {
    BPKTabBarController *tabBarController = [[BPKTabBarController alloc] init];
    tabBarController.tabBar.unselectedItemTintColor = BPKColor.textQuaternaryColor;
    tabBarController.tabBar.tintColor = BPKColor.primaryColor;

    UIViewController *tabOne = [[UIViewController alloc] init];
    UITabBarItem *tabOneBarItem = [[UITabBarItem alloc] initWithTitle:@"Tab 1" image:[BPKIcon largeTemplateIconNamed:BPKLargeIconNameKey] tag:1];
    UIViewController *tabTwo = [[UIViewController alloc] init];
    BPKTabBarDotImageDefinition *exploreTabBarDotImage = [[BPKTabBarDotImageDefinition alloc] initWithLightImage:[UIImage imageNamed:@"tab_explore_with_dot_lm"] darkImage:[UIImage imageNamed:@"tab_explore_with_dot_dm"]];
    BPKTabBarItem *tabTwoBarItem = [[BPKTabBarItem alloc] initWithTitle:@"Tab 2" image:[BPKIcon largeTemplateIconNamed:BPKLargeIconNameExplore] tag:2 dotImageDefinition:exploreTabBarDotImage];
    [tabTwoBarItem addDot];
    UIViewController *tabThree = [[UIViewController alloc] init];
    UITabBarItem *tabThreeBarItem = [[UITabBarItem alloc] initWithTitle:@"Tab 3" image:[BPKIcon largeTemplateIconNamed:BPKLargeIconNameMap] tag:3];
    tabThreeBarItem.badgeColor = BPKColor.panjin;
    tabThreeBarItem.badgeValue = @"42";

    UIViewController *tabFour = [[UIViewController alloc] init];
    BPKTabBarDotImageDefinition *profileTabBarDotImage = [[BPKTabBarDotImageDefinition alloc] initWithLightImage:[UIImage imageNamed:@"tab_profile_with_dot_lm"] darkImage:[UIImage imageNamed:@"tab_profile_with_dot_dm"]];
    BPKTabBarItem *tabFourBarItem = [[BPKTabBarItem alloc] initWithTitle:@"Tab 4" image:[BPKIcon largeTemplateIconNamed:BPKLargeIconNameCars] tag:4 dotImageDefinition:profileTabBarDotImage];
    [tabFourBarItem addDot];

    tabOne.tabBarItem = tabOneBarItem;
    tabTwo.tabBarItem = tabTwoBarItem;
    tabThree.tabBarItem = tabThreeBarItem;
    tabFour.tabBarItem = tabFourBarItem;

    tabBarController.viewControllers = @[tabOne, tabTwo, tabThree, tabFour];
    tabBarController.selectedViewController = tabTwo;

    return tabBarController.view;
}

- (void)testTabBarControllerWithIcons {
    UIView *lightView = [self createTabBarControllerWithIcons];
    UIView *darkView = [self createTabBarControllerWithIcons];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end
NS_ASSUME_NONNULL_END
