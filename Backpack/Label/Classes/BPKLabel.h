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

// This header is a private SPM-only shim. It declares the ObjC interface for
// BPKLabel so that other ObjC source files in Backpack_ObjC can compile against
// it. The actual implementation lives in BPKLabel.swift (Backpack Swift target).
//
// IMPORTANT: This header must NOT be in SPMObjCHeaders/ (the public headers
// directory) because that would expose it to the Swift Backpack target via
// module import, causing a conflict with the Swift class definition and
// preventing the Swift compiler from generating _OBJC_CLASS_$_BPKLabel.

#ifdef SWIFT_PACKAGE

#import <UIKit/UIKit.h>
#import "BPKFont.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE @interface BPKLabel : UILabel

@property(nonatomic) BPKFontStyle fontStyle;

- (instancetype)initWithFontStyle:(BPKFontStyle)style NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

- (void)setFontStyle:(BPKFontStyle)fontStyle range:(NSRange)range;

@end

NS_ASSUME_NONNULL_END

#endif
