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

#import "BPKSwitch.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKSwitch ()

@end

@implementation BPKSwitch

- (instancetype)initWithCoder:(NSCoder *)coder {
    BPKAssertMainThread();
    self = [super initWithCoder:coder];
    if (self) {
        _primaryColor = BPKColor.blue500;

        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];
    if (self) {
        _primaryColor = BPKColor.blue500;

        [self setup];
    }
    return self;
}

- (void)setPrimaryColor:(UIColor *)primaryColor {
    if (_primaryColor != primaryColor) {
        _primaryColor = primaryColor;
        self.onTintColor = primaryColor;
    }
}

- (void)setup {
    self.tintColor = BPKColor.gray100;
    self.onTintColor = _primaryColor;
    [self setNeedsDisplay];
}

@end

NS_ASSUME_NONNULL_END
