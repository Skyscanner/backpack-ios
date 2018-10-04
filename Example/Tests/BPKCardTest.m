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
#import <Backpack/Card.h>

@interface BPKCardTest : XCTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKCardTest

- (void)testInitWithPadded {
    BPKCard *c1 = [[BPKCard alloc] initWithPadded:YES];
    XCTAssertTrue(c1.padded);

    BPKCard *c2 = [[BPKCard alloc] initWithPadded:NO];
    XCTAssertFalse(c2.padded);
}

- (void)testAddSubview {
    BPKCard *c1 = [[BPKCard alloc] initWithPadded:YES];
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    testLabel.text = "TEST";
    c1.addSubview(testLabel);

    XCTAssertTrue(c1.subviews[0] == testLabel);
}

@end

NS_ASSUME_NONNULL_END
