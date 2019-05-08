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
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKFontMapping` is a subclass of `NSObject`which contains a mapping of font families to use for different weights.
 */
NS_SWIFT_NAME(FontMapping) IB_DESIGNABLE @interface BPKFontMapping : NSObject

/**
 * Creates a `BPKSwitch` with a decoder (typically when creating from storyboards)
 *
 * @param bold the font family for bold text
 * @param regular the font family for regular text
 * @param heavy the font family for heavy text
 * @return `BPKFontMapping` instance.
 */
- (instancetype)initWithFamily:(NSString *)regular
                withBoldFamily:(NSString *)bold
               withHeavyFamily:(NSString *)heavy NS_DESIGNATED_INITIALIZER;

@property(nonatomic, strong) NSString *regular;
@property(nonatomic, strong) NSString *semibold;
@property(nonatomic, strong) NSString *heavy;
@property(nonatomic, strong) NSString *base;

/**
 * The font family to use for a given weight.
 */
- (NSString *)familyForWeight:(NSString *)weight;

- (NSString *)baseFontFamily;

@end

NS_ASSUME_NONNULL_END
