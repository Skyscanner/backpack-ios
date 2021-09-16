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
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setPrimaryColor:(UIColor *_Nullable)primaryColor {
    if (_primaryColor != primaryColor) {
        _primaryColor = primaryColor;

        [self updateSwitchOnColor];
    }
}

- (void)updateSwitchOnColor {
    self.onTintColor = _primaryColor != nil ? _primaryColor : BPKColor.primaryColor;
}

- (void)setup {
    self.tintColor = BPKColor.skyGrayTint06;
    self.thumbTintColor = BPKColor.white;

    [self updateSwitchOnColor];
    [self setNeedsDisplay];
}

@end

NS_ASSUME_NONNULL_END
