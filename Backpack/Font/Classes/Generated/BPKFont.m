// clang-format off
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
#import "BPKFont.h"

#import <Backpack/Color.h>
#import <Backpack/Theme.h>

#import "../BPKFontMapping.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKFont()
@end

@implementation BPKFont

+ (UIFont * _Nullable)systemFontWithStyle:(BPKFontStyle)style {
    switch (style) {
    
        case BPKFontStyleTextBase:
            return [BPKFont textBase];
        case BPKFontStyleTextBaseEmphasized:
            return [BPKFont textBaseEmphasized];
        case BPKFontStyleTextCaps:
            return [BPKFont textCaps];
        case BPKFontStyleTextCapsEmphasized:
            return [BPKFont textCapsEmphasized];
        case BPKFontStyleTextLg:
            return [BPKFont textLg];
        case BPKFontStyleTextLgEmphasized:
            return [BPKFont textLgEmphasized];
        case BPKFontStyleTextSm:
            return [BPKFont textSm];
        case BPKFontStyleTextSmEmphasized:
            return [BPKFont textSmEmphasized];
        case BPKFontStyleTextXl:
            return [BPKFont textXl];
        case BPKFontStyleTextXlEmphasized:
            return [BPKFont textXlEmphasized];
        case BPKFontStyleTextXlHeavy:
            return [BPKFont textXlHeavy];
        case BPKFontStyleTextXs:
            return [BPKFont textXs];
        case BPKFontStyleTextXsEmphasized:
            return [BPKFont textXsEmphasized];
        case BPKFontStyleTextXxl:
            return [BPKFont textXxl];
        case BPKFontStyleTextXxlEmphasized:
            return [BPKFont textXxlEmphasized];
        case BPKFontStyleTextXxlHeavy:
            return [BPKFont textXxlHeavy];
        case BPKFontStyleTextXxxl:
            return [BPKFont textXxxl];
        case BPKFontStyleTextXxxlEmphasized:
            return [BPKFont textXxxlEmphasized];
        case BPKFontStyleTextXxxlHeavy:
            return [BPKFont textXxxlHeavy];
    }

    return nil;
}


+ (UIFont *)textBase {
    return [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
}

+ (UIFont *)textBaseEmphasized {
    return [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
}

+ (UIFont *)textCaps {
    return [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
}

+ (UIFont *)textCapsEmphasized {
    return [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
}

+ (UIFont *)textLg {
    return [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
}

+ (UIFont *)textLgEmphasized {
    return [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
}

+ (UIFont *)textSm {
    return [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
}

+ (UIFont *)textSmEmphasized {
    return [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
}

+ (UIFont *)textXl {
    return [UIFont systemFontOfSize:24 weight:UIFontWeightRegular];
}

+ (UIFont *)textXlEmphasized {
    return [UIFont systemFontOfSize:24 weight:UIFontWeightSemibold];
}

+ (UIFont *)textXlHeavy {
    return [UIFont systemFontOfSize:24 weight:UIFontWeightHeavy];
}

+ (UIFont *)textXs {
    return [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
}

+ (UIFont *)textXsEmphasized {
    return [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
}

+ (UIFont *)textXxl {
    return [UIFont systemFontOfSize:30 weight:UIFontWeightRegular];
}

+ (UIFont *)textXxlEmphasized {
    return [UIFont systemFontOfSize:30 weight:UIFontWeightSemibold];
}

+ (UIFont *)textXxlHeavy {
    return [UIFont systemFontOfSize:30 weight:UIFontWeightHeavy];
}

+ (UIFont *)textXxxl {
    return [UIFont systemFontOfSize:36 weight:UIFontWeightRegular];
}

+ (UIFont *)textXxxlEmphasized {
    return [UIFont systemFontOfSize:36 weight:UIFontWeightSemibold];
}

+ (UIFont *)textXxxlHeavy {
    return [UIFont systemFontOfSize:36 weight:UIFontWeightHeavy];
}


+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)style fontMapping:(BPKFontMapping * _Nullable)fontMapping {
    return [self attributesForFontStyle:style];
}

+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle
                                              content:(NSString *)content fontMapping:(BPKFontMapping *_Nullable)fontMapping {
  return [self attributedStringWithFontStyle:fontStyle content:content];
}

+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle
                                              content:(NSString *)content
                                            textColor:(UIColor *)textColor
                                          fontMapping:(BPKFontMapping *_Nullable)fontMapping {
  return [self attributedStringWithFontStyle:fontStyle content:content textColor:textColor fontMapping:fontMapping];
}

+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle
                                              content:(NSString *)content {
    NSDictionary *attributes = [self attributesForFontStyle:fontStyle];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:content attributes:attributes];

    return attributedString;
}

+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)fontStyle
                                               withCustomAttributes:(NSDictionary<NSAttributedStringKey,id> *)customAttributes fontMapping:(BPKFontMapping * _Nullable)fontMapping {
    return [self attributesForFontStyle:fontStyle withCustomAttributes:customAttributes];
}

+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle
                                              content:(NSString *)content
                                            textColor:(UIColor *)textColor {
    NSMutableDictionary *attributes = [[self attributesForFontStyle:fontStyle] mutableCopy];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:content attributes:[attributes copy]];


    return attributedString;
}

#pragma mark - Private

+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)fontStyle
                                               withCustomAttributes:(NSDictionary<NSAttributedStringKey,id> *)customAttributes {
    NSMutableDictionary<NSAttributedStringKey, id> *attributes = [[self attributesForFontStyle:fontStyle] mutableCopy];

    for (NSAttributedStringKey key in customAttributes) {
        if ([key isEqualToString:NSKernAttributeName] || [key isEqualToString:NSFontAttributeName]) {
            // We explicitly ignore these as they would change the look of the rendered text significantly
            // enough that it would no longer be the Backpack style.
            continue;
        }

        [attributes setObject:customAttributes[key] forKey:key];
    }

    return [attributes copy];
}

+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)style {
    UIFont *font = [self fontForStyle:style];
    NSDictionary *result = @{
                   NSForegroundColorAttributeName: BPKColor.textPrimaryColor,
                   NSFontAttributeName: font,
                   };

    return result;
}

+ (UIFont *)fontForStyle:(BPKFontStyle)style {
#ifdef USE_SKYSCANNER_RELATIVE_FONT
    UIFont *font = [self relativeFontForStyle:style];
    NSAssert(font != nil, @"Skyscanner Relative font is not available! Falling back to system fontface.");
    if(font != nil) {
        return font;
    }
#endif
    return [self systemFontWithStyle:style];
}

+ (UIFont *_Nullable)relativeFontForStyle:(BPKFontStyle)style {
    switch (style) {
       
           case BPKFontStyleTextBase:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Book" size:16];
             
           case BPKFontStyleTextBaseEmphasized:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Bold" size:16];
             
           case BPKFontStyleTextCaps:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Book" size:10];
             
           case BPKFontStyleTextCapsEmphasized:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Bold" size:10];
             
           case BPKFontStyleTextLg:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Book" size:20];
             
           case BPKFontStyleTextLgEmphasized:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Bold" size:20];
             
           case BPKFontStyleTextSm:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Book" size:14];
             
           case BPKFontStyleTextSmEmphasized:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Bold" size:14];
             
           case BPKFontStyleTextXl:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Book" size:24];
             
           case BPKFontStyleTextXlEmphasized:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Bold" size:24];
             
           case BPKFontStyleTextXlHeavy:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Black" size:24];
             
           case BPKFontStyleTextXs:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Book" size:12];
             
           case BPKFontStyleTextXsEmphasized:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Bold" size:12];
             
           case BPKFontStyleTextXxl:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Book" size:30];
             
           case BPKFontStyleTextXxlEmphasized:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Bold" size:30];
             
           case BPKFontStyleTextXxlHeavy:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Black" size:30];
             
           case BPKFontStyleTextXxxl:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Book" size:36];
             
           case BPKFontStyleTextXxxlEmphasized:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Bold" size:36];
             
           case BPKFontStyleTextXxxlHeavy:
             return [UIFont fontWithName:@"SkyscannerRelativeiOS-Black" size:36];
             
            default:
              NSAssert(NO, @"Unknown fontStyle %ld", (unsigned long)style);
    }
}

@end
NS_ASSUME_NONNULL_END
// clang-format on
