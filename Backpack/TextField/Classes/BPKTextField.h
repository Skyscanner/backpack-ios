/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import "Font.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKTextField` is a subclass of `UITextField` which uses the Skyscanner style.
 */
IB_DESIGNABLE @interface BPKTextField : UITextField

/**
 * Create a `BPKTextField` with a specific BPKFont style.
 *
 * @param style Font style to be used by the TextField.
 * @see BPKFontStyle
 */
- (instancetype)initWithFontStyle:(BPKFontStyle)style NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 The font style used for the TextField.

 @see BPKFontStyle for the integer values to use when setting from Interface Builder.
 */
@property(nonatomic) BPKFontStyle fontStyle;
@end
NS_ASSUME_NONNULL_END
