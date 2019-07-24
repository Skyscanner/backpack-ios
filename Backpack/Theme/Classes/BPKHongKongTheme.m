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

#import "BPKHongKongTheme.h"
#import "BPKHongKongThemeContainer.h"

#import <Backpack/Button.h>
#import <Backpack/Chip.h>
#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Gradient.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

@interface BPKHongKongTheme ()
@property(nonatomic, readonly, strong) UIColor *secondaryColor;
@end

@implementation BPKHongKongTheme

- (NSString *)themeName {
    return @"Hong Kong";
}

- (BPKFontMapping *)fontMapping {
    return [[BPKFontMapping alloc] initWithFamily:@"SnellRoundhand"
                                  regularFontFace:@"SnellRoundhand"
                                 semiboldFontFace:@"SnellRoundhand-Bold"
                                    heavyFontFace:@"SnellRoundhand-Black"];
}

- (UIColor *)chipPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)switchPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)primaryColor {
    return [UIColor colorWithRed:76.0f / 255.0f green:76.0f / 255.0f blue:76.0f / 255.0f alpha:1.0f];
}

- (UIColor *)gray50 {
    return [UIColor colorWithRed:241.0f / 255.0f green:243.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f];
}

- (UIColor *)gray100 {
    return [UIColor colorWithRed:220.0f / 255.0f green:223.0f / 255.0f blue:224.0f / 255.0f alpha:1.0f];
}

- (UIColor *)gray300 {
    return [UIColor colorWithRed:179.0f / 255.0f green:186.0f / 255.0f blue:189.0f / 255.0f alpha:1.0f];
}

- (UIColor *)gray500 {
    return [UIColor colorWithRed:101.0f / 255.0f green:113.0f / 255.0f blue:118.0f / 255.0f alpha:1.0f];
}

- (UIColor *)gray700 {
    return [UIColor colorWithRed:75.0f / 255.0f green:84.0f / 255.0f blue:88.0f / 255.0f alpha:1.0f];
}

- (UIColor *)gray900 {
    return [UIColor colorWithRed:11.0f / 255.0f green:26.0f / 255.0f blue:34.0f / 255.0f alpha:1.0f];
}

- (BPKGradient *)primaryGradient {
    UIColor *startColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1];
    UIColor *endColor = [UIColor colorWithRed:0.235 green:0.235 blue:0.235 alpha:1];
    CGPoint startPoint = [BPKGradient startPointForDirection:BPKGradientDirectionUp];
    CGPoint endPoint = [BPKGradient endPointForDirection:BPKGradientDirectionUp];

    return [[BPKGradient alloc] initWithColors:@[startColor, endColor] startPoint:startPoint endPoint:endPoint];
}

- (UIColor *)secondaryColor {
    return [UIColor colorWithRed:0 green:0.392 blue:0.388 alpha:1];
}

- (UIColor *)spinnerPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)buttonLinkContentColor {
    return self.primaryColor;
}

- (UIColor *)buttonPrimaryContentColor {
    return BPKColor.white;
}

- (UIColor *)buttonPrimaryGradientStartColor {
    return [UIColor colorWithRed:126.0f / 255.0f green:126.0f / 255.0f blue:126.0f / 255.0f alpha:1.0f];
}

- (UIColor *)buttonPrimaryGradientEndColor {
    return [UIColor colorWithRed:70.0f / 255.0f green:70.0f / 255.0f blue:70.0f / 255.0f alpha:1.0f];
}

- (UIColor *)buttonFeaturedContentColor {
    return BPKColor.white;
}

- (UIColor *)buttonFeaturedGradientStartColor {
    return [UIColor colorWithRed:0.003921569 green:0.392156863 blue:0.392156863 alpha:1];
}

- (UIColor *)buttonFeaturedGradientEndColor {
    return [UIColor colorWithRed:0.023529412 green:0.235294118 blue:0.235294118 alpha:1];
}

- (UIColor *)buttonSecondaryContentColor {
    return self.secondaryColor;
}

- (UIColor *)buttonSecondaryBackgroundColor {
    return BPKColor.white;
}

- (UIColor *)buttonSecondaryBorderColor {
    return BPKColor.gray100;
}

- (UIColor *)buttonDestructiveContentColor {
    return [UIColor colorWithRed:0.023529412 green:0.235294118 blue:0.235294118 alpha:1];
}

- (UIColor *)buttonDestructiveBackgroundColor {
    return BPKColor.white;
}

- (UIColor *)buttonDestructiveBorderColor {
    return BPKColor.gray100;
}

- (NSNumber *)buttonCornerRadius {
    return nil;
}

- (UIColor *)calendarDateSelectedContentColor {
    return [UIColor colorWithRed:255.0f / 255.0f green:163.0f / 255.0f blue:203.0f / 255.0f alpha:1.0f];
}

- (UIColor *)calendarDateSelectedBackgroundColor {
    return self.primaryColor;
}

- (Class)themeContainerClass {
    return [BPKHongKongThemeContainer class];
}

- (UIColor *)starFilledColor {
    return BPKColor.yellow500;
}

- (UIColor *)horiontalNavigationSelectedColor {
    return self.primaryColor;
}

@end
