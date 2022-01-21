// clang-format off
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

#import "../BPKFontManager.h"
#import "../BPKFontDefinitionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKFont()
@end

@implementation BPKFont

// I have added this method to BPKFont so that we don't have to expose the full workings of BPKFontManager to consumers.
+ (void)setFontDefinition:(id<BPKFontDefinitionProtocol>_Nullable)fontDefinition {
    [BPKFontManager sharedInstance].fontDefinition = fontDefinition;
}

+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle
                                              content:(NSString *)content {
    NSDictionary *attributes = [self attributesForFontStyle:fontStyle];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:content attributes:attributes];

    return attributedString;
}

+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle
                                              content:(NSString *)content
                                            textColor:(UIColor *)textColor {
    NSMutableDictionary *attributes = [[self attributesForFontStyle:fontStyle] mutableCopy];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:content attributes:[attributes copy]];


    return attributedString;
}

+ (UIFont *)fontForFontStyle:(BPKFontStyle)fontStyle {
    return [self fontForStyle:fontStyle fontManager:[BPKFontManager sharedInstance]];
}

#pragma mark - Private

+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)fontStyle
                                               withCustomAttributes:(NSDictionary<NSAttributedStringKey,id> *)customAttributes {
    return [self attributesForFontStyle:fontStyle withCustomAttributes:customAttributes fontManager:[BPKFontManager sharedInstance]];
}

+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)fontStyle
                                               withCustomAttributes:(NSDictionary<NSAttributedStringKey,id> *)customAttributes
                                                        fontManager:(BPKFontManager *)fontManager {
    NSMutableDictionary<NSAttributedStringKey, id> *attributes = [[self attributesForFontStyle:fontStyle fontManager:fontManager] mutableCopy];

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
    return [self attributesForFontStyle:style fontManager:[BPKFontManager sharedInstance]];
}

+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)style fontManager:(BPKFontManager *)fontManager {

    UIFont *font = [self fontForStyle:style fontManager:fontManager];
    NSDictionary *result = @{
                   NSForegroundColorAttributeName: BPKColor.textPrimaryColor,
                   NSFontAttributeName: font,
                   };

    return result;
}

+ (UIFont *)fontForStyle:(BPKFontStyle)style fontManager:(BPKFontManager *)fontManager {
    switch (style) {
       
           case BPKFontStyleTextBase:
             return [fontManager regularFontWithSize:16];
             
           case BPKFontStyleTextBaseEmphasized:
             return [fontManager semiboldFontWithSize:16];
             
           case BPKFontStyleTextCaps:
             return [fontManager regularFontWithSize:10];
             
           case BPKFontStyleTextCapsEmphasized:
             return [fontManager semiboldFontWithSize:10];
             
           case BPKFontStyleTextHero1:
             return [fontManager regularFontWithSize:120];
             
           case BPKFontStyleTextHero2:
             return [fontManager regularFontWithSize:96];
             
           case BPKFontStyleTextHero3:
             return [fontManager regularFontWithSize:76];
             
           case BPKFontStyleTextHero4:
             return [fontManager regularFontWithSize:64];
             
           case BPKFontStyleTextHero5:
             return [fontManager regularFontWithSize:48];
             
           case BPKFontStyleTextLg:
             return [fontManager regularFontWithSize:20];
             
           case BPKFontStyleTextLgEmphasized:
             return [fontManager semiboldFontWithSize:20];
             
           case BPKFontStyleTextSm:
             return [fontManager regularFontWithSize:14];
             
           case BPKFontStyleTextSmEmphasized:
             return [fontManager semiboldFontWithSize:14];
             
           case BPKFontStyleTextXl:
             return [fontManager regularFontWithSize:24];
             
           case BPKFontStyleTextXlEmphasized:
             return [fontManager semiboldFontWithSize:24];
             
           case BPKFontStyleTextXlHeavy:
             return [fontManager heavyFontWithSize:24];
             
           case BPKFontStyleTextXs:
             return [fontManager regularFontWithSize:12];
             
           case BPKFontStyleTextXsEmphasized:
             return [fontManager semiboldFontWithSize:12];
             
           case BPKFontStyleTextXxl:
             return [fontManager regularFontWithSize:32];
             
           case BPKFontStyleTextXxlEmphasized:
             return [fontManager semiboldFontWithSize:32];
             
           case BPKFontStyleTextXxlHeavy:
             return [fontManager heavyFontWithSize:32];
             
           case BPKFontStyleTextXxxl:
             return [fontManager regularFontWithSize:40];
             
           case BPKFontStyleTextXxxlEmphasized:
             return [fontManager semiboldFontWithSize:40];
             
           case BPKFontStyleTextXxxlHeavy:
             return [fontManager heavyFontWithSize:40];
             
            default:
              NSAssert(NO, @"Unknown fontStyle %ld", (unsigned long)style);
    }
}

@end
NS_ASSUME_NONNULL_END
// clang-format on
