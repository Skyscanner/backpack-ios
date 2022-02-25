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

#import <XCTest/XCTest.h>

#import <Backpack/Color.h>
#import <Backpack/ProgressBar.h>

@interface BPKProgressBarTest : XCTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKProgressBarTest

- (void)testInitWithFrame {
    BPKProgressBar *pb1 = [[BPKProgressBar alloc] initWithFrame:CGRectZero];
    XCTAssertEqualWithAccuracy(pb1.progress, 0.0, 0.001);
}

- (void)testSetValue {
    BPKProgressBar *pb1 = [[BPKProgressBar alloc] initWithFrame:CGRectZero];
    pb1.progress = 0.76;
    XCTAssertEqualWithAccuracy(pb1.progress, 0.76, 0.001);
}

@end

NS_ASSUME_NONNULL_END
