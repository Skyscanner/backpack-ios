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

#import "BPKButtonAppearanceSet.h"
#import "BPKButton.h"
#import "BPKButtonAppearance.h"
#import <Backpack/Color.h>

@interface BPKColor (BPKButtonAppearanceSetPrivate)
+ (UIColor *)dynamicColorWithLightVariant:(UIColor *)lightVariant darkVariant:(UIColor *)darkVariant;
@end

static inline UIColor *BPKButtonColor(CGFloat lr, CGFloat lg, CGFloat lb, CGFloat la, CGFloat dr, CGFloat dg, CGFloat db, CGFloat da) {
    return [BPKColor dynamicColorWithLightVariant:[UIColor colorWithRed:lr green:lg blue:lb alpha:la]
                                      darkVariant:[UIColor colorWithRed:dr green:dg blue:db alpha:da]];
}

static BPKButtonAppearance *BPKAppearance(UIColor *background, UIColor *foreground) {
    BPKButtonAppearance *appearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil
                                                                    gradientStartColor:background
                                                                      gradientEndColor:background
                                                                       foregroundColor:foreground];
    return appearance;
}

// This file clones a subset of BPKInternalColors.swift definitions so Objective-C
// code (and SPM builds) can resolve button colors without cross-language
// initialisation. BPKButton is maintenance-only; new work should use the SwiftUI
// counterpart.

static inline UIColor *BPKButtonDisabledBackgroundColor(void) { return BPKButtonColor(0.878, 0.894, 0.914, 1.0, 0.043, 0.071, 0.114, 1.0); }

static inline UIColor *BPKButtonPrimaryNormalBackgroundColor(void) { return BPKButtonColor(0.020, 0.125, 0.235, 1.0, 0.008, 0.302, 0.686, 1.0); }

static inline UIColor *BPKButtonPrimaryPressedBackgroundColor(void) { return BPKButtonColor(0.082, 0.275, 0.475, 1.0, 0.020, 0.255, 0.518, 1.0); }

static inline UIColor *BPKButtonSecondaryNormalBackgroundColor(void) { return BPKButtonColor(0.878, 0.894, 0.914, 1.0, 0.141, 0.200, 0.275, 1.0); }

static inline UIColor *BPKButtonSecondaryPressedBackgroundColor(void) { return BPKButtonColor(0.757, 0.780, 0.812, 1.0, 0.004, 0.035, 0.075, 1.0); }

static inline UIColor *BPKButtonFeaturedNormalBackgroundColor(void) { return BPKButtonColor(0.000, 0.384, 0.890, 1.0, 0.518, 0.914, 1.000, 1.0); }

static inline UIColor *BPKButtonFeaturedPressedBackgroundColor(void) { return BPKButtonColor(0.008, 0.302, 0.686, 1.0, 0.820, 0.969, 1.000, 1.0); }

static inline UIColor *BPKButtonDestructiveNormalBackgroundColor(void) { return BPKButtonColor(0.878, 0.894, 0.914, 1.0, 0.141, 0.200, 0.275, 1.0); }

static inline UIColor *BPKButtonDestructiveNormalForegroundColor(void) { return BPKButtonColor(0.906, 0.031, 0.400, 1.0, 1.000, 0.392, 0.612, 1.0); }

static inline UIColor *BPKButtonDestructivePressedBackgroundColor(void) { return BPKButtonColor(0.906, 0.031, 0.400, 1.0, 1.000, 0.392, 0.612, 1.0); }

static inline UIColor *BPKButtonLinkNormalForegroundColor(void) { return BPKButtonColor(0.000, 0.384, 0.890, 1.0, 0.518, 0.914, 1.000, 1.0); }

static inline UIColor *BPKButtonLinkPressedForegroundColor(void) { return BPKButtonColor(0.008, 0.302, 0.686, 1.0, 0.820, 0.969, 1.000, 1.0); }

static inline UIColor *BPKButtonLinkOnDarkNormalForegroundColor(void) { return BPKButtonColor(1.000, 1.000, 1.000, 1.0, 1.000, 1.000, 1.000, 1.0); }

static inline UIColor *BPKButtonLinkOnDarkPressedForegroundColor(void) {
    return BPKButtonColor(1.000, 1.000, 1.000, 0.5019607843137255, 1.000, 1.000, 1.000, 0.5019607843137255);
}

static inline UIColor *BPKButtonLinkOnDarkDisabledForegroundColor(void) { return BPKButtonColor(1.000, 1.000, 1.000, 0.2, 1.000, 1.000, 1.000, 0.2); }

static inline UIColor *BPKButtonPrimaryOnDarkNormalBackgroundColor(void) {
    return BPKButtonColor(1.000, 1.000, 1.000, 1.0, 1.000, 1.000, 1.000, 1.0);
}

static inline UIColor *BPKButtonPrimaryOnDarkPressedBackgroundColor(void) {
    return BPKButtonColor(0.757, 0.780, 0.812, 1.0, 0.757, 0.780, 0.812, 1.0);
}

static inline UIColor *BPKButtonPrimaryOnDarkDisabledBackgroundColor(void) {
    return BPKButtonColor(0.878, 0.894, 0.914, 1.0, 0.043, 0.071, 0.114, 1.0);
}

static inline UIColor *BPKButtonPrimaryOnDarkDisabledForegroundColor(void) {
    return BPKButtonColor(0.000, 0.000, 0.000, 0.2, 1.000, 1.000, 1.000, 0.2);
}

static inline UIColor *BPKButtonPrimaryOnLightNormalBackgroundColor(void) {
    return BPKButtonColor(0.000, 0.384, 0.890, 1.0, 0.518, 0.914, 1.000, 1.0);
}

static inline UIColor *BPKButtonPrimaryOnLightPressedBackgroundColor(void) {
    return BPKButtonColor(0.008, 0.302, 0.686, 1.0, 0.820, 0.969, 1.000, 1.0);
}

static inline UIColor *BPKButtonPrimaryOnLightDisabledBackgroundColor(void) {
    return BPKButtonColor(0.878, 0.894, 0.914, 1.0, 0.043, 0.071, 0.114, 1.0);
}

static inline UIColor *BPKButtonPrimaryOnLightDisabledForegroundColor(void) {
    return BPKButtonColor(0.141, 0.200, 0.275, 1.0, 0.141, 0.200, 0.275, 1.0);
}

static inline UIColor *BPKButtonSecondaryOnDarkNormalBackgroundColor(void) {
    return BPKButtonColor(0.000, 0.000, 0.000, 1.0, 0.000, 0.000, 0.000, 1.0);
}

static inline UIColor *BPKButtonSecondaryOnDarkPressedBackgroundColor(void) {
    return BPKButtonColor(0.263, 0.286, 0.314, 1.0, 0.263, 0.286, 0.314, 1.0);
}

static inline UIColor *BPKButtonSecondaryOnDarkDisabledBackgroundColor(void) {
    return BPKButtonColor(0.119, 0.129, 0.145, 1.0, 0.119, 0.129, 0.145, 1.0);
}

static inline UIColor *BPKButtonSecondaryOnDarkDisabledForegroundColor(void) {
    return BPKButtonColor(0.392, 0.412, 0.439, 1.0, 0.392, 0.412, 0.439, 1.0);
}

BPKButtonAppearanceSet *BPKButtonAppearanceSetForStyle(BPKButtonStyle style) {
    BPKButtonAppearance *disabledAppearance = BPKAppearance(BPKButtonDisabledBackgroundColor(), BPKColor.textDisabledColor);
    switch (style) {
    case BPKButtonStylePrimary:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonPrimaryNormalBackgroundColor(), BPKColor.textOnDarkColor)
                    loadingAppearance:BPKAppearance(BPKButtonPrimaryPressedBackgroundColor(), BPKColor.textOnDarkColor)
                   disabledAppearance:disabledAppearance
                highlightedAppearance:BPKAppearance(BPKButtonPrimaryPressedBackgroundColor(), BPKColor.textOnDarkColor)];
    case BPKButtonStyleSecondary:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonSecondaryNormalBackgroundColor(), BPKColor.textPrimaryColor)
                    loadingAppearance:BPKAppearance(BPKButtonSecondaryPressedBackgroundColor(), BPKColor.textPrimaryColor)
                   disabledAppearance:disabledAppearance
                highlightedAppearance:BPKAppearance(BPKButtonSecondaryPressedBackgroundColor(), BPKColor.textPrimaryColor)];
    case BPKButtonStyleFeatured:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonFeaturedNormalBackgroundColor(), BPKColor.textPrimaryInverseColor)
                    loadingAppearance:BPKAppearance(BPKButtonFeaturedPressedBackgroundColor(), BPKColor.textPrimaryInverseColor)
                   disabledAppearance:disabledAppearance
                highlightedAppearance:BPKAppearance(BPKButtonFeaturedPressedBackgroundColor(), BPKColor.textPrimaryInverseColor)];
    case BPKButtonStyleDestructive:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonDestructiveNormalBackgroundColor(), BPKButtonDestructiveNormalForegroundColor())
                    loadingAppearance:BPKAppearance(BPKButtonDestructivePressedBackgroundColor(), BPKColor.textPrimaryInverseColor)
                   disabledAppearance:disabledAppearance
                highlightedAppearance:BPKAppearance(BPKButtonDestructivePressedBackgroundColor(), BPKColor.textPrimaryInverseColor)];
    case BPKButtonStyleLink:
        return [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkNormalForegroundColor())
                                                       loadingAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkPressedForegroundColor())
                                                      disabledAppearance:BPKAppearance(UIColor.clearColor, BPKColor.textDisabledColor)
                                                   highlightedAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkPressedForegroundColor())];
    case BPKButtonStyleLinkOnDark:
        return
            [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkOnDarkNormalForegroundColor())
                                                    loadingAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkOnDarkPressedForegroundColor())
                                                   disabledAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkOnDarkDisabledForegroundColor())
                                                highlightedAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkOnDarkPressedForegroundColor())];
    case BPKButtonStylePrimaryOnDark:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonPrimaryOnDarkNormalBackgroundColor(), BPKColor.textPrimaryColor)
                    loadingAppearance:BPKAppearance(BPKButtonPrimaryOnDarkPressedBackgroundColor(), BPKColor.textPrimaryColor)
                   disabledAppearance:BPKAppearance(BPKButtonPrimaryOnDarkDisabledBackgroundColor(), BPKButtonPrimaryOnDarkDisabledForegroundColor())
                highlightedAppearance:BPKAppearance(BPKButtonPrimaryOnDarkPressedBackgroundColor(), BPKColor.textPrimaryColor)];
    case BPKButtonStylePrimaryOnLight:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonPrimaryOnLightNormalBackgroundColor(), BPKColor.textOnDarkColor)
                    loadingAppearance:BPKAppearance(BPKButtonPrimaryOnLightPressedBackgroundColor(), BPKColor.textOnDarkColor)
                   disabledAppearance:BPKAppearance(BPKButtonPrimaryOnLightDisabledBackgroundColor(),
                                                    BPKButtonPrimaryOnLightDisabledForegroundColor())
                highlightedAppearance:BPKAppearance(BPKButtonPrimaryOnLightPressedBackgroundColor(), BPKColor.textOnDarkColor)];
    case BPKButtonStyleSecondaryOnDark:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonSecondaryOnDarkNormalBackgroundColor(), BPKColor.textOnDarkColor)
                    loadingAppearance:BPKAppearance(BPKButtonSecondaryOnDarkPressedBackgroundColor(), BPKColor.textOnDarkColor)
                   disabledAppearance:BPKAppearance(BPKButtonSecondaryOnDarkDisabledBackgroundColor(),
                                                    BPKButtonSecondaryOnDarkDisabledForegroundColor())
                highlightedAppearance:BPKAppearance(BPKButtonSecondaryOnDarkPressedBackgroundColor(), BPKColor.textOnDarkColor)];
    default:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonPrimaryNormalBackgroundColor(), BPKColor.textOnDarkColor)
                    loadingAppearance:BPKAppearance(BPKButtonPrimaryPressedBackgroundColor(), BPKColor.textOnDarkColor)
                   disabledAppearance:disabledAppearance
                highlightedAppearance:BPKAppearance(BPKButtonPrimaryPressedBackgroundColor(), BPKColor.textOnDarkColor)];
    }
}

NS_ASSUME_NONNULL_BEGIN

@implementation BPKButtonAppearanceSet : NSObject

- (instancetype)initWithRegularAppearance:(BPKButtonAppearance *)regularAppearance
                        loadingAppearance:(BPKButtonAppearance *)loadingAppearance
                       disabledAppearance:(BPKButtonAppearance *)disabledAppearance
                    highlightedAppearance:(BPKButtonAppearance *)highlightedAppearance {
    self = [super init];

    if (self) {
        _regularAppearance = regularAppearance;
        _loadingAppearance = loadingAppearance;
        _disabledAppearance = disabledAppearance;
        _highlightedAppearance = highlightedAppearance;
    }

    return self;
}

- (instancetype)clone {
    return [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:[self.regularAppearance clone]
                                                   loadingAppearance:[self.loadingAppearance clone]
                                                  disabledAppearance:[self.disabledAppearance clone]
                                               highlightedAppearance:[self.highlightedAppearance clone]];
}

@end

NS_ASSUME_NONNULL_END
