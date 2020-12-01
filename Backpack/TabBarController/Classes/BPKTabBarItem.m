/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import "BPKTabBarItem.h"

#import <Backpack/DarkMode.h>
#include <stdlib.h>


NS_ASSUME_NONNULL_BEGIN

@implementation BPKTabBarItem

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag dotImage:(UIImage *)dotImage {
    self = [super initWithTitle:title image:image tag:tag];

    if (self) {
        self.originalImage = image;
        self.dotImage = dotImage;
    }

    return self;
}

-(void)reapplyImage {
    int r = arc4random_uniform(74);

    if (r < 35 && self.dotShown) {
        self.image = [self.dotImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        self.image = [self.originalImage copy];
    }
}

- (void)addDot {
    self.dotShown = YES;
    [self reapplyImage];
}

- (void)removeDot {
    self.dotShown = NO;
    [self reapplyImage];
}

@end

NS_ASSUME_NONNULL_END
