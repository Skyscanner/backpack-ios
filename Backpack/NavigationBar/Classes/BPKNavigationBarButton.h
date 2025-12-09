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

#if __has_include("../../Button/Classes/Button.h")
#import "../../Button/Classes/Button.h"
#else
#import "Button.h"
#endif
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

__attribute__((deprecated("BPKNavigationBarButton is maintenance only; prefer the SwiftUI navigation components")))
@interface BPKNavigationBarButton : BPKButton

@property(nonatomic, strong) UIColor *contentColor;

@end

NS_ASSUME_NONNULL_END
