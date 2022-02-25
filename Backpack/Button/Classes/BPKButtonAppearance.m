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

#import "BPKButtonAppearance.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPKButtonAppearance

- (instancetype)initWithBorderColor:(UIColor *_Nullable)borderColor
                 gradientStartColor:(UIColor *)gradientStartColor
                   gradientEndColor:(UIColor *)gradientEndColor
                    foregroundColor:(UIColor *)foregroundColor {
    self = [super init];

    if (self) {
        _borderColor = borderColor;
        _gradientStartColor = gradientStartColor;
        _gradientEndColor = gradientEndColor;
        _foregroundColor = foregroundColor;
    }

    return self;
}

- (instancetype)clone {
    return [[BPKButtonAppearance alloc] initWithBorderColor:self.borderColor
                                         gradientStartColor:self.gradientStartColor
                                           gradientEndColor:self.gradientEndColor
                                            foregroundColor:self.foregroundColor];
}

@end

NS_ASSUME_NONNULL_END
