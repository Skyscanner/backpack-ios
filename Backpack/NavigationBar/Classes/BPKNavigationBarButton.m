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

#import "BPKNavigationBarButton.h"

#import <Backpack/Font.h>
#import <Backpack/Spacing.h>

@implementation BPKNavigationBarButton

- (instancetype)init {
    self = [super initWithSize:BPKButtonSizeLarge style:BPKButtonStyleLink];
    return self;
}

#pragma mark Spacing

- (UIEdgeInsets)contentEdgeInsetsForStyle:(BPKButtonStyle)style size:(BPKButtonSize)size {
    return UIEdgeInsetsMake(BPKSpacingNone, BPKSpacingNone, BPKSpacingNone, BPKSpacingNone);
}

#pragma mark - Touch target

// Icon-only buttons are only as big as their icon. Accept touches in a 44pt square around the
// button, Apple's minimum touch target, without changing how the button is laid out.
static CGFloat const BPKNavigationBarButtonMinimumTouchTarget = 44.0;

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat horizontalGrowth = MAX(0, (BPKNavigationBarButtonMinimumTouchTarget - CGRectGetWidth(bounds)) / 2.0);
    CGFloat verticalGrowth = MAX(0, (BPKNavigationBarButtonMinimumTouchTarget - CGRectGetHeight(bounds)) / 2.0);
    CGRect touchArea = CGRectInset(bounds, -horizontalGrowth, -verticalGrowth);
    return CGRectContainsPoint(touchArea, point);
}

#pragma mark - Helpers

- (BPKFontStyle)currentFontStyle {
    return BPKFontStyleTextHeading5;
}

- (void)setContentColor:(UIColor *)contentColor {
    if (contentColor != _contentColor) {
        _contentColor = contentColor;
        self.linkContentColor = contentColor;
    }
}

@end
