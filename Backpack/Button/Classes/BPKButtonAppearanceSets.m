/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2025 Skyscanner Ltd
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

#import "BPKButtonAppearanceSets.h"

#import "BPKButtonAppearance.h"
#import "BPKButtonAppearanceSet.h"

#import <Backpack/Color.h>

NS_ASSUME_NONNULL_BEGIN

static inline BPKButtonAppearance *BPKButtonAppearanceWith(UIColor *background, UIColor *foreground) {
    return [[BPKButtonAppearance alloc] initWithBorderColor:nil
                                         gradientStartColor:background
                                           gradientEndColor:background
                                            foregroundColor:foreground];
}

@implementation BPKButtonAppearanceSets

+ (BPKButtonAppearance *)disabledAppearance {
    static BPKButtonAppearance *appearance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appearance = BPKButtonAppearanceWith(BPKColor.buttonDisabledBackgroundColor, BPKColor.textDisabledColor);
    });
    return appearance;
}

+ (BPKButtonAppearanceSet *)primary {
    static BPKButtonAppearanceSet *set;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:BPKButtonAppearanceWith(BPKColor.buttonPrimaryNormalBackgroundColor, BPKColor.textOnDarkColor)
                                                       loadingAppearance:BPKButtonAppearanceWith(BPKColor.buttonPrimaryPressedBackgroundColor, BPKColor.textOnDarkColor)
                                                      disabledAppearance:[self disabledAppearance]
                                                   highlightedAppearance:BPKButtonAppearanceWith(BPKColor.buttonPrimaryPressedBackgroundColor, BPKColor.textOnDarkColor)];
    });
    return set;
}

+ (BPKButtonAppearanceSet *)secondary {
    static BPKButtonAppearanceSet *set;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:BPKButtonAppearanceWith(BPKColor.buttonSecondaryNormalBackgroundColor, BPKColor.textPrimaryColor)
                                                       loadingAppearance:BPKButtonAppearanceWith(BPKColor.buttonSecondaryPressedBackgroundColor, BPKColor.textPrimaryColor)
                                                      disabledAppearance:[self disabledAppearance]
                                                   highlightedAppearance:BPKButtonAppearanceWith(BPKColor.buttonSecondaryPressedBackgroundColor, BPKColor.textPrimaryColor)];
    });
    return set;
}

+ (BPKButtonAppearanceSet *)featured {
    static BPKButtonAppearanceSet *set;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:BPKButtonAppearanceWith(BPKColor.buttonFeaturedNormalBackgroundColor, BPKColor.textPrimaryInverseColor)
                                                       loadingAppearance:BPKButtonAppearanceWith(BPKColor.buttonFeaturedPressedBackgroundColor, BPKColor.textPrimaryInverseColor)
                                                      disabledAppearance:[self disabledAppearance]
                                                   highlightedAppearance:BPKButtonAppearanceWith(BPKColor.buttonFeaturedPressedBackgroundColor, BPKColor.textPrimaryInverseColor)];
    });
    return set;
}

+ (BPKButtonAppearanceSet *)destructive {
    static BPKButtonAppearanceSet *set;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:BPKButtonAppearanceWith(BPKColor.buttonDestructiveNormalBackgroundColor, BPKColor.buttonDestructiveNormalForegroundColor)
                                                       loadingAppearance:BPKButtonAppearanceWith(BPKColor.buttonDestructivePressedBackgroundColor, BPKColor.textPrimaryInverseColor)
                                                      disabledAppearance:[self disabledAppearance]
                                                   highlightedAppearance:BPKButtonAppearanceWith(BPKColor.buttonDestructivePressedBackgroundColor, BPKColor.textPrimaryInverseColor)];
    });
    return set;
}

+ (BPKButtonAppearanceSet *)link {
    static BPKButtonAppearanceSet *set;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BPKButtonAppearance *disabled = BPKButtonAppearanceWith([[UIColor clearColor] colorWithAlphaComponent:0], BPKColor.textDisabledColor);
        set = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:BPKButtonAppearanceWith([UIColor clearColor], BPKColor.buttonLinkNormalForegroundColor)
                                                       loadingAppearance:BPKButtonAppearanceWith([UIColor clearColor], BPKColor.buttonLinkPressedForegroundColor)
                                                      disabledAppearance:disabled
                                                   highlightedAppearance:BPKButtonAppearanceWith([UIColor clearColor], BPKColor.buttonLinkPressedForegroundColor)];
    });
    return set;
}

+ (BPKButtonAppearanceSet *)linkOnDark {
    static BPKButtonAppearanceSet *set;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BPKButtonAppearance *disabled = BPKButtonAppearanceWith([[UIColor clearColor] colorWithAlphaComponent:0], BPKColor.buttonLinkOnDarkDisabledForegroundColor);
        set = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:BPKButtonAppearanceWith([UIColor clearColor], BPKColor.buttonLinkOnDarkNormalForegroundColor)
                                                       loadingAppearance:BPKButtonAppearanceWith([UIColor clearColor], BPKColor.buttonLinkOnDarkPressedForegroundColor)
                                                      disabledAppearance:disabled
                                                   highlightedAppearance:BPKButtonAppearanceWith([UIColor clearColor], BPKColor.buttonLinkOnDarkPressedForegroundColor)];
    });
    return set;
}

+ (BPKButtonAppearanceSet *)primaryOnDark {
    static BPKButtonAppearanceSet *set;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:BPKButtonAppearanceWith(BPKColor.buttonPrimaryOnDarkNormalBackgroundColor, BPKColor.textOnLightColor)
                                                       loadingAppearance:BPKButtonAppearanceWith(BPKColor.buttonPrimaryOnDarkPressedBackgroundColor, BPKColor.textOnLightColor)
                                                      disabledAppearance:BPKButtonAppearanceWith(BPKColor.buttonPrimaryOnDarkDisabledBackgroundColor, BPKColor.buttonPrimaryOnDarkDisabledForegroundColor)
                                                   highlightedAppearance:BPKButtonAppearanceWith(BPKColor.buttonPrimaryOnDarkPressedBackgroundColor, BPKColor.textOnLightColor)];
    });
    return set;
}

+ (BPKButtonAppearanceSet *)primaryOnLight {
    static BPKButtonAppearanceSet *set;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:BPKButtonAppearanceWith(BPKColor.buttonPrimaryOnLightNormalBackgroundColor, BPKColor.textOnDarkColor)
                                                       loadingAppearance:BPKButtonAppearanceWith(BPKColor.buttonPrimaryOnLightPressedBackgroundColor, BPKColor.textOnDarkColor)
                                                      disabledAppearance:BPKButtonAppearanceWith(BPKColor.buttonPrimaryOnLightDisabledBackgroundColor, BPKColor.buttonPrimaryOnLightDisabledForegroundColor)
                                                   highlightedAppearance:BPKButtonAppearanceWith(BPKColor.buttonPrimaryOnLightPressedBackgroundColor, BPKColor.textOnDarkColor)];
    });
    return set;
}

+ (BPKButtonAppearanceSet *)secondaryOnDark {
    static BPKButtonAppearanceSet *set;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:BPKButtonAppearanceWith(BPKColor.buttonSecondaryOnDarkNormalBackgroundColor, BPKColor.textOnDarkColor)
                                                       loadingAppearance:BPKButtonAppearanceWith(BPKColor.buttonSecondaryOnDarkPressedBackgroundColor, BPKColor.textOnDarkColor)
                                                      disabledAppearance:BPKButtonAppearanceWith(BPKColor.buttonSecondaryOnDarkDisabledBackgroundColor, BPKColor.buttonSecondaryOnDarkDisabledForegroundColor)
                                                   highlightedAppearance:BPKButtonAppearanceWith(BPKColor.buttonSecondaryOnDarkPressedBackgroundColor, BPKColor.textOnDarkColor)];
    });
    return set;
}

+ (BPKButtonAppearanceSet *)appearanceFromStyle:(BPKButtonStyle)style {
    switch (style) {
    case BPKButtonStylePrimary:
        return [self primary];
    case BPKButtonStyleSecondary:
        return [self secondary];
    case BPKButtonStyleFeatured:
        return [self featured];
    case BPKButtonStyleDestructive:
        return [self destructive];
    case BPKButtonStyleLink:
        return [self link];
    case BPKButtonStyleLinkOnDark:
        return [self linkOnDark];
    case BPKButtonStylePrimaryOnDark:
        return [self primaryOnDark];
    case BPKButtonStylePrimaryOnLight:
        return [self primaryOnLight];
    case BPKButtonStyleSecondaryOnDark:
        return [self secondaryOnDark];
    default:
        return [self primary];
    }
}

@end

NS_ASSUME_NONNULL_END
