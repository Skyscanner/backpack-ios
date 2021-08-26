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

NS_ASSUME_NONNULL_BEGIN
/**
 * A rating range is a name given to a given rating value.
 *
 * A rating range is one of high, medium, or low. What numerical value this corresponds to is determined by the rating scale used.
 *
 * For example, in a 1-5 scale 3 is a medium rating whereas in a 1-10 scale it's low.
 *
 * The rating range is used to decide
 */
typedef NS_ENUM(NSUInteger, BPKRatingRange) {
    /*
     * A low rating.
     */
    BPKRatingRangeLow,

    /*
     * A medium rating.
     */
    BPKRatingRangeMedium,

    /*
     * A high rating.
     */
    BPKRatingRangeHigh,
};

NS_ASSUME_NONNULL_END
