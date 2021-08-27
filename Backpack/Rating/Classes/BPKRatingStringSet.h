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

#import "BPKRatingRange.h"

NS_ASSUME_NONNULL_BEGIN

@class BPKRating;

/**
 * This protocol describes the behaviour required
 * to provide the required strings for a `BPKRating`.
 *
 * For a convenience a concrete implementation is available that covert
 * most use cases, `BPKSimpleRatingStringSet`.
 *
 * @see BPKSimpleRatingStringSet
 */
@protocol BPKRatingStringSet
@required


/// Decide the title for a given rating range.
/// @param rating The rating instance for which to provide a title.
/// @param range The range for which to provide a title.
/// @return The title for the given rating range.
- (NSString *)rating:(BPKRating *)rating titleFor:(BPKRatingRange)range;

/// Decide the subtitle for a given rating range, if any.
/// @param rating The rating instance for which to provide a subtitle.
/// @param range The range for which to provide a subtitle.
/// @return The subtitle for the given range.
- (nullable NSString *)rating:(BPKRating *)rating subtitleFor:(BPKRatingRange)range;


/// Decide the accessibility label for a given rating.
/// @param rating The rating instance for which to provide an accessibilityLabel.
/// @param range The range for which to provide an accessibilityLabel.
/// @param value The underlying value of the `BPKRating`.
/// @
- (NSString *)rating:(BPKRating *)rating
              accessibilityLabelFor:(BPKRatingRange)range
              value:(double)value;

@end


NS_ASSUME_NONNULL_END
