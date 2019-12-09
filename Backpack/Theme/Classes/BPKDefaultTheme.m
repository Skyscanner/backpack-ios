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

#import "BPKDefaultTheme.h"

#import <Backpack/Button.h>
#import <Backpack/Chip.h>
#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Gradient.h>
#import <Backpack/Radii.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

#import "BPKDefaultThemeContainer.h"

@interface BPKDefaultTheme ()
@property(nonatomic, readonly, strong) UIColor *skyBlue300;
@property(nonatomic, readonly, strong) UIColor *skyBlue500;
@property(nonatomic, readonly, strong) UIColor *skyBlue700;
@property(nonatomic, readonly, strong) UIColor *skyBlue900;
@property(nonatomic, readonly, strong) UIColor *montverde500;
@property(nonatomic, readonly, strong) UIColor *montverde700;
@property(nonatomic, readonly, strong) UIColor *montverde900;
@property(nonatomic, readonly, strong) UIColor *abisko300;
@property(nonatomic, readonly, strong) UIColor *abisko500;
@property(nonatomic, readonly, strong) UIColor *abisko700;
@property(nonatomic, readonly, strong) UIColor *abisko900;
@property(nonatomic, readonly, strong) UIColor *kolkata500;
@property(nonatomic, readonly, strong) UIColor *red500;
@property(nonatomic, readonly, strong) UIColor *white;
@end

@implementation BPKDefaultTheme

NSString *const DefaultThemeName = @"Default";

- (instancetype)init {
    self = [super init];
    return self;
}

- (NSString *)themeName {
    return DefaultThemeName;
}

/**
 * SkyBlue300 colour, #3C81E5
 */
- (UIColor *)skyBlue300 {
    return [UIColor colorWithRed:0.24f green:0.51f blue:0.9f alpha:1.0f];
}

/**
 * SkyBlue500 colour, #0770E3
 */
- (UIColor *)skyBlue500 {
    return [UIColor colorWithRed:0.03f green:0.44f blue:0.89f alpha:1.0f];
}

/**
 * SkyBlue700 colour, #084EB2
 */
- (UIColor *)skyBlue700 {
    return [UIColor colorWithRed:0.03f green:0.31f blue:0.7f alpha:1.0f];
}

/**
 * SkyBlue900 colour, #042759
 */
- (UIColor *)skyBlue900 {
    return [UIColor colorWithRed:0.02f green:0.15f blue:0.35f alpha:1.0f];
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

/**
 * Red500 colour, Panjin500
 */
- (UIColor *)systemRed {
    return [self panjin500];
}

/**
 * Green500 colour, Monteverde500
 */
- (UIColor *)systemGreen {
    return [self montverde500];
}

/**
 * Panjin500, #d1435b
 */
- (UIColor *)panjin500 {
    return [UIColor colorWithRed:209.0f / 255.0f green:67.0f / 255.0f blue:91.0f / 255.0f alpha:1.0f];
}

/**
 * Monteverde500, #00A698
 */
- (UIColor *)montverde500 {
    return [UIColor colorWithRed:0.0f green:0.65f blue:0.6f alpha:1];
}

/**
 * Monteverde700, #006D6B
 */
- (UIColor *)montverde700 {
    return [UIColor colorWithRed:0.0f green:0.43f blue:0.42f alpha:1];
}

/**
 * Monteverde900, #004D4B
 */
- (UIColor *)montverde900 {
    return [UIColor colorWithRed:0.0f green:0.3f blue:0.29f alpha:1];
}

/**
 * Abisko300, #4D2BAB
 */
- (UIColor *)abisko300 {
    return [UIColor colorWithRed:0.3f green:0.17f blue:0.67f alpha:1];
}

/**
 * Abisko500, #5A489B
 */
- (UIColor *)abisko500 {
    return [UIColor colorWithRed:0.35f green:0.28f blue:0.61f alpha:1];
}

/**
 * Abisko700, #47397A
 */
- (UIColor *)abisko700 {
    return [UIColor colorWithRed:0.28f green:0.22f blue:0.48f alpha:1];
}

/**
 * Abisko900, #241D3F
 */
- (UIColor *)abisko900 {
    return [UIColor colorWithRed:0.14f green:0.11f blue:0.25f alpha:1];
}

/**
 * Kolkata500, #FF9400
 */
- (UIColor *)kolkata500 {
    return [UIColor colorWithRed:1.0f green:0.58f blue:0.0f alpha:1];
}

/**
 * System red, #EF4D22
 */
- (UIColor *)red500 {
    return [UIColor colorWithRed:0.94f green:0.30f blue:0.13f alpha:1];
}

/**
 * White, #FFFFFF
 */
- (UIColor *)white {
    return BPKColor.white;
}

- (UIColor *)primaryColor {
    return self.skyBlue500;
}

- (UIColor *_Nullable)progressBarPrimaryColor {
    return nil;
}

- (UIColor *_Nullable)linkPrimaryColor {
    return nil;
}

- (BPKGradient *)primaryGradient {
    UIColor *startColor = self.primaryColor;
    UIColor *endColor = self.primaryColor;
    CGPoint startPoint = [BPKGradient startPointForDirection:BPKGradientDirectionUp];
    CGPoint endPoint = [BPKGradient endPointForDirection:BPKGradientDirectionUp];

    return [[BPKGradient alloc] initWithColors:@[startColor, endColor] startPoint:startPoint endPoint:endPoint];
}

- (UIColor *)chipPrimaryColor {
    return nil;
}

- (UIColor *)switchPrimaryColor {
    return nil;
}

- (UIColor *)spinnerPrimaryColor {
    return nil;
}

- (UIColor *)buttonLinkContentColor {
    return nil;
}

- (UIColor *)buttonPrimaryContentColor {
    return nil;
}

- (UIColor *)buttonPrimaryGradientStartColor {
    return nil;
}

- (UIColor *)buttonPrimaryGradientEndColor {
    return nil;
}

- (UIColor *)buttonFeaturedContentColor {
    return nil;
}

- (UIColor *)buttonFeaturedGradientStartColor {
    return nil;
}

- (UIColor *)buttonFeaturedGradientEndColor {
    return nil;
}

- (UIColor *)buttonSecondaryContentColor {
    return nil;
}

- (UIColor *)buttonSecondaryBackgroundColor {
    return nil;
}

- (UIColor *)buttonSecondaryBorderColor {
    return nil;
}

- (UIColor *)buttonDestructiveContentColor {
    return nil;
}

- (UIColor *)buttonDestructiveBackgroundColor {
    return nil;
}

- (UIColor *)buttonDestructiveBorderColor {
    return nil;
}

- (NSNumber *)buttonCornerRadius {
    return @(BPKBorderRadiusSm);
}

- (UIColor *)starFilledColor {
    return nil;
}

- (UIColor *)horiontalNavigationSelectedColor {
    return nil;
}

- (UIColor *)calendarDateSelectedContentColor {
    return nil;
}

- (UIColor *)calendarDateSelectedBackgroundColor {
    return nil;
}

- (Class)themeContainerClass {
    return [BPKDefaultThemeContainer class];
}

- (UIColor *)ratingLowColor {
    return nil;
}

- (UIColor *)ratingMediumColor {
    return nil;
}

- (UIColor *)ratingHighColor {
    return nil;
}

@end
