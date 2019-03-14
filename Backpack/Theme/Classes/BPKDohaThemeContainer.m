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

#import "BPKDohaThemeContainer.h"
#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKDohaThemeContainer()

@end

@implementation BPKDohaThemeContainer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        BPKAssertMainThread();
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        BPKAssertMainThread();
    }
    return self;
}

- (void)addSubview:(UIView *)view {
    [super addSubview:view];
    BPKAssertMainThread();
}

@end

NS_ASSUME_NONNULL_END
