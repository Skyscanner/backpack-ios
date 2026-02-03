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

#ifdef SWIFT_PACKAGE
#import "../../Button/Classes/Button.h"
#else
#import <Backpack/Button.h>
#endif
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

DEPRECATED_MSG_ATTRIBUTE("BPKNavigationBarButton is deprecated. Use the SwiftUI BPKNavigationBarItem instead.")
@interface BPKNavigationBarButton : BPKObjcUIKitButton

@property(nonatomic, strong) UIColor *contentColor;

@end

#pragma clang diagnostic pop
NS_ASSUME_NONNULL_END
