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
    return [UIColor colorWithRed:0.020 green:0.125 blue:0.235 alpha:1];
}

+ (UIColor *)primaryGradientLight {
    return [UIColor colorWithRed:0.000 green:0.384 blue:0.890 alpha:1];
}

+ (UIColor *)erfoud {
    return [UIColor colorWithRed:0.996 green:0.922 blue:0.529 alpha:1];
}

+ (UIColor *)valensole {
    return [UIColor colorWithRed:0.878 green:0.890 blue:0.898 alpha:1];
}

+ (UIColor *)monteverde {
    return [UIColor colorWithRed:0.047 green:0.514 blue:0.541 alpha:1];
}

+ (UIColor *)skyGrayTint01 {
    return [UIColor colorWithRed:0.329 green:0.345 blue:0.376 alpha:1];
}

+ (UIColor *)black {
    return [UIColor colorWithRed:0.004 green:0.035 blue:0.075 alpha:1];
}

+ (UIColor *)sagano {
    return [UIColor colorWithRed:0.831 green:1.000 blue:0.949 alpha:1];
}

+ (UIColor *)skyGrayTint04 {
    return [UIColor colorWithRed:0.761 green:0.788 blue:0.804 alpha:1];
}

+ (UIColor *)harbour {
    return [UIColor colorWithRed:1.000 green:0.914 blue:0.976 alpha:1];
}

+ (UIColor *)blackTint01 {
    return [UIColor colorWithRed:0.075 green:0.114 blue:0.169 alpha:1];
}

+ (UIColor *)skyGrayTint07 {
    return [UIColor colorWithRed:0.937 green:0.945 blue:0.949 alpha:1];
}

+ (UIColor *)blackTint03 {
    return [UIColor colorWithRed:0.141 green:0.200 blue:0.275 alpha:1];
}

+ (UIColor *)blackTint04 {
    return [UIColor colorWithRed:0.267 green:0.314 blue:0.373 alpha:1];
}

+ (UIColor *)white {
    return [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1];
}

+ (UIColor *)blackTint06 {
    return [UIColor colorWithRed:0.741 green:0.769 blue:0.796 alpha:1];
}

+ (UIColor *)panjin {
    return [UIColor colorWithRed:0.906 green:0.031 blue:0.400 alpha:1];
}

+ (UIColor *)kolkata {
    return [UIColor colorWithRed:0.961 green:0.365 blue:0.259 alpha:1];
}

+ (UIColor *)glencoe {
    return [UIColor colorWithRed:0.384 green:0.945 blue:0.776 alpha:1];
}

+ (UIColor *)bagan {
    return [UIColor colorWithRed:1.000 green:0.969 blue:0.812 alpha:1];
}

+ (UIColor *)hillier {
    return [UIColor colorWithRed:1.000 green:0.392 blue:0.612 alpha:1];
}

+ (UIColor *)skyBlueTint01 {
    return [UIColor colorWithRed:0.518 green:0.914 blue:1.000 alpha:1];
}

+ (UIColor *)skyGray {
    return [UIColor colorWithRed:0.086 green:0.086 blue:0.086 alpha:1];
}

+ (UIColor *)textQuaternaryDarkColor {
    return [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.2];
}

+ (UIColor *)textQuaternaryLightColor {
    return [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.2];
}


+ (UIColor *)skyGrayTint02 {
    return self.class.skyGrayTint01;
}

+ (UIColor *)skyGrayTint03 {
    return self.class.skyGrayTint01;
}

+ (UIColor *)skyGrayTint05 {
    return self.class.skyGrayTint04;
}

+ (UIColor *)skyGrayTint06 {
    return self.class.valensole;
}

+ (UIColor *)blackTint02 {
    return self.class.blackTint01;
}

+ (UIColor *)abisko {
    return self.class.skyBlueShade03;
}

+ (UIColor *)blackTint05 {
    return self.class.blackTint04;
}

+ (UIColor *)tochigi {
    return self.class.skyGrayTint07;
}

+ (UIColor *)petra {
    return self.class.erfoud;
}

+ (UIColor *)skyBlue {
    return self.class.primaryGradientLight;
}

+ (UIColor *)skyBlueTint02 {
    return self.class.valensole;
}

+ (UIColor *)bunol {
    return self.class.kolkata;
}

+ (UIColor *)skyBlueTint03 {
    return self.class.valensole;
}

+ (UIColor *)nara {
    return self.class.bagan;
}

+ (UIColor *)skyBlueShade01 {
    return self.class.primaryGradientLight;
}

+ (UIColor *)skyBlueShade02 {
    return self.class.skyBlueShade03;
}

+ (UIColor *)textPrimaryDarkColor {
    return self.class.white;
}

+ (UIColor *)textPrimaryLightColor {
    return self.class.skyGray;
}

+ (UIColor *)textTertiaryDarkColor {
    return self.class.textQuaternaryDarkColor;
}

+ (UIColor *)textSecondaryDarkColor {
    return self.class.blackTint06;
}

+ (UIColor *)textSecondaryLightColor {
    return self.class.skyGrayTint01;
}

+ (UIColor *)textTertiaryLightColor {
    return self.class.textQuaternaryLightColor;
}

+ (UIColor *)backgroundElevation03DarkColor {
    return self.class.blackTint03;
}

+ (UIColor *)backgroundElevation02DarkColor {
    return self.class.blackTint03;
}

+ (UIColor *)lineDarkColor {
    return self.class.blackTint04;
}

+ (UIColor *)backgroundElevation01DarkColor {
    return self.class.blackTint01;
}

+ (UIColor *)backgroundAlternativeSecondaryDarkColor {
    return self.class.black;
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
    return self.class.skyGrayTint04;
}

+ (UIColor *)backgroundElevation02LightColor {
    return self.class.white;
}

+ (UIColor *)backgroundElevation03LightColor {
    return self.class.white;
}

+ (UIColor *)backgroundTertiaryDarkColor {
    return self.class.black;
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
    return self.class.blackTint01;
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
                                          darkVariant:[UIColor colorWithRed:0.004 green:0.035 blue:0.075 alpha:1]];
}

+ (UIColor *)canvasContrastColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.937 green:0.945 blue:0.949 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.004 green:0.035 blue:0.075 alpha:1]];
}

+ (UIColor *)coreEcoColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.059 green:0.631 blue:0.663 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.059 green:0.631 blue:0.663 alpha:1]];
}

+ (UIColor *)coreAccentColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.384 blue:0.890 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.518 green:0.914 blue:1.000 alpha:1]];
}

+ (UIColor *)corePrimaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.020 green:0.125 blue:0.235 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.020 green:0.255 blue:0.518 alpha:1]];
}

+ (UIColor *)statusSuccessSpotColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.047 green:0.514 blue:0.541 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.384 green:0.945 blue:0.776 alpha:1]];
}

+ (UIColor *)statusSuccessFillColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.831 green:1.000 blue:0.949 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.694 green:1.000 blue:0.906 alpha:1]];
}

+ (UIColor *)statusDangerSpotColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.906 green:0.031 blue:0.400 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:0.392 blue:0.612 alpha:1]];
}

+ (UIColor *)statusWarningSpotColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.961 green:0.365 blue:0.259 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.996 green:0.922 blue:0.529 alpha:1]];
}

+ (UIColor *)statusDangerFillColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:0.914 blue:0.976 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:0.792 blue:0.867 alpha:1]];
}

+ (UIColor *)statusWarningFillColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:0.969 blue:0.812 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.984 green:0.945 blue:0.733 alpha:1]];
}

+ (UIColor *)surfaceContrastColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.020 green:0.125 blue:0.235 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.004 green:0.035 blue:0.075 alpha:1]];
}

+ (UIColor *)surfaceDefaultColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.075 green:0.114 blue:0.169 alpha:1]];
}

+ (UIColor *)surfaceElevatedColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.141 green:0.200 blue:0.275 alpha:1]];
}

+ (UIColor *)surfaceHighlightColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.878 green:0.890 blue:0.898 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.141 green:0.200 blue:0.275 alpha:1]];
}

+ (UIColor *)textOnDarkColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]];
}

+ (UIColor *)textOnLightColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.086 green:0.086 blue:0.086 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.086 green:0.086 blue:0.086 alpha:1]];
}

+ (UIColor *)textDisabledOnDarkColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.5019607843137255] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.5019607843137255]];
}

+ (UIColor *)textLinkColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.384 blue:0.890 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.518 green:0.914 blue:1.000 alpha:1]];
}

+ (UIColor *)textDisabledColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.2] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.2]];
}

+ (UIColor *)textPrimaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.086 green:0.086 blue:0.086 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]];
}

+ (UIColor *)textQuaternaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.2] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.2]];
}

+ (UIColor *)textErrorColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.906 green:0.031 blue:0.400 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:0.392 blue:0.612 alpha:1]];
}

+ (UIColor *)textTertiaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.2] 
                                          darkVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.2]];
}

+ (UIColor *)textSecondaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.329 green:0.345 blue:0.376 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.741 green:0.769 blue:0.796 alpha:1]];
}

+ (UIColor *)textPrimaryInverseColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.086 green:0.086 blue:0.086 alpha:1]];
}

+ (UIColor *)scrimColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.7019607843137254] 
                                          darkVariant:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.7019607843137254]];
}

+ (UIColor *)backgroundElevation03Color {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.141 green:0.200 blue:0.275 alpha:1]];
}

+ (UIColor *)backgroundElevation02Color {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.141 green:0.200 blue:0.275 alpha:1]];
}

+ (UIColor *)lineOnDarkColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0.5019607843137255] 
                                          darkVariant:[UIColor colorWithRed:0.267 green:0.314 blue:0.373 alpha:1]];
}

+ (UIColor *)lineColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.761 green:0.788 blue:0.804 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.267 green:0.314 blue:0.373 alpha:1]];
}

+ (UIColor *)backgroundElevation01Color {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.075 green:0.114 blue:0.169 alpha:1]];
}

+ (UIColor *)backgroundAlternativeSecondaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.004 green:0.035 blue:0.075 alpha:1]];
}

+ (UIColor *)backgroundColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.004 green:0.035 blue:0.075 alpha:1]];
}

+ (UIColor *)backgroundTertiaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.004 green:0.035 blue:0.075 alpha:1]];
}

+ (UIColor *)backgroundSecondaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.937 green:0.945 blue:0.949 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.075 green:0.114 blue:0.169 alpha:1]];
}

+ (UIColor *)backgroundAlternativeColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.937 green:0.945 blue:0.949 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.075 green:0.114 blue:0.169 alpha:1]];
}

+ (UIColor *)primaryColor {
    return [[self class] dynamicColorWithLightVariant:[UIColor colorWithRed:0.000 green:0.384 blue:0.890 alpha:1] 
                                          darkVariant:[UIColor colorWithRed:0.518 green:0.914 blue:1.000 alpha:1]];
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
