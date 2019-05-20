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

#import "BPKTheme.h"
#import "BPKDohaThemeContainer.h"
#import "BPKThemeContainer.h"
#import "BPKThemeContainerController.h"
#import "UIView+BPKThemeContainer.h"

#import <Backpack/Button.h>
#import <Backpack/Calendar.h>
#import <Backpack/Chip.h>
#import <Backpack/Color.h>
#import <Backpack/Gradient.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *BPKThemeDidChangeNotification = @"BPKThemeDidChangeNotification";

@implementation BPKTheme

typedef NS_ENUM(NSInteger, GrayColor) {
    GrayColor50,
    GrayColor100,
    GrayColor300,
    GrayColor500,
    GrayColor700,
    GrayColor900
};

+ (UIColor *)primaryColorFor:(UIView *)view {
    BPKThemeContainer *themeContainer = view.themeContainer;

    if (themeContainer != nil) {
        return themeContainer.themeDefinition.primaryColor;
    }

    return BPKColor.blue500;
}

+ (UIColor *)grayColor:(GrayColor)gray for:(UIView *)view {
    BPKThemeContainer *themeContainer = view.themeContainer;

    if (themeContainer != nil) {
        switch (gray) {
        case GrayColor50:
            return themeContainer.themeDefinition.gray50;
            break;
        case GrayColor100:
            return themeContainer.themeDefinition.gray100;
            break;
        case GrayColor300:
            return themeContainer.themeDefinition.gray300;
            break;
        case GrayColor500:
            return themeContainer.themeDefinition.gray500;
            break;
        case GrayColor700:
            return themeContainer.themeDefinition.gray700;
            break;
        case GrayColor900:
            return themeContainer.themeDefinition.gray900;
            break;
        default:
            NSAssert(false, @"Themed gray values must be a valid GrayColor");
            break;
        }
    }

    switch (gray) {
    case GrayColor50:
        return BPKColor.gray50;
        break;
    case GrayColor100:
        return BPKColor.gray100;
        break;
    case GrayColor300:
        return BPKColor.gray300;
        break;
    case GrayColor500:
        return BPKColor.gray500;
        break;
    case GrayColor700:
        return BPKColor.gray700;
        break;
    case GrayColor900:
        return BPKColor.gray900;
        break;
    default:
        NSAssert(false, @"Themed gray values must be a valid GrayColor");
        break;
    }

    return BPKColor.gray500;
}

+ (UIColor *)gray50ColorFor:(UIView *)view {
    return [self grayColor:GrayColor50 for:view];
}

+ (UIColor *)gray100ColorFor:(UIView *)view {
    return [self grayColor:GrayColor100 for:view];
}

+ (UIColor *)gray300ColorFor:(UIView *)view {
    return [self grayColor:GrayColor300 for:view];
}

+ (UIColor *)gray500ColorFor:(UIView *)view {
    return [self grayColor:GrayColor500 for:view];
}

+ (UIColor *)gray700ColorFor:(UIView *)view {
    return [self grayColor:GrayColor700 for:view];
}

+ (UIColor *)gray900ColorFor:(UIView *)view {
    return [self grayColor:GrayColor900 for:view];
}

+ (NSString *)didChangeNotification {
    return BPKThemeDidChangeNotification;
}

+ (void)applyTheme:(id<BPKThemeDefinition>)theme {
    [self applyTheme:theme withContainer:theme.themeContainerClass];
}

+ (UIView *)containerFor:(id<BPKThemeDefinition>)theme {
    return [[theme.themeContainerClass alloc] initWithFrame:CGRectZero];
}

+ (void)applyTheme:(id<BPKThemeDefinition>)theme withContainer:(Class)class {
    [[BPKSwitch appearanceWhenContainedInInstancesOfClasses:@[class]] setPrimaryColor:theme.switchPrimaryColor];
    [[BPKChip appearanceWhenContainedInInstancesOfClasses:@[class]] setPrimaryColor:theme.chipPrimaryColor];
    [[BPKSpinner appearanceWhenContainedInInstancesOfClasses:@[class]] setPrimaryColor:theme.spinnerPrimaryColor];

    BPKButton *buttonAppearance = [BPKButton appearanceWhenContainedInInstancesOfClasses:@[class]];
    buttonAppearance.linkContentColor = theme.buttonLinkContentColor;
    buttonAppearance.primaryContentColor = theme.buttonPrimaryContentColor;
    buttonAppearance.primaryGradientStartColor = theme.buttonPrimaryGradientStartColor;
    buttonAppearance.primaryGradientEndColor = theme.buttonPrimaryGradientEndColor;
    buttonAppearance.featuredContentColor = theme.buttonFeaturedContentColor;
    buttonAppearance.featuredGradientStartColor = theme.buttonFeaturedGradientStartColor;
    buttonAppearance.featuredGradientEndColor = theme.buttonFeaturedGradientEndColor;
    buttonAppearance.secondaryContentColor = theme.buttonSecondaryContentColor;
    buttonAppearance.secondaryBackgroundColor = theme.buttonSecondaryBackgroundColor;
    buttonAppearance.secondaryBorderColor = theme.buttonSecondaryBorderColor;
    buttonAppearance.destructiveContentColor = theme.buttonDestructiveContentColor;
    buttonAppearance.destructiveBackgroundColor = theme.buttonDestructiveBackgroundColor;
    buttonAppearance.destructiveBorderColor = theme.buttonDestructiveBorderColor;
    buttonAppearance.cornerRadius = theme.buttonCornerRadius;

    BPKCalendar *calendarAppearance = [BPKCalendar appearanceWhenContainedInInstancesOfClasses:@[class]];
    calendarAppearance.dateSelectedContentColor = theme.calendarDateSelectedContentColor;
    calendarAppearance.dateSelectedBackgroundColor = theme.calendarDateSelectedBackgroundColor;

    BPKPrimaryGradientView *primaryGradientViewAppearance =
        [BPKPrimaryGradientView appearanceWhenContainedInInstancesOfClasses:@[class]];
    primaryGradientViewAppearance.gradient = theme.primaryGradient;
}

@end

NS_ASSUME_NONNULL_END
