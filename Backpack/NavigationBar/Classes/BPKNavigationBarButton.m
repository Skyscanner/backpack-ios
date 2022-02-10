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

#import "BPKNavigationBarButton.h"

#import <Backpack/Font.h>
#import <Backpack/Spacing.h>

@interface BPKButton ()

- (void)setupWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style;

@end

@implementation BPKNavigationBarButton

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    return self;
}

- (void)setupWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style {
    [super setupWithSize:BPKButtonSizeDefault style:BPKButtonStyleLink];
}

#pragma mark Spacing

- (UIEdgeInsets)contentEdgeInsetsForStyle:(BPKButtonStyle)style size:(BPKButtonSize)size {
    return UIEdgeInsetsMake(BPKSpacingNone, BPKSpacingNone, BPKSpacingNone, BPKSpacingNone);
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
