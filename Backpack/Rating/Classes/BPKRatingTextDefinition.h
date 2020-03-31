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

NS_ASSUME_NONNULL_BEGIN

/**
 * An object that represents the text displayed inside the rating component.
 */
@interface BPKRatingTextDefinition : NSObject

/**
 * The text to display when the rating value is greather than or equal to 8
 */
@property(nonatomic, copy) NSString *highRatingText;

/**
 * The text to display when the rating value is greather than or equal to 6 and less than 8
 */
@property(nonatomic, copy) NSString *mediumRatingText;

/**
 * The text to display when the rating value is less than 6
 */
@property(nonatomic, copy) NSString *lowRatingText;

/**
 * Create a `BPKRatingTextDefinition` with the given text for the rating values.
 *
 * @param highRatingText The text used in the rating component when it has a high rating value
 * @param mediumRatingText The text used in the rating component when it has a medium rating value
 * @param lowRatingText The text used in the rating component when it has a low rating value
 * @return `BPKRatingTextDefinition` instance.
 */
- (instancetype)initWithHighRatingText:(NSString *)highRatingText
                      mediumRatingText:(NSString *)mediumRatingText
                         lowRatingText:(NSString *)lowRatingText;

@end

NS_ASSUME_NONNULL_END
