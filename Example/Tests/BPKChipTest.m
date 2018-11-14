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

#import <Backpack/Chip.h>

@interface BPKChipTest : XCTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKChipTest

- (void)testInitWithFrame {
    BPKChip *c1 = [[BPKChip alloc] initWithFrame:CGRectZero];
    XCTAssertFalse(c1.selected);
    XCTAssertTrue(c1.enabled);
}

- (void)testInitWithTitle {
    BPKChip *c1 = [[BPKChip alloc] initWithTitle:@"Test"];
    XCTAssertFalse(c1.selected);
    XCTAssertTrue(c1.enabled);
    XCTAssertEqual(c1.title, @"Test");
}

- (void)testSetTitle {
    BPKChip *c1 = [[BPKChip alloc] initWithFrame:CGRectZero];
    c1.title = @"Test";
    XCTAssertEqual(c1.title, @"Test");
}

@end

NS_ASSUME_NONNULL_END
