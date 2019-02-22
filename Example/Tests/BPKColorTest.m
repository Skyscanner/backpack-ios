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

#import <XCTest/XCTest.h>

#import <Backpack/Color.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKColorTest : XCTestCase

@end

@implementation BPKColorTest

- (void)testColorSubsetExists {
    // Test that a subset of critical color exists
    XCTAssert([BPKColor respondsToSelector:@selector(blue500)]);
    XCTAssert([BPKColor respondsToSelector:@selector(green500)]);
    XCTAssert([BPKColor respondsToSelector:@selector(red500)]);
    XCTAssert([BPKColor respondsToSelector:@selector(yellow500)]);
    XCTAssert([BPKColor respondsToSelector:@selector(pink500)]);
    XCTAssert([BPKColor respondsToSelector:@selector(gray500)]);
    XCTAssert([BPKColor respondsToSelector:@selector(white)]);
}

- (void)testColorSubsetHasCorrectValues {
    // NOTE: These comparison don't take colorspace into consideration and could fail for that reason.
    // This is tradeoff, if we change the colorspace we can change these tests
    XCTAssertEqualObjects([BPKColor blue500], [UIColor colorWithRed:0 green:0.698 blue:0.839 alpha:1]);
    XCTAssertEqualObjects([BPKColor green500], [UIColor colorWithRed:0 green:0.843 blue:0.459 alpha:1]);
    XCTAssertEqualObjects([BPKColor red500], [UIColor colorWithRed:1 green:0.329 blue:0.322 alpha:1]);
    XCTAssertEqualObjects([BPKColor yellow500], [UIColor colorWithRed:1 green:0.733 blue:0 alpha:1]);
    XCTAssertEqualObjects([BPKColor pink500], [UIColor colorWithRed:0.98 green:0.282 blue:0.541 alpha:1]);
    XCTAssertEqualObjects([BPKColor gray500], [UIColor colorWithRed:0.506 green:0.482 blue:0.561 alpha:1]);
    XCTAssertEqualObjects([BPKColor white], [UIColor colorWithRed:1 green:1 blue:1 alpha:1]);
}

@end

NS_ASSUME_NONNULL_END
