/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <XCTest/XCTest.h>

#import <Backpack/Duration.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKDurationTest : XCTestCase

@end

@implementation BPKDurationTest

- (void)testColorSubsetExists {
    // Test that a subset of critical durations exists
    XCTAssert([BPKDuration respondsToSelector:@selector(animationDurationXs)]);
    XCTAssert([BPKDuration respondsToSelector:@selector(animationDurationSm)]);
    XCTAssert([BPKDuration respondsToSelector:@selector(animationDurationBase)]);
}

- (void)testColorSubsetHasCorrectValues {
    XCTAssert([BPKDuration animationDurationXs] == 0.05);
    XCTAssert([BPKDuration animationDurationSm] == 0.2);
    XCTAssert([BPKDuration animationDurationBase] == 0.4);
}

@end

NS_ASSUME_NONNULL_END
