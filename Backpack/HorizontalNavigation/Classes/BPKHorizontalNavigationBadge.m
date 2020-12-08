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

#import "BPKHorizontalNavigationBadge.h"

NS_ASSUME_NONNULL_BEGIN
/**
 * We added this interface here to silence the compiler as we know it exists and is a private method
 */
@interface BPKBadge (Private)
- (void)changeContentColor:(UIColor *)newColor;
@end

@implementation BPKHorizontalNavigationBadge

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.type = BPKBadgeTypeOutline;
    }

    return self;
}

- (void)setColor:(UIColor *)color {
    if (_color != color) {
        _color = color;

        [self updateStyleWithColor:_color];
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *_Nullable)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];

    if (@available(iOS 13.0, *)) {
        if (previousTraitCollection.userInterfaceStyle != self.traitCollection.userInterfaceStyle) {
            [self updateStyleWithColor:self.color];
        }
    }
}

- (void)updateStyleWithColor:(UIColor *)color {
    NSAssert([super respondsToSelector:@selector(changeContentColor:)], @"The private method's name has changed");
    if ([super respondsToSelector:@selector(changeContentColor:)]) {
        [super performSelector:@selector(changeContentColor:) withObject:color];
    }
}

@end
NS_ASSUME_NONNULL_END
