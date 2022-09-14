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

+ (UIColor *)skyBlueShade03 {
    return [UIColor colorWithRed:0.008 green:0.071 blue:0.173 alpha:1];
}

+ (UIColor *)primaryGradientLight {
    return [UIColor colorWithRed:0.027 green:0.439 blue:0.890 alpha:1];
}

+ (UIColor *)erfoud {
    return [UIColor colorWithRed:1.000 green:0.710 blue:0.302 alpha:1];
}

+ (UIColor *)valensole {
    return [UIColor colorWithRed:0.647 green:0.608 blue:0.784 alpha:1];
}

+ (UIColor *)monteverde {
    return [UIColor colorWithRed:0.000 green:0.651 blue:0.596 alpha:1];
}

+ (UIColor *)skyGrayTint01 {
    return [UIColor colorWithRed:0.267 green:0.271 blue:0.376 alpha:1];
}

+ (UIColor *)black {
    return [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1];
}

+ (UIColor *)skyGrayTint02 {
    return [UIColor colorWithRed:0.408 green:0.412 blue:0.498 alpha:1];
}

+ (UIColor *)sagano {
    return [UIColor colorWithRed:0.816 green:0.933 blue:0.925 alpha:1];
}

+ (UIColor *)skyGrayTint03 {
    return [UIColor colorWithRed:0.561 green:0.565 blue:0.627 alpha:1];
}

+ (UIColor *)skyGrayTint04 {
    return [UIColor colorWithRed:0.698 green:0.698 blue:0.749 alpha:1];
}

+ (UIColor *)harbour {
    return [UIColor colorWithRed:0.965 green:0.867 blue:0.882 alpha:1];
}

+ (UIColor *)skyGrayTint05 {
    return [UIColor colorWithRed:0.804 green:0.804 blue:0.843 alpha:1];
}

+ (UIColor *)skyGrayTint06 {
    return [UIColor colorWithRed:0.867 green:0.867 blue:0.898 alpha:1];
}

+ (UIColor *)blackTint01 {
    return [UIColor colorWithRed:0.114 green:0.106 blue:0.125 alpha:1];
}

+ (UIColor *)skyGrayTint07 {
    return [UIColor colorWithRed:0.945 green:0.949 blue:0.973 alpha:1];
}

+ (UIColor *)blackTint02 {
    return [UIColor colorWithRed:0.173 green:0.173 blue:0.180 alpha:1];
}

+ (UIColor *)abisko {
    return [UIColor colorWithRed:0.353 green:0.282 blue:0.608 alpha:1];
}

+ (UIColor *)blackTint03 {
    return [UIColor colorWithRed:0.227 green:0.227 blue:0.235 alpha:1];
}

+ (UIColor *)blackTint04 {
    return [UIColor colorWithRed:0.282 green:0.282 blue:0.290 alpha:1];
}

+ (UIColor *)white {
    return [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1];
}

+ (UIColor *)blackTint05 {
    return [UIColor colorWithRed:0.388 green:0.388 blue:0.400 alpha:1];
}

+ (UIColor *)blackTint06 {
    return [UIColor colorWithRed:0.557 green:0.557 blue:0.576 alpha:1];
}

+ (UIColor *)panjin {
    return [UIColor colorWithRed:0.820 green:0.263 blue:0.357 alpha:1];
}

+ (UIColor *)kolkata {
    return [UIColor colorWithRed:1.000 green:0.580 blue:0.000 alpha:1];
}

+ (UIColor *)glencoe {
    return [UIColor colorWithRed:0.451 green:0.808 blue:0.776 alpha:1];
}

+ (UIColor *)tochigi {
    return [UIColor colorWithRed:0.882 green:0.867 blue:0.925 alpha:1];
}

+ (UIColor *)petra {
    return [UIColor colorWithRed:1.000 green:0.671 blue:0.584 alpha:1];
}

+ (UIColor *)bagan {
    return [UIColor colorWithRed:1.000 green:0.922 blue:0.816 alpha:1];
}

+ (UIColor *)hillier {
    return [UIColor colorWithRed:0.882 green:0.545 blue:0.588 alpha:1];
}

+ (UIColor *)skyBlueTint01 {
    return [UIColor colorWithRed:0.427 green:0.624 blue:0.922 alpha:1];
}

+ (UIColor *)skyBlueTint02 {
    return [UIColor colorWithRed:0.616 green:0.753 blue:0.949 alpha:1];
}

+ (UIColor *)bunol {
    return [UIColor colorWithRed:1.000 green:0.482 blue:0.349 alpha:1];
}

+ (UIColor *)skyBlueTint03 {
    return [UIColor colorWithRed:0.804 green:0.875 blue:0.973 alpha:1];
}

+ (UIColor *)skyGray {
    return [UIColor colorWithRed:0.067 green:0.071 blue:0.212 alpha:1];
}

+ (UIColor *)nara {
    return [UIColor colorWithRed:1.000 green:0.906 blue:0.878 alpha:1];
}

+ (UIColor *)skyBlueShade01 {
    return [UIColor colorWithRed:0.031 green:0.306 blue:0.698 alpha:1];
}

+ (UIColor *)skyBlueShade02 {
    return [UIColor colorWithRed:0.016 green:0.153 blue:0.349 alpha:1];
}


+ (UIColor *)skyBlue {
    return self.class.primaryGradientLight;
}

+ (UIColor *)textPrimaryDarkColor {
    return self.class.white;
}

+ (UIColor *)textQuaternaryDarkColor {
    return self.class.blackTint06;
}

+ (UIColor *)textQuaternaryLightColor {
    return self.class.skyGrayTint03;
}

+ (UIColor *)textPrimaryLightColor {
    return self.class.skyGray;
}

+ (UIColor *)textTertiaryDarkColor {
    return self.class.blackTint06;
}

+ (UIColor *)textSecondaryDarkColor {
    return self.class.skyGrayTint04;
}

+ (UIColor *)textSecondaryLightColor {
    return self.class.skyGrayTint02;
}

+ (UIColor *)textTertiaryLightColor {
    return self.class.skyGrayTint03;
}

+ (UIColor *)backgroundElevation03DarkColor {
    return self.class.blackTint03;
}

+ (UIColor *)backgroundElevation02DarkColor {
    return self.class.blackTint02;
}

+ (UIColor *)lineDarkColor {
    return self.class.blackTint04;
}

+ (UIColor *)backgroundElevation01DarkColor {
    return self.class.blackTint01;
}

+ (UIColor *)backgroundAlternativeSecondaryDarkColor {
    return self.class.blackTint01;
}

+ (UIColor *)backgroundLightColor {
    return self.class.white;
}

+ (UIColor *)backgroundDarkColor {
    return self.class.black;
}

+ (UIColor *)backgroundAlternativeSecondaryLightColor {
    return self.class.white;
}

+ (UIColor *)systemGreen {
    return self.class.monteverde;
}

+ (UIColor *)backgroundElevation01LightColor {
    return self.class.white;
}

+ (UIColor *)lineLightColor {
    return self.class.skyGrayTint05;
}

+ (UIColor *)backgroundElevation02LightColor {
    return self.class.white;
}

+ (UIColor *)backgroundElevation03LightColor {
    return self.class.white;
}

+ (UIColor *)backgroundTertiaryDarkColor {
    return self.class.blackTint02;
}

+ (UIColor *)backgroundSecondaryDarkColor {
    return self.class.blackTint01;
}

+ (UIColor *)backgroundAlternativeLightColor {
    return self.class.skyGrayTint07;
}

+ (UIColor *)primaryDarkColor {
    return self.class.skyBlueTint01;
}

+ (UIColor *)systemRed {
    return self.class.panjin;
}

+ (UIColor *)backgroundAlternativeDarkColor {
    return self.class.black;
}

+ (UIColor *)primaryLightColor {
    return self.class.primaryGradientLight;
}

+ (UIColor *)backgroundTertiaryLightColor {
    return self.class.white;
}

+ (UIColor *)backgroundSecondaryLightColor {
    return self.class.skyGrayTint07;
}

+ (UIColor *)shadowSmColor {
    return self.class.skyGray;
}

+ (UIColor *)shadowLgColor {
    return self.class.skyGray;
}

+ (UIColor *)touchableOverlayColor {
    return self.class.skyGray;
}


+ (UIColor *)canvasColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1]];
}

+ (UIColor *)canvasContrastColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.945 green:0.949 blue:0.973 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.114 green:0.106 blue:0.125 alpha:1]];
}

+ (UIColor *)coreEcoColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.059 green:0.631 blue:0.663 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.059 green:0.631 blue:0.663 alpha:1]];
}

+ (UIColor *)coreAccentColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.027 green:0.439 blue:0.890 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.427 green:0.624 blue:0.922 alpha:1]];
}

+ (UIColor *)corePrimaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.008 green:0.071 blue:0.173 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.020 green:0.255 blue:0.518 alpha:1]];
}

+ (UIColor *)statusSuccessSpotColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.651 blue:0.596 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.000 green:0.651 blue:0.596 alpha:1]];
}

+ (UIColor *)statusSuccessFillColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.816 green:0.933 blue:0.925 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.694 green:1.000 blue:0.906 alpha:1]];
}

+ (UIColor *)statusDangerSpotColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.820 green:0.263 blue:0.357 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.820 green:0.263 blue:0.357 alpha:1]];
}

+ (UIColor *)statusWarningSpotColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:0.580 blue:0.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:0.710 blue:0.302 alpha:1]];
}

+ (UIColor *)statusDangerFillColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.965 green:0.867 blue:0.882 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:0.792 blue:0.867 alpha:1]];
}

+ (UIColor *)statusWarningFillColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:0.922 blue:0.816 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.984 green:0.945 blue:0.733 alpha:1]];
}

+ (UIColor *)surfaceContrastColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.008 green:0.071 blue:0.173 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.114 green:0.106 blue:0.125 alpha:1]];
}

+ (UIColor *)surfaceDefaultColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.114 green:0.106 blue:0.125 alpha:1]];
}

+ (UIColor *)surfaceElevatedColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.173 green:0.173 blue:0.180 alpha:1]];
}

+ (UIColor *)surfaceHighlightColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.867 green:0.867 blue:0.898 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.173 green:0.173 blue:0.180 alpha:1]];
}

+ (UIColor *)textOnDarkColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]];
}

+ (UIColor *)textOnLightColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.067 green:0.071 blue:0.212 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.067 green:0.071 blue:0.212 alpha:1]];
}

+ (UIColor *)textLinkColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.027 green:0.439 blue:0.890 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.427 green:0.624 blue:0.922 alpha:1]];
}

+ (UIColor *)textDisabledColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.698 green:0.698 blue:0.749 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.557 green:0.557 blue:0.576 alpha:1]];
}

+ (UIColor *)textPrimaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.067 green:0.071 blue:0.212 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]];
}

+ (UIColor *)textQuaternaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.561 green:0.565 blue:0.627 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.557 green:0.557 blue:0.576 alpha:1]];
}

+ (UIColor *)textErrorColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.820 green:0.263 blue:0.357 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.820 green:0.263 blue:0.357 alpha:1]];
}

+ (UIColor *)textTertiaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.561 green:0.565 blue:0.627 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.557 green:0.557 blue:0.576 alpha:1]];
}

+ (UIColor *)textSecondaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.408 green:0.412 blue:0.498 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.698 green:0.698 blue:0.749 alpha:1]];
}

+ (UIColor *)textPrimaryInverseColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.067 green:0.071 blue:0.212 alpha:1]];
}

+ (UIColor *)scrimColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.008 green:0.071 blue:0.173 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.008 green:0.071 blue:0.173 alpha:1]];
}

+ (UIColor *)backgroundElevation03Color {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.227 green:0.227 blue:0.235 alpha:1]];
}

+ (UIColor *)backgroundElevation02Color {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.173 green:0.173 blue:0.180 alpha:1]];
}

+ (UIColor *)lineColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.804 green:0.804 blue:0.843 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.282 green:0.282 blue:0.290 alpha:1]];
}

+ (UIColor *)backgroundElevation01Color {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.114 green:0.106 blue:0.125 alpha:1]];
}

+ (UIColor *)backgroundAlternativeSecondaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.114 green:0.106 blue:0.125 alpha:1]];
}

+ (UIColor *)backgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1]];
}

+ (UIColor *)backgroundTertiaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.173 green:0.173 blue:0.180 alpha:1]];
}

+ (UIColor *)backgroundSecondaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.945 green:0.949 blue:0.973 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.114 green:0.106 blue:0.125 alpha:1]];
}

+ (UIColor *)backgroundAlternativeColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.945 green:0.949 blue:0.973 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1]];
}

+ (UIColor *)primaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.027 green:0.439 blue:0.890 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.427 green:0.624 blue:0.922 alpha:1]];
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
    return [NSString stringWithFormat:@"%.05f,%.05f,%.05f,%.05f", colors[0], colors[1], colors[2], colors[3]];
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
