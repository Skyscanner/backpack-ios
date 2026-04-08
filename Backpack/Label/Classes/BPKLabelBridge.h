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

// Bridge header for ObjC code that creates or configures BPKLabel instances.
//
// BPKLabel is implemented in Swift. This header provides a unified
// BPKLabelMake() factory for both CocoaPods and SPM:
//
//  - CocoaPods (mixed target): imports Backpack-Swift.h, creates directly.
//  - SPM (separate targets): declares a minimal interface and uses
//    NSClassFromString to avoid a link-time _OBJC_CLASS_$_BPKLabel
//    reference that would fail due to the cross-target dependency.

#ifndef BPKLabelBridge_h
#define BPKLabelBridge_h

#import <UIKit/UIKit.h>

#ifdef SWIFT_PACKAGE

#import "BPKFont.h"

@interface BPKLabel : UILabel
@end

@interface BPKLabel (Bridge)
@property(nonatomic) BPKFontStyle fontStyle;
- (nonnull instancetype)initWithFontStyle:(BPKFontStyle)style;
- (void)setFontStyle:(BPKFontStyle)fontStyle range:(NSRange)range;
@end

NS_INLINE BPKLabel * _Nonnull BPKLabelMake(BPKFontStyle style) {
    Class cls = NSClassFromString(@"BPKLabel");
    NSCAssert(cls != nil, @"BPKLabel class not found — ensure the Backpack Swift target is linked");
    return (BPKLabel *)[[cls alloc] initWithFontStyle:style];
}

#else // CocoaPods

#if __has_include(<Backpack/Backpack-Swift.h>)
#import <Backpack/Backpack-Swift.h>
#elif __has_include("Backpack-Swift.h")
#import "Backpack-Swift.h"
#endif

NS_INLINE BPKLabel * _Nonnull BPKLabelMake(BPKFontStyle style) {
    return [[BPKLabel alloc] initWithFontStyle:style];
}

#endif
#endif
