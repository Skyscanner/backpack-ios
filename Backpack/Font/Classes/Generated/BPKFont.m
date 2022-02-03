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
    return [self attributedStringWithFontStyle:fontStyle
                                       content:content
                                     textColor:BPKColor.textPrimaryColor];
}

+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle
                                              content:(NSString *)content
                                            textColor:(UIColor *)textColor {
    if (content == nil) { return nil; }
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:content];
    return [self attributedStringWithFontStyle:fontStyle
                                      andColor:textColor
                            onAttributedString:attributedString];
}

+ (UIFont *)fontForFontStyle:(BPKFontStyle)fontStyle {
    return [self fontForStyle:fontStyle fontManager:[BPKFontManager sharedInstance]];
}

#pragma mark - Private

+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)fontStyle
                                               withCustomAttributes:(NSDictionary<NSAttributedStringKey,id> *)customAttributes {
    NSMutableDictionary<NSAttributedStringKey, id> *attributes = [[self attributesForFontStyle:fontStyle fontManager:[BPKFontManager sharedInstance]] mutableCopy];

    for (NSAttributedStringKey key in customAttributes) {
        if ([key isEqualToString:NSKernAttributeName] || [key isEqualToString:NSFontAttributeName] || [key isEqualToString:NSParagraphStyleAttributeName]) {
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
    return [self attributesForFontStyle:style color:BPKColor.textPrimaryColor fontManager:fontManager];
}

+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)style color:(UIColor *)color fontManager:(BPKFontManager *)fontManager {
    NSMutableDictionary<NSAttributedStringKey, id> *attributes = [@{
        NSFontAttributeName: [self fontForStyle:style fontManager:fontManager],
        NSKernAttributeName: [self letterSpacingForStyle:style]} mutableCopy];
    if (color != nil) {
        attributes[NSForegroundColorAttributeName] = color;
    }
    return attributes;
}

+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle andColor:(UIColor *)textColor onAttributedString:(NSAttributedString *)attributedText {
    NSMutableDictionary *attributes = [[self attributesForFontStyle:fontStyle color:textColor fontManager:[BPKFontManager sharedInstance]] mutableCopy];
    NSParagraphStyle *paragraphStyle = [self paragraphStyleOnAttributedString:attributedText forStyle:fontStyle];
    if (paragraphStyle != nil) {
        attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    return [[NSAttributedString alloc] initWithString:attributedText.string attributes:[attributes copy]];
}

+ (NSParagraphStyle *)paragraphStyleOnAttributedString:(NSAttributedString *)attributedText forStyle:(BPKFontStyle)style {
    NSParagraphStyle *existingStyle = [attributedText attribute:NSParagraphStyleAttributeName atIndex: 0 longestEffectiveRange:NULL inRange:NSMakeRange(0, attributedText.length)];
    if (existingStyle == nil) { return nil; }
    NSMutableParagraphStyle *paragraphStyle = [existingStyle mutableCopy];
    UIFont *font = [self fontForFontStyle:style];
    CGFloat lineHeight = [self lineHeightForStyle:style];
    [paragraphStyle setLineSpacing:lineHeight - font.lineHeight];
    return paragraphStyle;
}

+ (UIFont *)fontForStyle:(BPKFontStyle)style fontManager:(BPKFontManager *)fontManager {
    switch (style) {
       
           case BPKFontStyleTextBase:
             return [fontManager regularFontWithSize:16];
             
           case BPKFontStyleTextBaseEmphasized:
             return [fontManager semiboldFontWithSize:16];
             
           case BPKFontStyleTextBodyDefault:
             return [fontManager regularFontWithSize:16];
             
           case BPKFontStyleTextBodyLongform:
             return [fontManager regularFontWithSize:20];
             
           case BPKFontStyleTextCaps:
             return [fontManager regularFontWithSize:10];
             
           case BPKFontStyleTextCapsEmphasized:
             return [fontManager semiboldFontWithSize:10];
             
           case BPKFontStyleTextCaption:
             return [fontManager regularFontWithSize:12];
             
           case BPKFontStyleTextFootnote:
             return [fontManager regularFontWithSize:14];
             
           case BPKFontStyleTextHeading1:
             return [fontManager regularFontWithSize:40];
             
           case BPKFontStyleTextHeading2:
             return [fontManager regularFontWithSize:32];
             
           case BPKFontStyleTextHeading3:
             return [fontManager regularFontWithSize:24];
             
           case BPKFontStyleTextHeading4:
             return [fontManager regularFontWithSize:20];
             
           case BPKFontStyleTextHeading5:
             return [fontManager regularFontWithSize:16];
             
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
             
           case BPKFontStyleTextLabel1:
             return [fontManager regularFontWithSize:16];
             
           case BPKFontStyleTextLabel2:
             return [fontManager regularFontWithSize:14];
             
           case BPKFontStyleTextLg:
             return [fontManager regularFontWithSize:20];
             
           case BPKFontStyleTextLgEmphasized:
             return [fontManager semiboldFontWithSize:20];
             
           case BPKFontStyleTextSm:
             return [fontManager regularFontWithSize:14];
             
           case BPKFontStyleTextSmEmphasized:
             return [fontManager semiboldFontWithSize:14];
             
           case BPKFontStyleTextSubheading:
             return [fontManager regularFontWithSize:24];
             
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

+ (NSNumber *)letterSpacingForStyle:(BPKFontStyle)style {
    switch (style) {
        case BPKFontStyleTextBase: 
            // Corresponding to Letter Spacing BASE
            return @(0.12);
        case BPKFontStyleTextCaps: 
            // Corresponding to Letter Spacing CAPS
            return @(0.28);
        case BPKFontStyleTextHero1: 
            // Corresponding to Letter Spacing TIGHT
            return @(-0.02);
        case BPKFontStyleTextHero2: 
            // Corresponding to Letter Spacing TIGHT
            return @(-0.02);
        case BPKFontStyleTextHero3: 
            // Corresponding to Letter Spacing TIGHT
            return @(-0.02);
        case BPKFontStyleTextHero4: 
            // Corresponding to Letter Spacing TIGHT
            return @(-0.02);
        case BPKFontStyleTextHero5: 
            // Corresponding to Letter Spacing TIGHT
            return @(-0.02);
        case BPKFontStyleTextSm: 
            // Corresponding to Letter Spacing SM
            return @(0.154);
        
        default:
            return @(0); // No Defined Letter Spacing
    }
}

+ (CGFloat)lineHeightForStyle:(BPKFontStyle)style {
    switch (style) {
        case BPKFontStyleTextBase: 
            // Corresponding to Line Height BASE
            return 24;
        case BPKFontStyleTextBaseEmphasized: 
            // Corresponding to Line Height BASE-TIGHT
            return 20;
        case BPKFontStyleTextBodyDefault: 
            // Corresponding to Line Height BASE
            return 24;
        case BPKFontStyleTextBodyLongform: 
            // Corresponding to Line Height LG
            return 28;
        case BPKFontStyleTextCaption: 
            // Corresponding to Line Height XS
            return 16;
        case BPKFontStyleTextFootnote: 
            // Corresponding to Line Height SM
            return 20;
        case BPKFontStyleTextHeading1: 
            // Corresponding to Line Height XXXL
            return 48;
        case BPKFontStyleTextHeading2: 
            // Corresponding to Line Height XXL
            return 40;
        case BPKFontStyleTextHeading3: 
            // Corresponding to Line Height XL-TIGHT
            return 28;
        case BPKFontStyleTextHeading4: 
            // Corresponding to Line Height LG-TIGHT
            return 24;
        case BPKFontStyleTextHeading5: 
            // Corresponding to Line Height BASE-TIGHT
            return 20;
        case BPKFontStyleTextHero1: 
            // Corresponding to Line Height 8XL
            return 120;
        case BPKFontStyleTextHero2: 
            // Corresponding to Line Height 7XL
            return 96;
        case BPKFontStyleTextHero3: 
            // Corresponding to Line Height 6XL
            return 84;
        case BPKFontStyleTextHero4: 
            // Corresponding to Line Height 5XL
            return 72;
        case BPKFontStyleTextHero5: 
            // Corresponding to Line Height XXXXL
            return 56;
        case BPKFontStyleTextLabel1: 
            // Corresponding to Line Height BASE
            return 24;
        case BPKFontStyleTextLabel2: 
            // Corresponding to Line Height SM
            return 20;
        case BPKFontStyleTextLg: 
            // Corresponding to Line Height LG
            return 28;
        case BPKFontStyleTextLgEmphasized: 
            // Corresponding to Line Height LG-TIGHT
            return 24;
        case BPKFontStyleTextSm: 
            // Corresponding to Line Height SM
            return 20;
        case BPKFontStyleTextSmEmphasized: 
            // Corresponding to Line Height SM
            return 20;
        case BPKFontStyleTextSubheading: 
            // Corresponding to Line Height XL
            return 32;
        case BPKFontStyleTextXl: 
            // Corresponding to Line Height XL
            return 32;
        case BPKFontStyleTextXlEmphasized: 
            // Corresponding to Line Height XL-TIGHT
            return 28;
        case BPKFontStyleTextXs: 
            // Corresponding to Line Height XS
            return 16;
        case BPKFontStyleTextXsEmphasized: 
            // Corresponding to Line Height XS
            return 16;
        case BPKFontStyleTextXxlEmphasized: 
            // Corresponding to Line Height XXL
            return 40;
        case BPKFontStyleTextXxxlEmphasized: 
            // Corresponding to Line Height XXXL
            return 48;
        
        default:
            return 0; // No Defined Line Height
    }
}

@end
NS_ASSUME_NONNULL_END
// clang-format on
