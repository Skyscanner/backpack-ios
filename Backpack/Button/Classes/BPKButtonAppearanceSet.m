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
#import "BPKObjcUIKitButton.h"
#import "BPKButtonAppearance.h"
#import <Backpack/BPKColor+Internal.h>
#import <Backpack/Color.h>

static BPKButtonAppearance *BPKAppearance(UIColor *background, UIColor *foreground) {
    BPKButtonAppearance *appearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil
                                                                    gradientStartColor:background
                                                                      gradientEndColor:background
                                                                       foregroundColor:foreground];
    return appearance;
}

// BPKButton is maintenance-only; new work should use the SwiftUI counterpart.

BPKButtonAppearanceSet *BPKButtonAppearanceSetForStyle(BPKButtonStyle style) {
    BPKButtonAppearance *disabledAppearance = BPKAppearance(BPKColor.internalButtonDisabledBackgroundColor, BPKColor.textDisabledColor);
    switch (style) {
    case BPKButtonStylePrimary:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKColor.internalButtonPrimaryNormalBackgroundColor, BPKColor.textOnDarkColor)
                    loadingAppearance:BPKAppearance(BPKColor.internalButtonPrimaryPressedBackgroundColor, BPKColor.textOnDarkColor)
                   disabledAppearance:disabledAppearance
                highlightedAppearance:BPKAppearance(BPKColor.internalButtonPrimaryPressedBackgroundColor, BPKColor.textOnDarkColor)];
    case BPKButtonStyleSecondary:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKColor.internalButtonSecondaryNormalBackgroundColor, BPKColor.textPrimaryColor)
                    loadingAppearance:BPKAppearance(BPKColor.internalButtonSecondaryPressedBackgroundColor, BPKColor.textPrimaryColor)
                   disabledAppearance:disabledAppearance
                highlightedAppearance:BPKAppearance(BPKColor.internalButtonSecondaryPressedBackgroundColor, BPKColor.textPrimaryColor)];
    case BPKButtonStyleFeatured:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKColor.internalButtonFeaturedNormalBackgroundColor, BPKColor.textPrimaryInverseColor)
                    loadingAppearance:BPKAppearance(BPKColor.internalButtonFeaturedPressedBackgroundColor, BPKColor.textPrimaryInverseColor)
                   disabledAppearance:disabledAppearance
                highlightedAppearance:BPKAppearance(BPKColor.internalButtonFeaturedPressedBackgroundColor, BPKColor.textPrimaryInverseColor)];
    case BPKButtonStyleDestructive:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKColor.internalButtonDestructiveNormalBackgroundColor,
                                                    BPKColor.internalButtonDestructiveNormalForegroundColor)
                    loadingAppearance:BPKAppearance(BPKColor.internalButtonDestructivePressedBackgroundColor, BPKColor.textPrimaryInverseColor)
                   disabledAppearance:disabledAppearance
                highlightedAppearance:BPKAppearance(BPKColor.internalButtonDestructivePressedBackgroundColor, BPKColor.textPrimaryInverseColor)];
    case BPKButtonStyleLink:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(UIColor.clearColor, BPKColor.internalButtonLinkNormalForegroundColor)
                    loadingAppearance:BPKAppearance(UIColor.clearColor, BPKColor.internalButtonLinkPressedForegroundColor)
                   disabledAppearance:BPKAppearance(UIColor.clearColor, BPKColor.textDisabledColor)
                highlightedAppearance:BPKAppearance(UIColor.clearColor, BPKColor.internalButtonLinkPressedForegroundColor)];
    case BPKButtonStyleLinkOnDark:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(UIColor.clearColor, BPKColor.internalButtonLinkOnDarkNormalForegroundColor)
                    loadingAppearance:BPKAppearance(UIColor.clearColor, BPKColor.internalButtonLinkOnDarkPressedForegroundColor)
                   disabledAppearance:BPKAppearance(UIColor.clearColor, BPKColor.internalButtonLinkOnDarkDisabledForegroundColor)
                highlightedAppearance:BPKAppearance(UIColor.clearColor, BPKColor.internalButtonLinkOnDarkPressedForegroundColor)];
    case BPKButtonStylePrimaryOnDark:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKColor.internalButtonPrimaryOnDarkNormalBackgroundColor, BPKColor.textOnLightColor)
                    loadingAppearance:BPKAppearance(BPKColor.internalButtonPrimaryOnDarkPressedBackgroundColor, BPKColor.textOnLightColor)
                   disabledAppearance:BPKAppearance(BPKColor.internalButtonPrimaryOnDarkDisabledBackgroundColor,
                                                    BPKColor.internalButtonPrimaryOnDarkDisabledForegroundColor)
                highlightedAppearance:BPKAppearance(BPKColor.internalButtonPrimaryOnDarkPressedBackgroundColor, BPKColor.textOnLightColor)];
    case BPKButtonStylePrimaryOnLight:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKColor.internalButtonPrimaryOnLightNormalBackgroundColor, BPKColor.textOnDarkColor)
                    loadingAppearance:BPKAppearance(BPKColor.internalButtonPrimaryOnLightPressedBackgroundColor, BPKColor.textOnDarkColor)
                   disabledAppearance:BPKAppearance(BPKColor.internalButtonPrimaryOnLightDisabledBackgroundColor,
                                                    BPKColor.internalButtonPrimaryOnLightDisabledForegroundColor)
                highlightedAppearance:BPKAppearance(BPKColor.internalButtonPrimaryOnLightPressedBackgroundColor, BPKColor.textOnDarkColor)];
    case BPKButtonStyleSecondaryOnDark:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKColor.internalButtonSecondaryOnDarkNormalBackgroundColor, BPKColor.textOnDarkColor)
                    loadingAppearance:BPKAppearance(BPKColor.internalButtonSecondaryOnDarkPressedBackgroundColor, BPKColor.textOnDarkColor)
                   disabledAppearance:BPKAppearance(BPKColor.internalButtonSecondaryOnDarkDisabledBackgroundColor,
                                                    BPKColor.internalButtonSecondaryOnDarkDisabledForegroundColor)
                highlightedAppearance:BPKAppearance(BPKColor.internalButtonSecondaryOnDarkPressedBackgroundColor, BPKColor.textOnDarkColor)];
    default:
        return [[BPKButtonAppearanceSet alloc]
            initWithRegularAppearance:BPKAppearance(BPKColor.internalButtonPrimaryNormalBackgroundColor, BPKColor.textOnDarkColor)
                    loadingAppearance:BPKAppearance(BPKColor.internalButtonPrimaryPressedBackgroundColor, BPKColor.textOnDarkColor)
                   disabledAppearance:disabledAppearance
                highlightedAppearance:BPKAppearance(BPKColor.internalButtonPrimaryPressedBackgroundColor, BPKColor.textOnDarkColor)];
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
