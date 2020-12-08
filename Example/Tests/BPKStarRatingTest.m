//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019. Skyscanner Ltd. All rights reserved.
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

#import <XCTest/XCTest.h>

#import <Backpack/StarRating.h>

@interface BPKStarRatingTest : XCTestCase

@end

@implementation BPKStarRatingTest

- (void)test_whenInitialisedWithoutSize_thenSmallSizeIsReturned {
    BPKStarRating *ratingView = [[BPKStarRating alloc] init];

    XCTAssert(ratingView.size == BPKStarSizeSmall, "When initialised with small size then small size should be returned.");
}

- (void)test_whenInitialisedWithSmallSize_thenSmallSizeIsReturned {
    BPKStarRating *ratingView = [[BPKStarRating alloc] initWithSize:BPKStarSizeSmall];

    XCTAssert(ratingView.size == BPKStarSizeSmall, "When initialised with small size then small size should be returned.");
}

- (void)test_whenInitialisedWithLargeSize_thenLargeSizeIsReturned {
    BPKStarRating *ratingView = [[BPKStarRating alloc] initWithSize:BPKStarSizeLarge];

    XCTAssert(ratingView.size == BPKStarSizeLarge, "When initialised with large size then large size should be returned.");
}

- (void)test_whenSizeHasChanged_thenChangedSizeIsReturned {
    BPKStarRating *ratingView = [[BPKStarRating alloc] initWithSize:BPKStarSizeSmall];
    ratingView.size = BPKStarSizeLarge;

    XCTAssert(ratingView.size == BPKStarSizeLarge, "When size has changed then the changed size should be returned.");
}

- (void)test_whenRatingHasNotChanged_thenInitialRatingIsReturned {
    BPKStarRating *ratingView = [[BPKStarRating alloc] initWithSize:BPKStarSizeSmall];

    XCTAssert(ratingView.rating == 0.0f, "When rating hasn't changed then the initial rating should be returned.");
}

- (void)test_whenRatingHasChanged_thenChangedRatingIsReturned {
    BPKStarRating *ratingView = [[BPKStarRating alloc] initWithSize:BPKStarSizeSmall];
    ratingView.rating = 4.3f;

    XCTAssert(ratingView.rating == 4.3f, "When rating has changed then the changed rating should be returned.");
}

@end
