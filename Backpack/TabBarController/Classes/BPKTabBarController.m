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

#import "BPKTabBarController.h"
#import "BPKTabBarItem.h"

#import <Backpack/DarkMode.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPKTabBarController

- (void)updateTabBarItems {
    UIUserInterfaceStyle interfaceStyle = self.traitCollection.userInterfaceStyle;

    NSUInteger index = 0;
    for (UITabBarItem *tabBarItem in self.tabBar.items) {
        if ([tabBarItem isKindOfClass:BPKTabBarItem.class]) {
            BPKTabBarItem *bpkTabBarItem = (BPKTabBarItem *)tabBarItem;
            bpkTabBarItem.interfaceStyle = interfaceStyle;
            bpkTabBarItem.selected = self.selectedIndex == index;
        }
        index += 1;
    }
}

// This is used to inform each BPKTabBarItem of the userInterfaceStyle, as they cannot access this directly.
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
#if __BPK_DARK_MODE_SUPPORTED
    if (self.traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle) {
        [self updateTabBarItems];
    }
#endif
}

- (void)didMoveToParentViewController:(UIViewController *_Nullable)parent {
    [super didMoveToParentViewController:parent];
    [self updateTabBarItems];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    [self updateTabBarItems];
}

- (void)setSelectedViewController:(__kindof UIViewController *_Nullable)selectedViewController {
    [super setSelectedViewController:selectedViewController];
    [self updateTabBarItems];
}

@end

NS_ASSUME_NONNULL_END
