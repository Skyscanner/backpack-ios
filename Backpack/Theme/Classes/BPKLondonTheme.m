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

#import "BPKLondonTheme.h"

#import <Backpack/Button.h>
#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Gradient.h>
#import <Backpack/Radii.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

#import "BPKLondonThemeContainer.h"

@implementation BPKLondonTheme

- (NSString *)themeName {
    return @"London";
}

- (UIColor *)chipPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)switchPrimaryColor {
    return self.primaryColor;
}

- (UIColor *)primaryColor {
    return [UIColor colorWithRed:237.0f / 255.0f green:27.0f / 255.0f blue:40.0f / 255.0f alpha:1.0f];
}

- (UIColor *_Nullable)progressBarPrimaryColor {
    return self.primaryColor;
}

- (UIColor *_Nullable)linkPrimaryColor {
    return self.primaryColor;
}

/**
 * Gray50 colour, #F1F2F8
 */
- (UIColor *)gray50 {
    return BPKColor.skyGrayTint07;
}

/**
 * Gray100 colour, #DDDDE5
 */
- (UIColor *)gray100 {
    return BPKColor.skyGrayTint06;
}

/**
 * Gray300 colour, #B2B2BF
 */
- (UIColor *)gray300 {
    return BPKColor.skyGrayTint04;
}

/**
 * Gray500 colour, #68697F
 */
- (UIColor *)gray500 {
    return BPKColor.skyGrayTint02;
}

/**
 * Gray700, #444560
 */
- (UIColor *)gray700 {
    return BPKColor.skyGrayTint01;
}

/**
 * Gray900 colour, #111236
 */
- (UIColor *)gray900 {
    return BPKColor.skyGray;
}

- (UIColor *)systemGreen {
    return [UIColor colorWithRed:0.0f / 255.0f green:255.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f];
}

- (UIColor *)systemRed {
    return [UIColor colorWithRed:255.0f / 255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f];
}

- (BPKGradient *)primaryGradient {
    UIColor *startColor = [UIColor colorWithRed:0.00392 green:0.227 blue:0.463 alpha:1];
    UIColor *endColor = [UIColor colorWithRed:0 green:0.184 blue:0.38 alpha:1];
    CGPoint startPoint = [BPKGradient startPointForDirection:BPKGradientDirectionBottomRight];
    CGPoint endPoint = [BPKGradient endPointForDirection:BPKGradientDirectionBottomRight];

    return [[BPKGradient alloc] initWithColors:@[startColor, endColor] startPoint:startPoint endPoint:endPoint];
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
    return [UIColor colorWithRed:0.00392 green:0.227 blue:0.463 alpha:1];
}

- (UIColor *)buttonPrimaryGradientEndColor {
    return [UIColor colorWithRed:0 green:0.184 blue:0.38 alpha:1];
}

- (UIColor *)buttonFeaturedContentColor {
    return BPKColor.white;
}

- (UIColor *)buttonFeaturedGradientStartColor {
    return [UIColor colorWithRed:0.823529412 green:0.333333333 blue:0.333333333 alpha:1];
}

- (UIColor *)buttonFeaturedGradientEndColor {
    return [UIColor colorWithRed:0.694117647 green:0.074509804 blue:0.11372549 alpha:1];
}

- (UIColor *)buttonSecondaryContentColor {
    return self.primaryColor;
}

- (UIColor *)buttonSecondaryBackgroundColor {
    return BPKColor.white;
}

- (UIColor *)buttonSecondaryBorderColor {
    return self.gray100;
}

- (UIColor *)buttonDestructiveContentColor {
    return [UIColor colorWithRed:0.694117647 green:0.074509804 blue:0.11372549 alpha:1];
}

- (UIColor *)buttonDestructiveBackgroundColor {
    return BPKColor.white;
}

- (UIColor *)buttonDestructiveBorderColor {
    return self.gray100;
}

- (NSNumber *)buttonCornerRadius {
    return @(BPKCornerRadiusXs);
}

- (UIColor *)calendarDateSelectedContentColor {
    return BPKColor.white;
}

- (UIColor *)calendarDateSelectedBackgroundColor {
    return self.primaryColor;
}

- (Class)themeContainerClass {
    return [BPKLondonThemeContainer class];
}

- (UIColor *)starFilledColor {
    return BPKColor.panjin;
}

- (UIColor *)horiontalNavigationSelectedColor {
    return self.primaryColor;
}

- (UIColor *)ratingLowColor {
    return UIColor.redColor;
}

- (UIColor *)ratingMediumColor {
    return UIColor.yellowColor;
}

- (UIColor *)ratingHighColor {
    return UIColor.greenColor;
}

@end
