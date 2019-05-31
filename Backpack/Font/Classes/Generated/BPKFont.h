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
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BPKFontStyle) {

    BPKFontStyleTextBase = 0,
    BPKFontStyleTextBaseEmphasized = 1,
    BPKFontStyleTextCaps = 11,
    BPKFontStyleTextCapsEmphasized = 12,
    BPKFontStyleTextLg = 2,
    BPKFontStyleTextLgEmphasized = 3,
    BPKFontStyleTextSm = 4,
    BPKFontStyleTextSmEmphasized = 5,
    BPKFontStyleTextXl = 6,
    BPKFontStyleTextXlEmphasized = 7,
    BPKFontStyleTextXlHeavy = 10,
    BPKFontStyleTextXs = 8,
    BPKFontStyleTextXsEmphasized = 9,
    BPKFontStyleTextXxl = 13,
    BPKFontStyleTextXxlEmphasized = 14,
    BPKFontStyleTextXxlHeavy = 15,
    BPKFontStyleTextXxxl = 16,
    BPKFontStyleTextXxxlEmphasized = 17,
    BPKFontStyleTextXxxlHeavy = 18,
};

NS_ASSUME_NONNULL_BEGIN
@class UIFont;
@class BPKFontMapping;
/**
 * BPKFont is the entry point for the Backpack typography stack. It expose the
 * supported text styles as static methods.
 *
*/
NS_SWIFT_NAME(Font) @interface BPKFont: NSObject

/**
 * Create a dictionary of attributes for a specific text styles. This is some times useful
 * when building custom attributed strings is required.
 *
 * @param fontStyle The desired fontStyle.
 * @param fontMapping The desired font family names to use.
 * @return A dictionary of attributes describing the specified style.
 *
 * @warning Prefer using `BPKLabel` or `BPKTextView` for rendering text when possible.
 */
+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)fontStyle fontMapping:(BPKFontMapping *_Nullable)fontMapping NS_SWIFT_NAME(makeAttributes(fontStyle:fontMapping:));

/**
 * Create a dictionary of attributes for a specific text styles. This is some times useful
 * when building custom attributed strings is required.
 *
 * @param fontStyle The desired fontStyle.
 * @param customAttributes Additional attributes to include in the result. Attributes that would break the Backpack type
 *  rendering are ignored.
 * @param fontMapping The desired font family names to use.
 * @return A dictionary of attributes describing the specified style and custom attributes.
 *
 * @warning Prefer using `BPKLabel` or `BPKTextView` for rendering text when possible.
 */
+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)fontStyle
                                               withCustomAttributes:(NSDictionary<NSAttributedStringKey, id> *)customAttributes fontMapping:(BPKFontMapping *_Nullable)fontMapping NS_SWIFT_NAME(makeAttributes(fontStyle:customAttributes:fontMapping:));

/**
 * Create an attributed string with a specified fontStyle and content. The default Backpack
 * text color will be used.
 *
 * @param fontStyle The desired fontStyle.
 * @param content The content of the attributedString.
 * @param fontMapping The desired font family names to use.
 * @return An attributed string with the specified styles.
 *
 * @warning Prefer using `BPKLabel` or `BPKTextView` for rendering text when possible.
 */
+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle content:(NSString *)content fontMapping:(BPKFontMapping *_Nullable)fontMapping NS_SWIFT_NAME(makeAttributedString(fontStyle:content:fontMapping:));

/**
 * Create an attributed string with a specified fontStyle, content, and text color.
 *
 * @param fontStyle The desired fontStyle.
 * @param content The content of the attributedString.
 * @param textColor The text color to use.
 * @param fontMapping The desired font family names to use.
 * @return An attributed string with the specified styles.
 *
 * @warning Prefer using `BPKLabel` or `BPKTextView` for rendering text when possible.
 */
+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle content:(NSString *)content textColor:(UIColor *)textColor fontMapping:(BPKFontMapping *_Nullable)fontMapping NS_SWIFT_NAME(makeAttributedString(fontStyle:content:textColor:fontMapping:));
@end
NS_ASSUME_NONNULL_END
// clang-format on
