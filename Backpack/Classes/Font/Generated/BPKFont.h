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

    BPKFontStyleTextBase,
    BPKFontStyleTextBaseEmphasized,
    BPKFontStyleTextLg,
    BPKFontStyleTextLgEmphasized,
    BPKFontStyleTextSm,
    BPKFontStyleTextSmEmphasized,
    BPKFontStyleTextXl,
    BPKFontStyleTextXlEmphasized,
    BPKFontStyleTextXs,
    BPKFontStyleTextXsEmphasized,
};

NS_ASSUME_NONNULL_BEGIN
@class UIFont;
@interface BPKFont: NSObject
+ (UIFont * _Nullable)fontWithStyle:(BPKFontStyle)style;

+ (UIFont *)textBase;

+ (UIFont *)textBaseEmphasized;

+ (UIFont *)textLg;

+ (UIFont *)textLgEmphasized;

+ (UIFont *)textSm;

+ (UIFont *)textSmEmphasized;

+ (UIFont *)textXl;

+ (UIFont *)textXlEmphasized;

+ (UIFont *)textXs;

+ (UIFont *)textXsEmphasized;

@end
NS_ASSUME_NONNULL_END
