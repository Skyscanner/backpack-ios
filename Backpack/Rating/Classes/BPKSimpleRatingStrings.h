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

#import "BPKRatingTextDefinition.h"
#import "BPKRatingRange.h"
#import "BPKRatingStrings.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * _Nonnull (^BPKRatingAccessibilityLabel)(BPKRatingRange, double);

@interface BPKSimpleRatingStrings : NSObject<BPKRatingStrings>
@property (nonatomic, strong) BPKRatingTextDefinition *titleText;
@property (nonatomic, strong, nullable) BPKRatingTextDefinition *subtitleText;
@property (nonatomic, strong) BPKRatingAccessibilityLabel accessibilityLabel;

- (instancetype)init __attribute__((unavailable("`init` cannot be used on BPKRatingStrings. Use `initWithTitleText:subtitleText:accessibilityLabel:` instead")));

- (instancetype)initWithTitleText:(BPKRatingTextDefinition *)titleText
                     subtitleText:(nullable BPKRatingTextDefinition *)subtitleText
               accessibilityLabel:(BPKRatingAccessibilityLabel)accessibilityLabel;

@end

NS_ASSUME_NONNULL_END
