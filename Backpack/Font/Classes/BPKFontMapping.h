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
 * `BPKFontMapping` is a subclass of `NSObject`which contains a mapping of font faces to use for different weights.
 * Note that this class is now redundant and will have no effect on BPKFont. It will be removed soon.
 */
NS_SWIFT_NAME(FontMapping) @interface BPKFontMapping : NSObject

- (instancetype)init NS_UNAVAILABLE;

/**
 * Creates a `BPKFontMapping` with the specified font faces
 *
 * @param family the font family
 * @param regularFontFace the font face for regular text
 * @param semiboldFontFace the font face for semi-bold text
 * @param heavyFontFace the font face for heavy text
 * @return `BPKFontMapping` instance.
 */
- (instancetype)initWithFamily:(NSString *)family
               regularFontFace:(NSString *)regularFontFace
              semiboldFontFace:(NSString *)semiboldFontFace
                 heavyFontFace:(NSString *)heavyFontFace NS_DESIGNATED_INITIALIZER;

@property(readonly, nonatomic, strong) NSString *family;
@property(readonly, nonatomic, strong) NSString *regularFontFace;
@property(readonly, nonatomic, strong) NSString *semiboldFontFace;
@property(readonly, nonatomic, strong) NSString *heavyFontFace;

/**
 * The font family to use for a given weight.
 */
- (NSString *)familyForWeight:(UIFontWeight)weight;

@end

NS_ASSUME_NONNULL_END
