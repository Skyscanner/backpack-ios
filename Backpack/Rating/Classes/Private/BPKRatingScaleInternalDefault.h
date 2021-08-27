/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import "BPKRatingScaleInternal.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKRatingScaleInternalDefault : NSObject <BPKRatingScaleInternal>

- (instancetype)init __attribute__((unavailable("`init` cannot be used on BPKRatingStrings. Use one of the static methods instead")));

+ (instancetype)make0to5scale;
+ (instancetype)make0to10scale;

@end

NS_ASSUME_NONNULL_END
