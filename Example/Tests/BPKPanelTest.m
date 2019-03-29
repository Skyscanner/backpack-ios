/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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

#import <Backpack/Panel.h>
#import <XCTest/XCTest.h>

@interface BPKPanelTest : XCTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKPanelTest

- (void)testInitWithPadded {
    BPKPanel *p1 = [[BPKPanel alloc] initWithPadded:YES];
    XCTAssertTrue(p1.padded);

    BPKPanel *p2 = [[BPKPanel alloc] initWithPadded:NO];
    XCTAssertFalse(p2.padded);
}

@end

NS_ASSUME_NONNULL_END
