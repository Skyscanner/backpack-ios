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
#import "BPKColor.h"

#import <Backpack/DarkMode.h>

@interface BPKColor()
@property(nonatomic, strong, readonly) NSCache<NSString *, UIColor *> *dynamicColorsCache;
@end

@implementation BPKColor

+ (UIColor *)backgroundAlternativeDarkColor {
    return [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1];
}

+ (UIColor *)backgroundAlternativeLightColor {
    return [UIColor colorWithRed:0.945 green:0.949 blue:0.973 alpha:1];
}

+ (UIColor *)backgroundAlternativeSecondaryDarkColor {
    return [UIColor colorWithRed:0.114 green:0.106 blue:0.125 alpha:1];
}

+ (UIColor *)backgroundAlternativeSecondaryLightColor {
    return [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1];
}

+ (UIColor *)backgroundElevation02DarkColor {
    return [UIColor colorWithRed:0.173 green:0.173 blue:0.180 alpha:1];
}

+ (UIColor *)backgroundElevation03DarkColor {
    return [UIColor colorWithRed:0.227 green:0.227 blue:0.235 alpha:1];
}

+ (UIColor *)abisko {
    return [UIColor colorWithRed:0.353 green:0.282 blue:0.608 alpha:1];
}

+ (UIColor *)amberSpot {
    return [UIColor colorWithRed:1.000 green:0.580 blue:0.000 alpha:1];
}

+ (UIColor *)bagan {
    return [UIColor colorWithRed:1.000 green:0.922 blue:0.816 alpha:1];
}

+ (UIColor *)berry {
    return [UIColor colorWithRed:0.820 green:0.263 blue:0.357 alpha:1];
}

+ (UIColor *)blackAlpha20 {
    return [UIColor colorWithRed:0.698 green:0.698 blue:0.749 alpha:1];
}

+ (UIColor *)blackAlpha70 {
    return [UIColor colorWithRed:0.008 green:0.071 blue:0.173 alpha:1];
}

+ (UIColor *)blackTint04 {
    return [UIColor colorWithRed:0.282 green:0.282 blue:0.290 alpha:1];
}

+ (UIColor *)blackTint05 {
    return [UIColor colorWithRed:0.388 green:0.388 blue:0.400 alpha:1];
}

+ (UIColor *)blackTint06 {
    return [UIColor colorWithRed:0.557 green:0.557 blue:0.576 alpha:1];
}

+ (UIColor *)bunol {
    return [UIColor colorWithRed:1.000 green:0.482 blue:0.349 alpha:1];
}

+ (UIColor *)charcoal {
    return [UIColor colorWithRed:0.067 green:0.071 blue:0.212 alpha:1];
}

+ (UIColor *)ecoGreen {
    return [UIColor colorWithRed:0.059 green:0.631 blue:0.663 alpha:1];
}

+ (UIColor *)erfoud {
    return [UIColor colorWithRed:1.000 green:0.710 blue:0.302 alpha:1];
}

+ (UIColor *)glencoe {
    return [UIColor colorWithRed:0.451 green:0.808 blue:0.776 alpha:1];
}

+ (UIColor *)greenMuted {
    return [UIColor colorWithRed:0.816 green:0.933 blue:0.925 alpha:1];
}

+ (UIColor *)greenSpot {
    return [UIColor colorWithRed:0.000 green:0.651 blue:0.596 alpha:1];
}

+ (UIColor *)grey20 {
    return [UIColor colorWithRed:0.867 green:0.867 blue:0.898 alpha:1];
}

+ (UIColor *)grey30 {
    return [UIColor colorWithRed:0.804 green:0.804 blue:0.843 alpha:1];
}

+ (UIColor *)grey40 {
    return [UIColor colorWithRed:0.408 green:0.412 blue:0.498 alpha:1];
}

+ (UIColor *)harbour {
    return [UIColor colorWithRed:0.965 green:0.867 blue:0.882 alpha:1];
}

+ (UIColor *)hillier {
    return [UIColor colorWithRed:0.882 green:0.545 blue:0.588 alpha:1];
}

+ (UIColor *)nara {
    return [UIColor colorWithRed:1.000 green:0.906 blue:0.878 alpha:1];
}

+ (UIColor *)nightBlue {
    return [UIColor colorWithRed:0.427 green:0.624 blue:0.922 alpha:1];
}

+ (UIColor *)nightGreenFill {
    return [UIColor colorWithRed:0.694 green:1.000 blue:0.906 alpha:1];
}

+ (UIColor *)nightPink {
    return [UIColor colorWithRed:1.000 green:0.792 blue:0.867 alpha:1];
}

+ (UIColor *)nightSky {
    return [UIColor colorWithRed:0.020 green:0.255 blue:0.518 alpha:1];
}

+ (UIColor *)nightYellowFill {
    return [UIColor colorWithRed:0.984 green:0.945 blue:0.733 alpha:1];
}

+ (UIColor *)petra {
    return [UIColor colorWithRed:1.000 green:0.671 blue:0.584 alpha:1];
}

+ (UIColor *)primaryGradientLight {
    return [UIColor colorWithRed:0.027 green:0.439 blue:0.890 alpha:1];
}

+ (UIColor *)skyBlueShade01 {
    return [UIColor colorWithRed:0.031 green:0.306 blue:0.698 alpha:1];
}

+ (UIColor *)skyBlueShade02 {
    return [UIColor colorWithRed:0.016 green:0.153 blue:0.349 alpha:1];
}

+ (UIColor *)skyBlueTint02 {
    return [UIColor colorWithRed:0.616 green:0.753 blue:0.949 alpha:1];
}

+ (UIColor *)skyBlueTint03 {
    return [UIColor colorWithRed:0.804 green:0.875 blue:0.973 alpha:1];
}

+ (UIColor *)skyGrayTint01 {
    return [UIColor colorWithRed:0.267 green:0.271 blue:0.376 alpha:1];
}

+ (UIColor *)skyGrayTint03 {
    return [UIColor colorWithRed:0.561 green:0.565 blue:0.627 alpha:1];
}

+ (UIColor *)tochigi {
    return [UIColor colorWithRed:0.882 green:0.867 blue:0.925 alpha:1];
}

+ (UIColor *)valensole {
    return [UIColor colorWithRed:0.647 green:0.608 blue:0.784 alpha:1];
}

+ (UIColor *)marcommsBlueBright {
    return [UIColor colorWithRed:0.631 green:0.933 blue:1.000 alpha:1];
}

+ (UIColor *)marcommsBlueMuted {
    return [UIColor colorWithRed:0.851 green:0.973 blue:1.000 alpha:1];
}

+ (UIColor *)marcommsGreenBright {
    return [UIColor colorWithRed:0.576 green:1.000 blue:0.871 alpha:1];
}

+ (UIColor *)marcommsPink {
    return [UIColor colorWithRed:1.000 green:0.639 blue:0.898 alpha:1];
}

+ (UIColor *)marcommsPurple {
    return [UIColor colorWithRed:0.557 green:0.278 blue:0.729 alpha:1];
}

+ (UIColor *)marcommsYellow {
    return [UIColor colorWithRed:0.996 green:0.922 blue:0.529 alpha:1];
}


+ (UIColor *)backgroundDarkColor {
    return self.class.backgroundAlternativeDarkColor;
}

+ (UIColor *)backgroundElevation01DarkColor {
    return self.class.backgroundAlternativeSecondaryDarkColor;
}

+ (UIColor *)backgroundElevation01LightColor {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)backgroundElevation02LightColor {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)backgroundElevation03LightColor {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)backgroundLightColor {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)backgroundSecondaryDarkColor {
    return self.class.backgroundAlternativeSecondaryDarkColor;
}

+ (UIColor *)backgroundSecondaryLightColor {
    return self.class.backgroundAlternativeLightColor;
}

+ (UIColor *)backgroundTertiaryDarkColor {
    return self.class.backgroundElevation02DarkColor;
}

+ (UIColor *)backgroundTertiaryLightColor {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)canvasContrastDay {
    return self.class.backgroundAlternativeLightColor;
}

+ (UIColor *)canvasContrastNight {
    return self.class.backgroundAlternativeSecondaryDarkColor;
}

+ (UIColor *)canvasDay {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)canvasNight {
    return self.class.backgroundAlternativeDarkColor;
}

+ (UIColor *)black {
    return self.class.backgroundAlternativeDarkColor;
}

+ (UIColor *)blackTint01 {
    return self.class.backgroundAlternativeSecondaryDarkColor;
}

+ (UIColor *)blackTint02 {
    return self.class.backgroundElevation02DarkColor;
}

+ (UIColor *)blackTint03 {
    return self.class.backgroundElevation03DarkColor;
}

+ (UIColor *)darkSky {
    return self.class.blackAlpha70;
}

+ (UIColor *)grey10 {
    return self.class.backgroundAlternativeLightColor;
}

+ (UIColor *)kolkata {
    return self.class.amberSpot;
}

+ (UIColor *)monteverde {
    return self.class.greenSpot;
}

+ (UIColor *)nightBerry {
    return self.class.berry;
}

+ (UIColor *)nightGreenSpot {
    return self.class.greenSpot;
}

+ (UIColor *)nightGrey10 {
    return self.class.backgroundAlternativeDarkColor;
}

+ (UIColor *)nightGrey20 {
    return self.class.backgroundAlternativeSecondaryDarkColor;
}

+ (UIColor *)nightGrey25 {
    return self.class.backgroundElevation02DarkColor;
}

+ (UIColor *)nightGrey30 {
    return self.class.blackTint04;
}

+ (UIColor *)nightGrey40 {
    return self.class.blackTint06;
}

+ (UIColor *)nightYellowSpot {
    return self.class.erfoud;
}

+ (UIColor *)panjin {
    return self.class.berry;
}

+ (UIColor *)pinkMuted {
    return self.class.harbour;
}

+ (UIColor *)sagano {
    return self.class.greenMuted;
}

+ (UIColor *)skyBlue {
    return self.class.primaryGradientLight;
}

+ (UIColor *)skyBlueShade03 {
    return self.class.blackAlpha70;
}

+ (UIColor *)skyBlueTint01 {
    return self.class.nightBlue;
}

+ (UIColor *)skyGray {
    return self.class.charcoal;
}

+ (UIColor *)skyGrayTint02 {
    return self.class.grey40;
}

+ (UIColor *)skyGrayTint04 {
    return self.class.blackAlpha20;
}

+ (UIColor *)skyGrayTint05 {
    return self.class.grey30;
}

+ (UIColor *)skyGrayTint06 {
    return self.class.grey20;
}

+ (UIColor *)skyGrayTint07 {
    return self.class.backgroundAlternativeLightColor;
}

+ (UIColor *)systemGreen {
    return self.class.greenSpot;
}

+ (UIColor *)systemRed {
    return self.class.berry;
}

+ (UIColor *)white {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)whiteAlpha20 {
    return self.class.blackTint06;
}

+ (UIColor *)whiteAlpha80 {
    return self.class.blackTint06;
}

+ (UIColor *)yellowMuted {
    return self.class.bagan;
}

+ (UIColor *)coreAccentDay {
    return self.class.primaryGradientLight;
}

+ (UIColor *)coreAccentNight {
    return self.class.nightBlue;
}

+ (UIColor *)coreEcoDay {
    return self.class.ecoGreen;
}

+ (UIColor *)coreEcoNight {
    return self.class.ecoGreen;
}

+ (UIColor *)corePrimaryDay {
    return self.class.blackAlpha70;
}

+ (UIColor *)corePrimaryNight {
    return self.class.nightSky;
}

+ (UIColor *)lineDarkColor {
    return self.class.blackTint04;
}

+ (UIColor *)lineDay {
    return self.class.grey30;
}

+ (UIColor *)lineLightColor {
    return self.class.grey30;
}

+ (UIColor *)lineNight {
    return self.class.blackTint04;
}

+ (UIColor *)marcommsBerry {
    return self.class.berry;
}

+ (UIColor *)marcommsCharcoal {
    return self.class.charcoal;
}

+ (UIColor *)marcommsDarkSky {
    return self.class.blackAlpha70;
}

+ (UIColor *)marcommsEcoGreen {
    return self.class.ecoGreen;
}

+ (UIColor *)marcommsGreenMuted {
    return self.class.greenMuted;
}

+ (UIColor *)marcommsGrey40 {
    return self.class.grey40;
}

+ (UIColor *)marcommsOrange {
    return self.class.bunol;
}

+ (UIColor *)marcommsPinkMuted {
    return self.class.harbour;
}

+ (UIColor *)marcommsSkyBlue {
    return self.class.primaryGradientLight;
}

+ (UIColor *)marcommsWhite {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)marcommsYellowMuted {
    return self.class.bagan;
}

+ (UIColor *)primaryDarkColor {
    return self.class.nightBlue;
}

+ (UIColor *)primaryLightColor {
    return self.class.primaryGradientLight;
}

+ (UIColor *)scrimDay {
    return self.class.blackAlpha70;
}

+ (UIColor *)scrimNight {
    return self.class.blackAlpha70;
}

+ (UIColor *)shadowLgColor {
    return self.class.charcoal;
}

+ (UIColor *)shadowSmColor {
    return self.class.charcoal;
}

+ (UIColor *)statusDangerFillDay {
    return self.class.harbour;
}

+ (UIColor *)statusDangerFillNight {
    return self.class.nightPink;
}

+ (UIColor *)statusDangerSpotDay {
    return self.class.berry;
}

+ (UIColor *)statusDangerSpotNight {
    return self.class.berry;
}

+ (UIColor *)statusSuccessFillDay {
    return self.class.greenMuted;
}

+ (UIColor *)statusSuccessFillNight {
    return self.class.nightGreenFill;
}

+ (UIColor *)statusSuccessSpotDay {
    return self.class.greenSpot;
}

+ (UIColor *)statusSuccessSpotNight {
    return self.class.greenSpot;
}

+ (UIColor *)statusWarningFillDay {
    return self.class.bagan;
}

+ (UIColor *)statusWarningFillNight {
    return self.class.nightYellowFill;
}

+ (UIColor *)statusWarningSpotDay {
    return self.class.amberSpot;
}

+ (UIColor *)statusWarningSpotNight {
    return self.class.erfoud;
}

+ (UIColor *)surfaceContrastDay {
    return self.class.blackAlpha70;
}

+ (UIColor *)surfaceContrastNight {
    return self.class.backgroundAlternativeSecondaryDarkColor;
}

+ (UIColor *)surfaceDefaultDay {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)surfaceDefaultNight {
    return self.class.backgroundAlternativeSecondaryDarkColor;
}

+ (UIColor *)surfaceElevatedDay {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)surfaceElevatedNight {
    return self.class.backgroundElevation02DarkColor;
}

+ (UIColor *)surfaceHighlightDay {
    return self.class.grey20;
}

+ (UIColor *)surfaceHighlightNight {
    return self.class.backgroundElevation02DarkColor;
}

+ (UIColor *)textDisabledDay {
    return self.class.blackAlpha20;
}

+ (UIColor *)textDisabledNight {
    return self.class.blackTint06;
}

+ (UIColor *)textErrorDay {
    return self.class.berry;
}

+ (UIColor *)textErrorNight {
    return self.class.berry;
}

+ (UIColor *)textLinkDay {
    return self.class.primaryGradientLight;
}

+ (UIColor *)textLinkNight {
    return self.class.nightBlue;
}

+ (UIColor *)textPrimaryDarkColor {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)textPrimaryDay {
    return self.class.charcoal;
}

+ (UIColor *)textPrimaryLightColor {
    return self.class.charcoal;
}

+ (UIColor *)textPrimaryNight {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)textPrimaryOnContrastDay {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)textPrimaryOnContrastNight {
    return self.class.backgroundAlternativeSecondaryLightColor;
}

+ (UIColor *)textQuaternaryDarkColor {
    return self.class.blackTint06;
}

+ (UIColor *)textQuaternaryLightColor {
    return self.class.skyGrayTint03;
}

+ (UIColor *)textSecondaryDarkColor {
    return self.class.blackAlpha20;
}

+ (UIColor *)textSecondaryDay {
    return self.class.grey40;
}

+ (UIColor *)textSecondaryLightColor {
    return self.class.grey40;
}

+ (UIColor *)textSecondaryNight {
    return self.class.blackAlpha20;
}

+ (UIColor *)textSecondaryOnContrastDay {
    return self.class.blackTint06;
}

+ (UIColor *)textSecondaryOnContrastNight {
    return self.class.blackTint06;
}

+ (UIColor *)textTertiaryDarkColor {
    return self.class.blackTint06;
}

+ (UIColor *)textTertiaryLightColor {
    return self.class.skyGrayTint03;
}

+ (UIColor *)touchableOverlayColor {
    return self.class.charcoal;
}


+ (UIColor *)backgroundAlternativeColor {
    return [[self class] dynamicColorWithLightVariant:self.class.skyGrayTint07 darkVariant:self.class.black];
}

+ (UIColor *)backgroundAlternativeSecondaryColor {
    return [[self class] dynamicColorWithLightVariant:self.class.white darkVariant:self.class.blackTint01];
}

+ (UIColor *)backgroundColor {
    return [[self class] dynamicColorWithLightVariant:self.class.white darkVariant:self.class.black];
}

+ (UIColor *)backgroundElevation01Color {
    return [[self class] dynamicColorWithLightVariant:self.class.white darkVariant:self.class.blackTint01];
}

+ (UIColor *)backgroundElevation02Color {
    return [[self class] dynamicColorWithLightVariant:self.class.white darkVariant:self.class.blackTint02];
}

+ (UIColor *)backgroundElevation03Color {
    return [[self class] dynamicColorWithLightVariant:self.class.white darkVariant:self.class.blackTint03];
}

+ (UIColor *)backgroundSecondaryColor {
    return [[self class] dynamicColorWithLightVariant:self.class.skyGrayTint07 darkVariant:self.class.blackTint01];
}

+ (UIColor *)backgroundTertiaryColor {
    return [[self class] dynamicColorWithLightVariant:self.class.white darkVariant:self.class.blackTint02];
}

+ (UIColor *)canvasContrastColor {
    return [[self class] dynamicColorWithLightVariant:self.class.grey10 darkVariant:self.class.nightGrey20];
}

+ (UIColor *)canvasColor {
    return [[self class] dynamicColorWithLightVariant:self.class.white darkVariant:self.class.nightGrey10];
}

+ (UIColor *)coreAccentColor {
    return [[self class] dynamicColorWithLightVariant:self.class.skyBlue darkVariant:self.class.nightBlue];
}

+ (UIColor *)coreEcoColor {
    return [[self class] dynamicColorWithLightVariant:self.class.ecoGreen darkVariant:self.class.ecoGreen];
}

+ (UIColor *)corePrimaryColor {
    return [[self class] dynamicColorWithLightVariant:self.class.darkSky darkVariant:self.class.nightSky];
}

+ (UIColor *)lineColor {
    return [[self class] dynamicColorWithLightVariant:self.class.skyGrayTint05 darkVariant:self.class.nightGrey30];
}

+ (UIColor *)primaryColor {
    return [[self class] dynamicColorWithLightVariant:self.class.skyBlue darkVariant:self.class.skyBlueTint01];
}

+ (UIColor *)scrimColor {
    return [[self class] dynamicColorWithLightVariant:self.class.blackAlpha70 darkVariant:self.class.blackAlpha70];
}

+ (UIColor *)statusDangerFillColor {
    return [[self class] dynamicColorWithLightVariant:self.class.pinkMuted darkVariant:self.class.nightPink];
}

+ (UIColor *)statusDangerSpotColor {
    return [[self class] dynamicColorWithLightVariant:self.class.berry darkVariant:self.class.nightBerry];
}

+ (UIColor *)statusSuccessFillColor {
    return [[self class] dynamicColorWithLightVariant:self.class.greenMuted darkVariant:self.class.nightGreenFill];
}

+ (UIColor *)statusSuccessSpotColor {
    return [[self class] dynamicColorWithLightVariant:self.class.greenSpot darkVariant:self.class.nightGreenSpot];
}

+ (UIColor *)statusWarningFillColor {
    return [[self class] dynamicColorWithLightVariant:self.class.yellowMuted darkVariant:self.class.nightYellowFill];
}

+ (UIColor *)statusWarningSpotColor {
    return [[self class] dynamicColorWithLightVariant:self.class.amberSpot darkVariant:self.class.nightYellowSpot];
}

+ (UIColor *)surfaceContrastColor {
    return [[self class] dynamicColorWithLightVariant:self.class.darkSky darkVariant:self.class.nightGrey20];
}

+ (UIColor *)surfaceDefaultColor {
    return [[self class] dynamicColorWithLightVariant:self.class.white darkVariant:self.class.nightGrey20];
}

+ (UIColor *)surfaceElevatedColor {
    return [[self class] dynamicColorWithLightVariant:self.class.white darkVariant:self.class.nightGrey25];
}

+ (UIColor *)surfaceHighlightColor {
    return [[self class] dynamicColorWithLightVariant:self.class.grey20 darkVariant:self.class.nightGrey25];
}

+ (UIColor *)textDisabledColor {
    return [[self class] dynamicColorWithLightVariant:self.class.blackAlpha20 darkVariant:self.class.whiteAlpha20];
}

+ (UIColor *)textErrorColor {
    return [[self class] dynamicColorWithLightVariant:self.class.berry darkVariant:self.class.nightBerry];
}

+ (UIColor *)textLinkColor {
    return [[self class] dynamicColorWithLightVariant:self.class.skyBlue darkVariant:self.class.nightBlue];
}

+ (UIColor *)textPrimaryColor {
    return [[self class] dynamicColorWithLightVariant:self.class.skyGray darkVariant:self.class.white];
}

+ (UIColor *)textPrimaryOnContrastColor {
    return [[self class] dynamicColorWithLightVariant:self.class.white darkVariant:self.class.white];
}

+ (UIColor *)textQuaternaryColor {
    return [[self class] dynamicColorWithLightVariant:self.class.skyGrayTint03 darkVariant:self.class.blackTint06];
}

+ (UIColor *)textSecondaryColor {
    return [[self class] dynamicColorWithLightVariant:self.class.skyGrayTint02 darkVariant:self.class.skyGrayTint04];
}

+ (UIColor *)textSecondaryOnContrastColor {
    return [[self class] dynamicColorWithLightVariant:self.class.whiteAlpha80 darkVariant:self.class.nightGrey40];
}

+ (UIColor *)textTertiaryColor {
    return [[self class] dynamicColorWithLightVariant:self.class.skyGrayTint03 darkVariant:self.class.blackTint06];
}

+ (UIColor *)clear {
    return UIColor.clearColor;
}

+ (UIColor *)blend:(UIColor*)firstColor with:(UIColor*)secondColor weight:(double)weight {
    double secondColorWeight = 1.0f - weight;

    CIColor *c1 = [[CIColor alloc] initWithColor:firstColor];
    CIColor *c2 = [[CIColor alloc] initWithColor:secondColor];

    double red = c1.red * weight + c2.red * secondColorWeight;
    double green = c1.green * weight + c2.green * secondColorWeight;
    double blue = c1.blue * weight + c2.blue * secondColorWeight;
    double alpha = c1.alpha * weight + c2.alpha * secondColorWeight;

    return [[UIColor alloc]initWithRed:red green:green blue:blue alpha:alpha];
}

+ (NSString *)cacheKeyForColor:(UIColor *)color {
    const CGFloat *colors = CGColorGetComponents( color.CGColor );
    return [NSString stringWithFormat:@"%.05f,%.05f,%.05f", colors[0], colors[1], colors[2]];
}

+ (NSCache<NSString *, UIColor *> *)dynamicColorsCache {
    static dispatch_once_t onceToken;
    static NSCache *_dynamicColorsCache = nil;
    dispatch_once(&onceToken, ^{
        _dynamicColorsCache = [[NSCache alloc] init];
    });

    return _dynamicColorsCache;
}

+ (UIColor *)dynamicColorWithLightVariant:(UIColor *)lightVariant darkVariant:(UIColor *)darkVariant {
#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 13.0, *)) {
        NSString *cacheKey = [NSString stringWithFormat:@"%@_%@", [self cacheKeyForColor:lightVariant], [self cacheKeyForColor:darkVariant]];
        UIColor *potentialCacheHit = [[self dynamicColorsCache] objectForKey:cacheKey];

        if (potentialCacheHit) {
            return potentialCacheHit;
        }

        UIColor *newDynamicColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return darkVariant;
                } else {
                    return lightVariant;
                }
        }];

        [[self dynamicColorsCache] setObject:newDynamicColor forKey:cacheKey];
        return newDynamicColor;
    }
#endif
  return lightVariant;
}

@end
// clang-format
