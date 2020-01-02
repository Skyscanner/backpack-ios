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

#import "BPKTheme.h"

#import <Backpack/Button.h>
#import <Backpack/Calendar.h>
#import <Backpack/Chip.h>
#import <Backpack/Color.h>
#import <Backpack/Gradient.h>
#import <Backpack/HorizontalNavigation.h>
#import <Backpack/Label.h>
#import <Backpack/ProgressBar.h>
#import <Backpack/Rating.h>
#import <Backpack/Spinner.h>
#import <Backpack/StarRating.h>
#import <Backpack/Switch.h>
#import <Backpack/TappableLinkLabel.h>
#import <Backpack/TextField.h>
#import <Backpack/TextView.h>

#import "BPKDohaThemeContainer.h"
#import "BPKThemeContainer.h"
#import "BPKThemeContainerController.h"
#import "UIView+BPKThemeContainer.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *BPKThemeDidChangeNotification = @"BPKThemeDidChangeNotification";

@implementation BPKTheme

typedef NS_ENUM(NSInteger, BPKGrayColor) {
    BPKGrayColor50,
    BPKGrayColor100,
    BPKGrayColor300,
    BPKGrayColor500,
    BPKGrayColor700,
    BPKGrayColor900
};

+ (UIColor *)primaryColorFor:(UIView *)view {
    BPKThemeContainer *themeContainer = view.themeContainer;

    if (themeContainer != nil) {
        return themeContainer.themeDefinition.primaryColor;
    }

    return BPKColor.skyBlue;
}

+ (UIColor *)grayColor:(BPKGrayColor)gray for:(UIView *)view {
    NSAssert(NO,
             @"grayXColorFor: has been deprecated. Please add UI_APPEARANCE_ATTRIBUTES to theme custom components.");
    BPKThemeContainer *themeContainer = view.themeContainer;

    if (themeContainer != nil) {
        switch (gray) {
        case BPKGrayColor50:
            return themeContainer.themeDefinition.gray50;
        case BPKGrayColor100:
            return themeContainer.themeDefinition.gray100;
        case BPKGrayColor300:
            return themeContainer.themeDefinition.gray300;
        case BPKGrayColor500:
            return themeContainer.themeDefinition.gray500;
        case BPKGrayColor700:
            return themeContainer.themeDefinition.gray700;
        case BPKGrayColor900:
            return themeContainer.themeDefinition.gray900;
        default:
            NSAssert(false, @"Themed gray values must be a valid BPKGrayColor");
            break;
        }
    }

    switch (gray) {
    case BPKGrayColor50:
        return BPKColor.skyGrayTint07;
    case BPKGrayColor100:
        return BPKColor.skyGrayTint06;
    case BPKGrayColor300:
        return BPKColor.skyGrayTint04;
    case BPKGrayColor500:
        return BPKColor.skyGrayTint02;
    case BPKGrayColor700:
        return BPKColor.skyGrayTint01;
    case BPKGrayColor900:
        return BPKColor.skyGray;
    default:
        NSAssert(false, @"Themed gray values must be a valid BPKGrayColor");
        break;
    }

    return BPKColor.skyGrayTint02;
}

+ (UIColor *)skyGrayTint07ColorFor:(UIView *)view {
    return [self grayColor:BPKGrayColor50 for:view];
}

+ (UIColor *)skyGrayTint06ColorFor:(UIView *)view {
    return [self grayColor:BPKGrayColor100 for:view];
}

+ (UIColor *)skyGrayTint04ColorFor:(UIView *)view {
    return [self grayColor:BPKGrayColor300 for:view];
}

+ (UIColor *)skyGrayTint02ColorFor:(UIView *)view {
    return [self grayColor:BPKGrayColor500 for:view];
}

+ (UIColor *)skyGrayTint01ColorFor:(UIView *)view {
    return [self grayColor:BPKGrayColor700 for:view];
}

+ (UIColor *)skyGrayColorFor:(UIView *)view {
    return [self grayColor:BPKGrayColor900 for:view];
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

    BPKCalendar *calendarAppearance = [BPKCalendar appearanceWhenContainedInInstancesOfClasses:@[class]];
    calendarAppearance.dateSelectedContentColor = theme.calendarDateSelectedContentColor;
    calendarAppearance.dateSelectedBackgroundColor = theme.calendarDateSelectedBackgroundColor;

    BPKPrimaryGradientView *primaryGradientViewAppearance =
        [BPKPrimaryGradientView appearanceWhenContainedInInstancesOfClasses:@[class]];
    primaryGradientViewAppearance.gradient = theme.primaryGradient;

    BPKTappableLinkLabel *tappableLinkLabelViewAppearance =
        [BPKTappableLinkLabel appearanceWhenContainedInInstancesOfClasses:@[class]];
    tappableLinkLabelViewAppearance.linkColor = theme.linkPrimaryColor;

    BPKStar *starAppearance = [BPKStar appearanceWhenContainedInInstancesOfClasses:@[class]];
    starAppearance.starFilledColor = theme.starFilledColor;

    BPKHorizontalNavigation *horizontalNavigationAppearance =
        [BPKHorizontalNavigation appearanceWhenContainedInInstancesOfClasses:@[class]];
    horizontalNavigationAppearance.selectedColor = theme.horiontalNavigationSelectedColor;

    BPKProgressBar *progressBarAppearance = [BPKProgressBar appearanceWhenContainedInInstancesOfClasses:@[class]];
    progressBarAppearance.fillColor = theme.progressBarPrimaryColor;

    BPKRating *ratingAppearance = [BPKRating appearanceWhenContainedInInstancesOfClasses:@[class]];
    ratingAppearance.lowRatingColor = theme.ratingLowColor;
    ratingAppearance.mediumRatingColor = theme.ratingMediumColor;
    ratingAppearance.highRatingColor = theme.ratingHighColor;
}

@end

NS_ASSUME_NONNULL_END
