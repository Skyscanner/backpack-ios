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
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BPKFontStyle) {

    BPKFontStyleTextBase = 0,
    BPKFontStyleTextBaseEmphasized = 1,
    BPKFontStyleTextLg = 2,
    BPKFontStyleTextLgEmphasized = 3,
    BPKFontStyleTextSm = 4,
    BPKFontStyleTextSmEmphasized = 5,
    BPKFontStyleTextXl = 6,
    BPKFontStyleTextXlEmphasized = 7,
    BPKFontStyleTextXs = 8,
    BPKFontStyleTextXsEmphasized = 9,
};

NS_ASSUME_NONNULL_BEGIN
@class UIFont;
/**
 * BPKFont is the entry point for the Backpack typography stack. It expose the
 * supported text styles as static methods.
*/
NS_SWIFT_NAME(Font) @interface BPKFont: NSObject
+ (UIFont * _Nullable)fontWithStyle:(BPKFontStyle)style  NS_SWIFT_NAME(makeFont(style:));

/**
 * The `textBase` text style from the Backpack typograhpy stack.
*/
+ (UIFont *)textBase;

/**
 * The `textBaseEmphasized` text style from the Backpack typograhpy stack.
*/
+ (UIFont *)textBaseEmphasized;

/**
 * The `textLg` text style from the Backpack typograhpy stack.
*/
+ (UIFont *)textLg;

/**
 * The `textLgEmphasized` text style from the Backpack typograhpy stack.
*/
+ (UIFont *)textLgEmphasized;

/**
 * The `textSm` text style from the Backpack typograhpy stack.
*/
+ (UIFont *)textSm;

/**
 * The `textSmEmphasized` text style from the Backpack typograhpy stack.
*/
+ (UIFont *)textSmEmphasized;

/**
 * The `textXl` text style from the Backpack typograhpy stack.
*/
+ (UIFont *)textXl;

/**
 * The `textXlEmphasized` text style from the Backpack typograhpy stack.
*/
+ (UIFont *)textXlEmphasized;

/**
 * The `textXs` text style from the Backpack typograhpy stack.
*/
+ (UIFont *)textXs;

/**
 * The `textXsEmphasized` text style from the Backpack typograhpy stack.
*/
+ (UIFont *)textXsEmphasized;

@end
NS_ASSUME_NONNULL_END
