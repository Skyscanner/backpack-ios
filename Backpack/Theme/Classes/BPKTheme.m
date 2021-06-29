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

#import "BPKTheme.h"

#import <Backpack/Backpack.h>
#import <Backpack/Backpack-Swift.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *BPKThemeDidChangeNotification = @"BPKThemeDidChangeNotification";

@implementation BPKTheme

typedef NS_ENUM(NSInteger, BPKGrayColor) { BPKGrayColor50, BPKGrayColor100, BPKGrayColor300, BPKGrayColor500, BPKGrayColor700, BPKGrayColor900 };

+ (UIColor *)primaryColorFor:(UIView *)view {
    BPKThemeContainer *themeContainer = view.themeContainer;

    if (themeContainer != nil) {
        return themeContainer.themeDefinition.primaryColor;
    }

    return BPKColor.skyBlue;
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

    BPKPrimaryGradientView *primaryGradientViewAppearance = [BPKPrimaryGradientView appearanceWhenContainedInInstancesOfClasses:@[class]];
    primaryGradientViewAppearance.gradient = theme.primaryGradient;

    BPKTappableLinkLabel *tappableLinkLabelViewAppearance = [BPKTappableLinkLabel appearanceWhenContainedInInstancesOfClasses:@[class]];
    tappableLinkLabelViewAppearance.linkColor = theme.linkPrimaryColor;

    BPKStar *starAppearance = [BPKStar appearanceWhenContainedInInstancesOfClasses:@[class]];
    starAppearance.starFilledColor = theme.starFilledColor;

    BPKProgressBar *progressBarAppearance = [BPKProgressBar appearanceWhenContainedInInstancesOfClasses:@[class]];
    progressBarAppearance.fillColor = theme.progressBarPrimaryColor;

    BPKRating *ratingAppearance = [BPKRating appearanceWhenContainedInInstancesOfClasses:@[class]];
    ratingAppearance.lowRatingColor = theme.ratingLowColor;
    ratingAppearance.mediumRatingColor = theme.ratingMediumColor;
    ratingAppearance.highRatingColor = theme.ratingHighColor;

    BPKHorizontalNavigationObjc *horizontalNavAppearance = [BPKHorizontalNavigationObjc appearanceWhenContainedInInstancesOfClasses:@[class]];
    horizontalNavAppearance.selectedColor = theme.horiontalNavigationSelectedColor;
}

@end

NS_ASSUME_NONNULL_END
