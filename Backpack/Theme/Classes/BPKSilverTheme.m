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

#import "BPKSilverTheme.h"
#import "BPKSilverThemeContainer.h"

#import <Backpack/Button.h>
#import <Backpack/Chip.h>
#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Gradient.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

@implementation BPKSilverTheme

- (NSString *)themeName {
    return @"Silver";
}

- (BPKFontMapping *)fontName {
    return [[BPKFontMapping alloc] initWithFamily:@"Charter-Roman" withBoldFamily:@"Charter-Bold" withHeavyFamily:@"Charter-Black"];
}

- (UIColor *)chipPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)switchPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)primaryColor {
    return BPKColor.blue700;
}

- (BPKGradient *)primaryGradient {
    UIColor *startColor = BPKColor.gray200;
    UIColor *endColor = BPKColor.gray900;
    CGPoint startPoint = [BPKGradient startPointForDirection:BPKGradientDirectionBottomLeft];
    CGPoint endPoint = [BPKGradient endPointForDirection:BPKGradientDirectionBottomLeft];

    return [[BPKGradient alloc] initWithColors:@[startColor, endColor] startPoint:startPoint endPoint:endPoint];
}

- (UIColor *)spinnerPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)buttonLinkContentColor {
    return BPKColor.blue900;
}

- (UIColor *)buttonFeaturedContentColor {
    return BPKColor.gray200;
}

- (UIColor *)buttonFeaturedGradientStartColor {
    return BPKColor.blue900;
}

- (UIColor *)buttonFeaturedGradientEndColor {
    return BPKColor.blue700;
}

- (UIColor *)buttonDestructiveContentColor {
    return BPKColor.red700;
}

- (UIColor *)buttonDestructiveBackgroundColor {
    return BPKColor.gray100;
}

- (UIColor *)buttonDestructiveBorderColor {
    return BPKColor.red900;
}

- (UIColor *)buttonPrimaryContentColor {
    return BPKColor.blue700;
}

- (UIColor *)buttonPrimaryGradientStartColor {
    return BPKColor.white;
}

- (UIColor *)buttonPrimaryGradientEndColor {
    return BPKColor.gray200;
}

- (UIColor *)buttonSecondaryContentColor {
    return BPKColor.blue700;
}

- (UIColor *)buttonSecondaryBackgroundColor {
    return BPKColor.gray100;
}

- (UIColor *)buttonSecondaryBorderColor {
    return BPKColor.blue900;
}

- (NSNumber *)buttonCornerRadius {
    return @4.0;
}

- (UIColor *)calendarDateSelectedContentColor {
    return self.primaryColor;
}

- (UIColor *)calendarDateSelectedBackgroundColor {
    return BPKColor.gray100;
}

- (Class)themeContainerClass {
    return [BPKSilverThemeContainer class];
}

@end
