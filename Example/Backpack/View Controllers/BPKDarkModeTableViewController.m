/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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

#import "BPKRootListTableViewController.h"

#import <Backpack/DarkMode.h>

#import "Backpack_Native-Swift.h"

@implementation BPKDarkModeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

#if __BPK_DARK_MODE_SUPPORTED
    if (![self isDarkModeSupported]) {
        if (@available(iOS 13.0, *)) {
            self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        }
    }
#endif
}

- (BOOL)isDarkModeSupported {
    return [NSProcessInfo.processInfo.environment[@"DARK_MODE_ENABLED"] isEqual: @"YES"];
}

@end
