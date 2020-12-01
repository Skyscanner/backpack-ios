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

#import "BPKTabBarController.h"
#import "BPKTabBarItem.h"

#import <Backpack/DarkMode.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPKTabBarController

-(void)updateImages {
    for (UITabBarItem *tabBarItem in self.tabBar.items) {
        if([tabBarItem isKindOfClass:BPKTabBarItem.class]) {

        BPKTabBarItem *bpkTabBarItem = (BPKTabBarItem *)tabBarItem;
            [bpkTabBarItem reapplyImage];
    }
    }
}

// Note this is needed to correctly update the `CGColor` used for the line .
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle) {
            [self updateImages];
        }
    }
#endif
}

@end

NS_ASSUME_NONNULL_END
