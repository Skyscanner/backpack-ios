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
#import <Foundation/Foundation.h>

/**
 * These constants represent the font style.
 */
typedef NS_ENUM(NSUInteger, BPKFontStyle) {


    /**
     * Represents font size 16 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextBase = 0,

    /**
     * Represents font size 16 with weight UIFontWeightBold.
     */
    BPKFontStyleTextBaseEmphasized = 1,

    /**
     * Represents font size 16 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextBodyDefault = 31,

    /**
     * Represents font size 20 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextBodyLongform = 30,

    /**
     * Represents font size 10 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextCaps = 11,

    /**
     * Represents font size 10 with weight UIFontWeightBold.
     */
    BPKFontStyleTextCapsEmphasized = 12,

    /**
     * Represents font size 12 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextCaption = 35,

    /**
     * Represents font size 14 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextFootnote = 34,

    /**
     * Represents font size 40 with weight UIFontWeightBold.
     */
    BPKFontStyleTextHeading1 = 28,

    /**
     * Represents font size 32 with weight UIFontWeightBold.
     */
    BPKFontStyleTextHeading2 = 27,

    /**
     * Represents font size 24 with weight UIFontWeightBold.
     */
    BPKFontStyleTextHeading3 = 26,

    /**
     * Represents font size 20 with weight UIFontWeightBold.
     */
    BPKFontStyleTextHeading4 = 25,

    /**
     * Represents font size 16 with weight UIFontWeightBold.
     */
    BPKFontStyleTextHeading5 = 24,

    /**
     * Represents font size 120 with weight UIFontWeightBold.
     */
    BPKFontStyleTextHero1 = 19,

    /**
     * Represents font size 96 with weight UIFontWeightBold.
     */
    BPKFontStyleTextHero2 = 20,

    /**
     * Represents font size 76 with weight UIFontWeightBold.
     */
    BPKFontStyleTextHero3 = 21,

    /**
     * Represents font size 64 with weight UIFontWeightBold.
     */
    BPKFontStyleTextHero4 = 22,

    /**
     * Represents font size 48 with weight UIFontWeightBold.
     */
    BPKFontStyleTextHero5 = 23,

    /**
     * Represents font size 16 with weight UIFontWeightBold.
     */
    BPKFontStyleTextLabel1 = 33,

    /**
     * Represents font size 14 with weight UIFontWeightBold.
     */
    BPKFontStyleTextLabel2 = 32,

    /**
     * Represents font size 20 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextLg = 2,

    /**
     * Represents font size 20 with weight UIFontWeightBold.
     */
    BPKFontStyleTextLgEmphasized = 3,

    /**
     * Represents font size 14 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextSm = 4,

    /**
     * Represents font size 14 with weight UIFontWeightBold.
     */
    BPKFontStyleTextSmEmphasized = 5,

    /**
     * Represents font size 24 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextSubheading = 29,

    /**
     * Represents font size 24 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextXl = 6,

    /**
     * Represents font size 24 with weight UIFontWeightBold.
     */
    BPKFontStyleTextXlEmphasized = 7,

    /**
     * Represents font size 24 with weight UIFontWeightBlack.
     */
    BPKFontStyleTextXlHeavy = 10,

    /**
     * Represents font size 12 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextXs = 8,

    /**
     * Represents font size 12 with weight UIFontWeightBold.
     */
    BPKFontStyleTextXsEmphasized = 9,

    /**
     * Represents font size 32 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextXxl = 13,

    /**
     * Represents font size 32 with weight UIFontWeightBold.
     */
    BPKFontStyleTextXxlEmphasized = 14,

    /**
     * Represents font size 32 with weight UIFontWeightBlack.
     */
    BPKFontStyleTextXxlHeavy = 15,

    /**
     * Represents font size 40 with weight UIFontWeightRegular.
     */
    BPKFontStyleTextXxxl = 16,

    /**
     * Represents font size 40 with weight UIFontWeightBold.
     */
    BPKFontStyleTextXxxlEmphasized = 17,

    /**
     * Represents font size 40 with weight UIFontWeightBlack.
     */
    BPKFontStyleTextXxxlHeavy = 18,
};

NS_ASSUME_NONNULL_BEGIN
@class UIFont;
@class BPKFontManager;
@protocol BPKFontDefinitionProtocol;
/**
 * BPKFont is the entry point for the Backpack typography stack. It expose the
 * supported text styles as static methods.
 *
*/
@interface BPKFont: NSObject

/**
 * Create a dictionary of attributes for a specific text styles. This is some times useful
 * when building custom attributed strings is required.
 *
 * @param fontStyle The desired fontStyle.
 * @return A dictionary of attributes describing the specified style.
 *
 * @warning Prefer using `BPKLabel`, `BPKTextField`, or `BPKTextView` for rendering text when possible.
 */
+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)fontStyle NS_SWIFT_NAME(makeAttributes(fontStyle:));

/**
 * Create a dictionary of attributes for a specific text styles. This is some times useful
 * when building custom attributed strings is required.
 *
 * @param fontStyle The desired fontStyle.
 * @param fontManager The fontManager instance to use. By default this is `[BPKFontManager sharedInstance]`.
 * @return A dictionary of attributes describing the specified style.
 *
 * @warning Prefer using `BPKLabel`, `BPKTextField`, or `BPKTextView` for rendering text when possible.
 */
+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)fontStyle fontManager:(BPKFontManager *)fontManager NS_SWIFT_NAME(makeAttributes(fontStyle:fontManager:));

/**
 * Create a dictionary of attributes for a specific text styles. This is some times useful
 * when building custom attributed strings is required.
 *
 * @param fontStyle The desired fontStyle.
 * @param customAttributes Additional attributes to include in the result. Attributes that would break the Backpack type
 *  rendering are ignored.
 * @return A dictionary of attributes describing the specified style and custom attributes.
 *
 * @warning Prefer using `BPKLabel`, `BPKTextField`, or `BPKTextView` for rendering text when possible.
 */
+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)fontStyle
                                               withCustomAttributes:(NSDictionary<NSAttributedStringKey, id> *)customAttributes NS_SWIFT_NAME(makeAttributes(fontStyle:customAttributes:));

/**
 * Create an attributed string with a specified fontStyle and content. The default Backpack
 * text color will be used.
 *
 * @param fontStyle The desired fontStyle.
 * @param content The content of the attributedString.
 * @return An attributed string with the specified styles.
 *
 * @warning Prefer using `BPKLabel`, `BPKTextField`, or `BPKTextView` for rendering text when possible.
 */
+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle content:(NSString *)content NS_SWIFT_NAME(makeAttributedString(fontStyle:content:));

/**
 * Create an attributed string with a specified fontStyle, content, and text color.
 *
 * @param fontStyle The desired fontStyle.
 * @param content The content of the attributedString.
 * @param textColor The text color to use.
 * @return An attributed string with the specified styles.
 *
 * @warning Prefer using `BPKLabel`, `BPKTextField`, or `BPKTextView` for rendering text when possible.
 */
+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle content:(NSString *)content textColor:(UIColor *)textColor NS_SWIFT_NAME(makeAttributedString(fontStyle:content:textColor:));

/**
 * Set the fontfaces to use globally.
 *
 * @param fontDefinition The new font definition to use when resolving fontface names.
*/
+ (void)setFontDefinition:(id<BPKFontDefinitionProtocol>_Nullable)fontDefinition;

/**
 * Create a `UIFont` instance for a specific text style.
 *
 *
 * @param fontStyle The desired fontStyle.
 * @return An instance of `UIFont` for the specificed style.
 *
 * @warning Prefer using `BPKLabel`, `BPKTextField`, or `BPKTextView` for rendering text when possible.
 */
+ (UIFont *)fontForFontStyle:(BPKFontStyle)fontStyle NS_SWIFT_NAME(makeFont(fontStyle:));

@end

NS_ASSUME_NONNULL_END
// clang-format on
