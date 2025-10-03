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
#import "BPKFont.h"

#import <Backpack/Color.h>
#import <Backpack/Theme.h>

#import "../BPKFontManager.h"
#import <Backpack_Common/Backpack_Common-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKFont()
@end

@implementation BPKFont

// I have added this method to BPKFont so that we don't have to expose the full workings of BPKFontManager to consumers.
+ (void)setFontDefinition:(id<BPKFontDefinitionProtocol>_Nullable)fontDefinition {
    [BPKFontManager sharedInstance].fontDefinition = fontDefinition;
}

+ (void)setDynamicTypeEnabled:(BOOL)enabled {
    [BPKFontManager sharedInstance].dynamicTypeEnabled = enabled;
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
    return @{
        NSForegroundColorAttributeName: color,
        NSFontAttributeName: [self fontForStyle:style fontManager:fontManager],
        NSKernAttributeName: [self letterSpacingForStyle:style]
    };
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
    NSParagraphStyle *existingStyle = nil;
    if (attributedText.length > 0) {
        existingStyle = [attributedText attribute:NSParagraphStyleAttributeName atIndex: 0 longestEffectiveRange:NULL inRange:NSMakeRange(0, attributedText.length)];
    } else {
        existingStyle = [NSParagraphStyle defaultParagraphStyle];
    }
    if (existingStyle == nil) { return nil; }
    NSMutableParagraphStyle *paragraphStyle = [existingStyle mutableCopy];
    UIFont *font = [self fontForFontStyle:style];
    CGFloat lineHeight = [self lineHeightForStyle:style];
    [paragraphStyle setLineSpacing:lineHeight - font.lineHeight];

    if (![[BPKFontManager sharedInstance] dynamicTypeEnabled]) {
        [paragraphStyle setMinimumLineHeight:font.capHeight];
        [paragraphStyle setMaximumLineHeight:lineHeight];
    }
    return paragraphStyle;
}

+ (UIFont *)fontForStyle:(BPKFontStyle)style fontManager:(BPKFontManager *)fontManager {
    BpkConfiguration *config = [BpkConfiguration shared];

    switch (style) {
    
        case BPKFontStyleTextBaseLarken:
            return [fontManager semiboldFontWithSize:16 textStyle:UIFontTextStyleBody];
                
        case BPKFontStyleTextBodyDefault:
            return [fontManager regularFontWithSize:16 textStyle:UIFontTextStyleBody];
            
        case BPKFontStyleTextBodyLongform:
            return [fontManager regularFontWithSize:20 textStyle:UIFontTextStyleBody];
            
        case BPKFontStyleTextCaption:
            return [fontManager regularFontWithSize:12 textStyle:UIFontTextStyleCaption1];
            
        case BPKFontStyleTextDisplay7:
            return [fontManager heavyFontWithSize:32 textStyle:UIFontTextStyleLargeTitle];
            
        case BPKFontStyleTextEditorial4:
            return [fontManager regularFontWithSize:16 textStyle:UIFontTextStyleBody];
            
        case BPKFontStyleTextEditorial5:
            return [fontManager regularFontWithSize:14 textStyle:UIFontTextStyleBody];
            
        case BPKFontStyleTextEditorial6:
            return [fontManager regularFontWithSize:12 textStyle:UIFontTextStyleBody];
            
        case BPKFontStyleTextFootnote:
            return [fontManager regularFontWithSize:14 textStyle:UIFontTextStyleFootnote];
            
        case BPKFontStyleTextHeading1:
            return config.heading1Config
                    ? config.heading1Config.font
                    : [fontManager semiboldFontWithSize:40 textStyle:UIFontTextStyleTitle1];
                
        case BPKFontStyleTextHeading2:
            return config.heading2Config
                    ? config.heading2Config.font
                    : [fontManager semiboldFontWithSize:32 textStyle:UIFontTextStyleTitle2];
                
        case BPKFontStyleTextHeading3:
            return config.heading3Config
                    ? config.heading3Config.font
                    : [fontManager semiboldFontWithSize:24 textStyle:UIFontTextStyleTitle3];
                
        case BPKFontStyleTextHeading4:
            return config.heading4Config
                    ? config.heading4Config.font
                    : [fontManager semiboldFontWithSize:20 textStyle:UIFontTextStyleTitle3];
                
        case BPKFontStyleTextHeading5:
            return config.heading5Config
                    ? config.heading5Config.font
                    : [fontManager semiboldFontWithSize:16 textStyle:UIFontTextStyleTitle3];
                
        case BPKFontStyleTextHero1:
            return [fontManager semiboldFontWithSize:120 textStyle:UIFontTextStyleLargeTitle];
                
        case BPKFontStyleTextHero2:
            return [fontManager semiboldFontWithSize:96 textStyle:UIFontTextStyleLargeTitle];
                
        case BPKFontStyleTextHero3:
            return [fontManager semiboldFontWithSize:76 textStyle:UIFontTextStyleLargeTitle];
                
        case BPKFontStyleTextHero4:
            return [fontManager semiboldFontWithSize:64 textStyle:UIFontTextStyleLargeTitle];
                
        case BPKFontStyleTextHero5:
            return [fontManager heavyFontWithSize:48 textStyle:UIFontTextStyleLargeTitle];
            
        case BPKFontStyleTextHero6:
            return [fontManager heavyFontWithSize:40 textStyle:UIFontTextStyleLargeTitle];
            
        case BPKFontStyleTextLabel1:
            return [fontManager semiboldFontWithSize:16 textStyle:UIFontTextStyleBody];
                
        case BPKFontStyleTextLabel2:
            return [fontManager semiboldFontWithSize:14 textStyle:UIFontTextStyleBody];
                
        case BPKFontStyleTextLabel3:
            return [fontManager semiboldFontWithSize:12 textStyle:UIFontTextStyleBody];
                
        case BPKFontStyleTextSmLarken:
            return [fontManager semiboldFontWithSize:14 textStyle:UIFontTextStyleFootnote];
                
        case BPKFontStyleTextSubheading:
            return [fontManager regularFontWithSize:24 textStyle:UIFontTextStyleSubheadline];
            
        case BPKFontStyleTextXsLarken:
            return [fontManager semiboldFontWithSize:12 textStyle:UIFontTextStyleCaption1];
                
        default:
            NSAssert(NO, @"Unknown fontStyle %ld", (unsigned long)style);
    }
}

+ (NSNumber *)letterSpacingForStyle:(BPKFontStyle)style {
    
    BpkConfiguration *config = [BpkConfiguration shared];

    switch (style) {
        case BPKFontStyleTextDisplay7:
            // Corresponding to Letter Spacing VDL2_SM
            return @(-1.6);
        case BPKFontStyleTextHeading1:
            // Corresponding to Letter Spacing XS
            return @(config.heading1Config ? config.heading1Config.letterSpacing : 0);
        case BPKFontStyleTextHeading2:
            // Corresponding to Letter Spacing XS
            return @(config.heading2Config ? config.heading2Config.letterSpacing : 0);
        case BPKFontStyleTextHeading3:
            // Corresponding to Letter Spacing XS
            return @(config.heading3Config ? config.heading3Config.letterSpacing : 0);
        case BPKFontStyleTextHeading4:
            // Corresponding to Letter Spacing XS
            return @(config.heading4Config ? config.heading4Config.letterSpacing : 0);
        case BPKFontStyleTextHeading5:
            // Corresponding to Letter Spacing XS
            return @(config.heading5Config ? config.heading5Config.letterSpacing : 0);
        case BPKFontStyleTextHero1:
            // Corresponding to Letter Spacing TIGHT
            return @(-2);
        case BPKFontStyleTextHero2:
            // Corresponding to Letter Spacing TIGHT
            return @(-2);
        case BPKFontStyleTextHero3:
            // Corresponding to Letter Spacing TIGHT
            return @(-2);
        case BPKFontStyleTextHero4:
            // Corresponding to Letter Spacing TIGHT
            return @(-2);
        case BPKFontStyleTextHero5:
            // Corresponding to Letter Spacing TIGHT
            return @(config.hero5Config ? config.hero5Config.letterSpacing : -2);
        case BPKFontStyleTextHero6:
            // Corresponding to Letter Spacing VDL2_MD
            return @(config.hero6Config ? config.hero6Config.letterSpacing : -1);
        default:
            return @(0); // No Defined Letter Spacing
    }

}

+ (CGFloat)lineHeightForStyle:(BPKFontStyle)style {
    switch (style) {
        case BPKFontStyleTextBaseLarken: 
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
        case BPKFontStyleTextDisplay7: 
            // Corresponding to Line Height LG
            return 28;
        case BPKFontStyleTextEditorial4: 
            // Corresponding to Line Height XS
            return 16;
        case BPKFontStyleTextEditorial5: 
            // Corresponding to Line Height XS
            return 16;
        case BPKFontStyleTextEditorial6: 
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
        case BPKFontStyleTextHero6: 
            // Corresponding to Line Height XXXXL
            return 56;
        case BPKFontStyleTextLabel1: 
            // Corresponding to Line Height BASE
            return 24;
        case BPKFontStyleTextLabel2: 
            // Corresponding to Line Height SM
            return 20;
        case BPKFontStyleTextLabel3: 
            // Corresponding to Line Height XS
            return 16;
        case BPKFontStyleTextSmLarken: 
            // Corresponding to Line Height SM
            return 20;
        case BPKFontStyleTextSubheading: 
            // Corresponding to Line Height XL
            return 32;
        case BPKFontStyleTextXsLarken: 
            // Corresponding to Line Height XS
            return 16;
        
        default:
            return 0; // No Defined Line Height
    }
}

@end
NS_ASSUME_NONNULL_END
// clang-format on
