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

#ifndef __BACKPACK_BUTTON__
#define __BACKPACK_BUTTON__
#ifndef SWIFT_PACKAGE
// BPKLegacyLinkButton.{h,m} are excluded from the Backpack_ObjC SPM target, so the
// class does not exist in SPM builds. Without this guard the header is still
// reachable through the source tree's header search paths, so consumers type-check
// against a class that is never compiled and fail late with an obscure
// "Undefined symbols: _OBJC_CLASS_$_BPKLegacyLinkButton" at link time, pointing at
// their own file rather than at Backpack. Hiding the declaration turns that into an
// honest compile error naming the deprecated type. Use BPKObjcUIKitButton instead.
#import "BPKLegacyLinkButton.h"
#endif
#import "BPKObjcUIKitButton.h"
#endif
