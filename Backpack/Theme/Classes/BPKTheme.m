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
#import <Backpack/Label.h>
#import <Backpack/Spinner.h>
#import <Backpack/Switch.h>
#import <Backpack/TextView.h>
#import <Backpack/Theme.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *BPKThemeDidChangeNotification = @"BPKThemeDidChangeNotification";

@implementation BPKTheme

+ (UIColor *)primaryColorFor:(UIView *)view {
    BPKThemeContainer *themeContainer = view.themeContainer;
    if (themeContainer != nil) {
        return themeContainer.themeDefinition.primaryColor;
    }

    return BPKColor.blue500;
}

+ (NSString *)fontNameFor:(UIView *)view {
    if (view == nil) {
        return nil;
    }

    Boolean viewIsLabel = [view isKindOfClass:[BPKLabel class]];
    Boolean viewIsTextView = [view isKindOfClass:[BPKTextView class]];
    Boolean viewIsButton = [view isKindOfClass:[BPKButton class]];

    NSAssert(viewIsLabel || viewIsTextView || viewIsButton,
             @"fontNameFor: can only be used with a view that is an instance of BPKLabel, BPKTextView or BPKButton");

    if (viewIsLabel) {
        BPKLabel *label = (BPKLabel *)view;
        return label.fontName;
    }
    if (viewIsTextView) {
        BPKTextView *textView = (BPKTextView *)view;
        return textView.fontName;
    }
    if (viewIsButton) {
        BPKButton *button = (BPKButton *)view;
        return button.fontName;
    }

    return nil;
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

    BPKLabel *labelViewAppearance = [BPKLabel appearanceWhenContainedInInstancesOfClasses:@[class]];
    labelViewAppearance.fontName = theme.fontName;

    BPKTextView *textViewAppearance = [BPKTextView appearanceWhenContainedInInstancesOfClasses:@[class]];
    textViewAppearance.fontName = theme.fontName;

    BPKButton *buttonViewAppearance = [BPKButton appearanceWhenContainedInInstancesOfClasses:@[class]];
    buttonViewAppearance.fontName = theme.fontName;
}

@end

NS_ASSUME_NONNULL_END
