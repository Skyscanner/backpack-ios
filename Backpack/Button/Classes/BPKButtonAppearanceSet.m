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
#import "BPKButtonAppearance.h"
#import "BPKButton.h"
#import <Backpack/Color.h>

static UIColor *BPKDynamicColor(CGFloat lr, CGFloat lg, CGFloat lb, CGFloat la, CGFloat dr, CGFloat dg, CGFloat db, CGFloat da) {
    return [UIColor colorWithDynamicProvider:^UIColor *_Nonnull(UITraitCollection *_Nonnull traitCollection) {
      if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
          return [UIColor colorWithRed:dr green:dg blue:db alpha:da];
      }
      return [UIColor colorWithRed:lr green:lg blue:lb alpha:la];
    }];
}

static BPKButtonAppearance *BPKAppearance(UIColor *background, UIColor *foreground) {
    return [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:background gradientEndColor:background foregroundColor:foreground];
}

#define BPK_DEFINE_BUTTON_COLOR(name, lr, lg, lb, la, dr, dg, db, da) \
static UIColor *name(void) { \
    static UIColor *color; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        color = BPKDynamicColor(lr, lg, lb, la, dr, dg, db, da); \
    }); \
    return color; \
}

BPK_DEFINE_BUTTON_COLOR(BPKButtonDisabledBackgroundColor, 0.878, 0.894, 0.914, 1.0, 0.043, 0.071, 0.114, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonPrimaryNormalBackgroundColor, 0.020, 0.125, 0.235, 1.0, 0.008, 0.302, 0.686, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonPrimaryPressedBackgroundColor, 0.082, 0.275, 0.475, 1.0, 0.020, 0.255, 0.518, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonSecondaryNormalBackgroundColor, 0.878, 0.894, 0.914, 1.0, 0.141, 0.200, 0.275, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonSecondaryPressedBackgroundColor, 0.757, 0.780, 0.812, 1.0, 0.004, 0.035, 0.075, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonFeaturedNormalBackgroundColor, 0.000, 0.384, 0.890, 1.0, 0.518, 0.914, 1.000, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonFeaturedPressedBackgroundColor, 0.008, 0.302, 0.686, 1.0, 0.820, 0.969, 1.000, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonDestructiveNormalBackgroundColor, 0.878, 0.894, 0.914, 1.0, 0.141, 0.200, 0.275, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonDestructiveNormalForegroundColor, 0.906, 0.031, 0.400, 1.0, 1.000, 0.392, 0.612, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonDestructivePressedBackgroundColor, 0.906, 0.031, 0.400, 1.0, 1.000, 0.392, 0.612, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonLinkNormalForegroundColor, 0.000, 0.384, 0.890, 1.0, 0.518, 0.914, 1.000, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonLinkPressedForegroundColor, 0.008, 0.302, 0.686, 1.0, 0.820, 0.969, 1.000, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonLinkOnDarkNormalForegroundColor, 1.000, 1.000, 1.000, 1.0, 1.000, 1.000, 1.000, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonLinkOnDarkPressedForegroundColor, 1.000, 1.000, 1.000, 0.5019607843137255, 1.000, 1.000, 1.000, 0.5019607843137255)
BPK_DEFINE_BUTTON_COLOR(BPKButtonLinkOnDarkDisabledForegroundColor, 1.000, 1.000, 1.000, 0.2, 1.000, 1.000, 1.000, 0.2)
BPK_DEFINE_BUTTON_COLOR(BPKButtonPrimaryOnDarkNormalBackgroundColor, 1.000, 1.000, 1.000, 1.0, 1.000, 1.000, 1.000, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonPrimaryOnDarkPressedBackgroundColor, 0.757, 0.780, 0.812, 1.0, 0.757, 0.780, 0.812, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonPrimaryOnDarkDisabledBackgroundColor, 0.878, 0.894, 0.914, 1.0, 0.043, 0.071, 0.114, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonPrimaryOnDarkDisabledForegroundColor, 0.000, 0.000, 0.000, 0.2, 1.000, 1.000, 1.000, 0.2)
BPK_DEFINE_BUTTON_COLOR(BPKButtonPrimaryOnLightNormalBackgroundColor, 0.020, 0.125, 0.235, 1.0, 0.008, 0.302, 0.686, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonPrimaryOnLightPressedBackgroundColor, 0.082, 0.275, 0.475, 1.0, 0.020, 0.255, 0.518, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonPrimaryOnLightDisabledBackgroundColor, 0.878, 0.894, 0.914, 1.0, 0.043, 0.071, 0.114, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonPrimaryOnLightDisabledForegroundColor, 0.000, 0.000, 0.000, 0.2, 1.000, 1.000, 1.000, 0.2)
BPK_DEFINE_BUTTON_COLOR(BPKButtonSecondaryOnDarkNormalBackgroundColor, 1.000, 1.000, 1.000, 0.10196078431372549, 1.000, 1.000, 1.000, 0.10196078431372549)
BPK_DEFINE_BUTTON_COLOR(BPKButtonSecondaryOnDarkPressedBackgroundColor, 0.004, 0.035, 0.075, 1.0, 0.004, 0.035, 0.075, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonSecondaryOnDarkDisabledBackgroundColor, 0.043, 0.071, 0.114, 1.0, 0.043, 0.071, 0.114, 1.0)
BPK_DEFINE_BUTTON_COLOR(BPKButtonSecondaryOnDarkDisabledForegroundColor, 1.000, 1.000, 1.000, 0.2, 1.000, 1.000, 1.000, 0.2)

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
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkNormalForegroundColor())
                    loadingAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkPressedForegroundColor())
                   disabledAppearance:BPKAppearance([UIColor.clearColor colorWithAlphaComponent:0], BPKColor.textDisabledColor)
                highlightedAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkPressedForegroundColor())];
    case BPKButtonStyleLinkOnDark:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkOnDarkNormalForegroundColor())
                    loadingAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkOnDarkPressedForegroundColor())
                   disabledAppearance:BPKAppearance([UIColor.clearColor colorWithAlphaComponent:0], BPKButtonLinkOnDarkDisabledForegroundColor())
                highlightedAppearance:BPKAppearance(UIColor.clearColor, BPKButtonLinkOnDarkPressedForegroundColor())];
    case BPKButtonStylePrimaryOnDark:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonPrimaryOnDarkNormalBackgroundColor(), BPKColor.textOnLightColor)
                    loadingAppearance:BPKAppearance(BPKButtonPrimaryOnDarkPressedBackgroundColor(), BPKColor.textOnLightColor)
                   disabledAppearance:BPKAppearance(BPKButtonPrimaryOnDarkDisabledBackgroundColor(), BPKButtonPrimaryOnDarkDisabledForegroundColor())
                highlightedAppearance:BPKAppearance(BPKButtonPrimaryOnDarkPressedBackgroundColor(), BPKColor.textOnLightColor)];
    case BPKButtonStylePrimaryOnLight:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonPrimaryOnLightNormalBackgroundColor(), BPKColor.textOnDarkColor)
                    loadingAppearance:BPKAppearance(BPKButtonPrimaryOnLightPressedBackgroundColor(), BPKColor.textOnDarkColor)
                   disabledAppearance:BPKAppearance(BPKButtonPrimaryOnLightDisabledBackgroundColor(), BPKButtonPrimaryOnLightDisabledForegroundColor())
                highlightedAppearance:BPKAppearance(BPKButtonPrimaryOnLightPressedBackgroundColor(), BPKColor.textOnDarkColor)];
    case BPKButtonStyleSecondaryOnDark:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonSecondaryOnDarkNormalBackgroundColor(), BPKColor.textOnDarkColor)
                    loadingAppearance:BPKAppearance(BPKButtonSecondaryOnDarkPressedBackgroundColor(), BPKColor.textOnDarkColor)
                   disabledAppearance:BPKAppearance(BPKButtonSecondaryOnDarkDisabledBackgroundColor(), BPKButtonSecondaryOnDarkDisabledForegroundColor())
                highlightedAppearance:BPKAppearance(BPKButtonSecondaryOnDarkPressedBackgroundColor(), BPKColor.textOnDarkColor)];
    default:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKButtonPrimaryNormalBackgroundColor(), BPKColor.textOnDarkColor)
                    loadingAppearance:BPKAppearance(BPKButtonPrimaryPressedBackgroundColor(), BPKColor.textOnDarkColor)
                   disabledAppearance:disabledAppearance
                highlightedAppearance:BPKAppearance(BPKButtonPrimaryPressedBackgroundColor(), BPKColor.textOnDarkColor)];
    }
}

#undef BPK_DEFINE_BUTTON_COLOR

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
