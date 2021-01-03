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

#import "BPKProgressBar.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPKProgressBar

- (instancetype _Nullable)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

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

- (void)setFillColor:(UIColor *_Nullable)fillColor {
    if (_fillColor != fillColor) {
        _fillColor = fillColor;

        self.progressTintColor = self.fillColor != nil ? self.fillColor : BPKColor.skyBlue;
    }
}

#pragma mark - Private

- (double)barHeight {
    return BPKSpacingSm / 2;
}

- (void)setup {
    self.trackTintColor = [self.class backgroundColor];
    self.progressTintColor = BPKColor.skyBlue;
}

+ (UIColor *)backgroundColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint06 darkVariant:BPKColor.blackTint02];
}

@end
NS_ASSUME_NONNULL_END
