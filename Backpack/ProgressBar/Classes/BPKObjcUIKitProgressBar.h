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
#import <UIKit/UIKit.h>

#ifdef SWIFT_PACKAGE
#import "../../Font/Classes/Font.h"
#else
#import <Backpack/Font.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKObjcUIKitProgressBar` is a lightweight subclass of `UIProgressView` with Skyscanner styling applied.
 */
DEPRECATED_MSG_ATTRIBUTE("BPKObjcUIKitProgressBar is deprecated. Use the SwiftUI BPKProgressBar instead.")
IB_DESIGNABLE @interface BPKObjcUIKitProgressBar : UIProgressView

/**
 * The colour to use in the progress track.
 */
@property(nullable, nonatomic, strong) UIColor *fillColor UI_APPEARANCE_SELECTOR;

@end
NS_ASSUME_NONNULL_END
