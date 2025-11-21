// clang-format off
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

#import "BPKColor+Internal.h"
#import <UIKit/UIKit.h>

@interface BPKColor (BPKInternalColorsPrivate)
+ (UIColor *)dynamicColorWithLightVariant:(UIColor *)lightVariant darkVariant:(UIColor *)darkVariant;
@end

@implementation BPKColor (BPKInternalColors)

+ (UIColor *)internalBadgeBackgroundNormalColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.937 green:0.953 blue:0.973 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.141 green:0.200 blue:0.275 alpha:1]];
}


+ (UIColor *)internalInfoBannerDefaultColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.937 green:0.953 blue:0.973 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.075 green:0.114 blue:0.169 alpha:1]];
}


+ (UIColor *)internalInfoBannerOnContrastColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.075 green:0.114 blue:0.169 alpha:1]];
}


+ (UIColor *)internalInfoBannerSuccessColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.047 green:0.514 blue:0.541 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.384 green:0.945 blue:0.776 alpha:1]];
}


+ (UIColor *)internalInfoBannerErrorColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.906 green:0.031 blue:0.400 alpha:1]
                                          darkVariant:[UIColor colorWithRed:1.000 green:0.392 blue:0.612 alpha:1]];
}


+ (UIColor *)internalInfoBannerInfoColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.384 green:0.412 blue:0.443 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.741 green:0.769 blue:0.796 alpha:1]];
}


+ (UIColor *)internalInfoBannerWarningColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.961 green:0.365 blue:0.259 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.996 green:0.922 blue:0.529 alpha:1]];
}


+ (UIColor *)internalChipOnDarkPressedStrokeColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.020 green:0.255 blue:0.518 alpha:1]];
}


+ (UIColor *)internalChipOnDarkOnBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.020 green:0.255 blue:0.518 alpha:1]];
}


+ (UIColor *)internalChipDisabledBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.878 green:0.894 blue:0.914 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.043 green:0.071 blue:0.114 alpha:1]];
}


+ (UIColor *)internalChipOnDarkOnDismissIconColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.384 green:0.412 blue:0.443 alpha:1]
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.5019607843137255]];
}


+ (UIColor *)internalMapPreviousSelectionColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.812 green:0.894 blue:1.000 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.812 green:0.894 blue:1.000 alpha:1]];
}


+ (UIColor *)internalMapClusterPinColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.020 green:0.125 blue:0.235 alpha:1]
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]];
}


+ (UIColor *)internalMapClusterPinPreviousSelectionColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.580 green:0.765 blue:1.000 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.580 green:0.765 blue:1.000 alpha:1]];
}


+ (UIColor *)internalMapMarkerViewedForegroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.8]
                                          darkVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.8]];
}


+ (UIColor *)internalMapPoiPinColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.557 green:0.278 blue:0.729 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.557 green:0.278 blue:0.729 alpha:1]];
}


+ (UIColor *)internalButtonSecondaryPressedBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.757 green:0.780 blue:0.812 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.004 green:0.035 blue:0.075 alpha:1]];
}


+ (UIColor *)internalButtonLinkNormalForegroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.384 blue:0.890 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.518 green:0.914 blue:1.000 alpha:1]];
}


+ (UIColor *)internalButtonLinkOnDarkDisabledForegroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.2]
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.2]];
}


+ (UIColor *)internalButtonSecondaryNormalBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.878 green:0.894 blue:0.914 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.141 green:0.200 blue:0.275 alpha:1]];
}


+ (UIColor *)internalButtonPrimaryOnLightPressedBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.082 green:0.275 blue:0.475 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.020 green:0.255 blue:0.518 alpha:1]];
}


+ (UIColor *)internalButtonFeaturedNormalBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.384 blue:0.890 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.518 green:0.914 blue:1.000 alpha:1]];
}


+ (UIColor *)internalButtonFeaturedPressedBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.008 green:0.302 blue:0.686 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.820 green:0.969 blue:1.000 alpha:1]];
}


+ (UIColor *)internalButtonPrimaryOnLightNormalBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.020 green:0.125 blue:0.235 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.008 green:0.302 blue:0.686 alpha:1]];
}


+ (UIColor *)internalButtonPrimaryOnLightDisabledForegroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.2]
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.2]];
}


+ (UIColor *)internalButtonSecondaryOnDarkDisabledBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.043 green:0.071 blue:0.114 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.043 green:0.071 blue:0.114 alpha:1]];
}


+ (UIColor *)internalButtonDestructiveNormalForegroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.906 green:0.031 blue:0.400 alpha:1]
                                          darkVariant:[UIColor colorWithRed:1.000 green:0.392 blue:0.612 alpha:1]];
}


+ (UIColor *)internalButtonPrimaryOnDarkNormalBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]];
}


+ (UIColor *)internalButtonPrimaryOnDarkDisabledForegroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.2]
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.2]];
}


+ (UIColor *)internalButtonSecondaryOnDarkPressedBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.004 green:0.035 blue:0.075 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.004 green:0.035 blue:0.075 alpha:1]];
}


+ (UIColor *)internalButtonLinkPressedForegroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.008 green:0.302 blue:0.686 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.820 green:0.969 blue:1.000 alpha:1]];
}


+ (UIColor *)internalButtonPrimaryOnLightDisabledBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.878 green:0.894 blue:0.914 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.043 green:0.071 blue:0.114 alpha:1]];
}


+ (UIColor *)internalButtonDestructiveNormalBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.878 green:0.894 blue:0.914 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.141 green:0.200 blue:0.275 alpha:1]];
}


+ (UIColor *)internalButtonPrimaryNormalBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.020 green:0.125 blue:0.235 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.008 green:0.302 blue:0.686 alpha:1]];
}


+ (UIColor *)internalButtonDestructivePressedBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.906 green:0.031 blue:0.400 alpha:1]
                                          darkVariant:[UIColor colorWithRed:1.000 green:0.392 blue:0.612 alpha:1]];
}


+ (UIColor *)internalButtonPrimaryPressedBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.082 green:0.275 blue:0.475 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.020 green:0.255 blue:0.518 alpha:1]];
}


+ (UIColor *)internalButtonPrimaryOnDarkDisabledBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.878 green:0.894 blue:0.914 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.043 green:0.071 blue:0.114 alpha:1]];
}


+ (UIColor *)internalButtonLinkOnDarkPressedForegroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.5019607843137255]
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.5019607843137255]];
}


+ (UIColor *)internalButtonLinkOnDarkNormalForegroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]];
}


+ (UIColor *)internalButtonDisabledBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.878 green:0.894 blue:0.914 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.043 green:0.071 blue:0.114 alpha:1]];
}


+ (UIColor *)internalButtonSecondaryOnDarkNormalBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.10196078431372549]
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.10196078431372549]];
}


+ (UIColor *)internalButtonSecondaryOnDarkDisabledForegroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.2]
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.2]];
}


+ (UIColor *)internalButtonPrimaryOnDarkPressedBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.757 green:0.780 blue:0.812 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.757 green:0.780 blue:0.812 alpha:1]];
}


+ (UIColor *)internalBarTrackDefaultColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.878 green:0.894 blue:0.914 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.141 green:0.200 blue:0.275 alpha:1]];
}


+ (UIColor *)internalBarTrackOnContrastColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.141 green:0.200 blue:0.275 alpha:1]];
}


+ (UIColor *)internalSkeletonShimmerStartEndColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0]
                                          darkVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0]];
}


+ (UIColor *)internalSkeletonShimmerCenterColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.6]
                                          darkVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.2]];
}


+ (UIColor *)internalSponsoredBannerBackgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.937 green:0.953 blue:0.973 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.141 green:0.200 blue:0.275 alpha:1]];
}


+ (UIColor *)internalNavigationTabHoverColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.082 green:0.275 blue:0.475 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.820 green:0.969 blue:1.000 alpha:1]];
}


+ (UIColor *)internalNavigationTabOutlineColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.757 green:0.780 blue:0.812 alpha:1]
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]];
}


+ (UIColor *)internalCardButtonContainedFillColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.8]
                                          darkVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.8]];
}


+ (UIColor *)internalSegmentedControlCanvasDefaultColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.937 green:0.953 blue:0.973 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.075 green:0.114 blue:0.169 alpha:1]];
}


+ (UIColor *)internalSegmentedControlSurfaceContrastColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.10196078431372549]
                                          darkVariant:[UIColor colorWithRed:0.075 green:0.114 blue:0.169 alpha:1]];
}


+ (UIColor *)internalSegmentedControlSurfaceContrastOnColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.008 green:0.302 blue:0.686 alpha:1]
                                          darkVariant:[UIColor colorWithRed:0.020 green:0.255 blue:0.518 alpha:1]];
}

@end
// clang-format on
