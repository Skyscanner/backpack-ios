/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

#import <Backpack/Color.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKColorTest : XCTestCase

@end

@implementation BPKColorTest

- (void)disabled_testColorSubsetExists {
    // Test that a subset of critical color exists
    XCTAssert([BPKColor respondsToSelector:@selector(skyBlue)]);
    XCTAssert([BPKColor respondsToSelector:@selector(monteverde)]);
    XCTAssert([BPKColor respondsToSelector:@selector(panjin)]);
    XCTAssert([BPKColor respondsToSelector:@selector(kolkata)]);
    XCTAssert([BPKColor respondsToSelector:@selector(bunol)]);
    XCTAssert([BPKColor respondsToSelector:@selector(skyGrayTint02)]);
    XCTAssert([BPKColor respondsToSelector:@selector(white)]);
}

- (void)disabled_testColorSubsetHasCorrectValues {
    // NOTE: These comparison don't take colorspace into consideration and could fail for that reason.
    // This is tradeoff, if we change the colorspace we can change these tests
    XCTAssertEqualObjects([BPKColor skyBlue], [UIColor colorWithRed:0.027 green:0.439 blue:0.89 alpha:1]);
    XCTAssertEqualObjects([BPKColor monteverde], [UIColor colorWithRed:0 green:0.651 blue:0.596 alpha:1]);
    XCTAssertEqualObjects([BPKColor panjin], [UIColor colorWithRed:0.82 green:0.263 blue:0.357 alpha:1]);
    XCTAssertEqualObjects([BPKColor kolkata], [UIColor colorWithRed:1 green:0.58 blue:0 alpha:1]);
    XCTAssertEqualObjects([BPKColor bunol], [UIColor colorWithRed:1 green:0.482 blue:0.349 alpha:1]);
    XCTAssertEqualObjects([BPKColor skyGrayTint02], [UIColor colorWithRed:0.408 green:0.412 blue:0.498 alpha:1]);
    XCTAssertEqualObjects([BPKColor white], [UIColor colorWithRed:1 green:1 blue:1 alpha:1]);
}

- (void)disabled_testColorSubsetExistsOnUIColor {
    // Test that a subset of critical color exists
    XCTAssert([UIColor respondsToSelector:@selector(bpk_skyBlue)]);
    XCTAssert([UIColor respondsToSelector:@selector(bpk_monteverde)]);
    XCTAssert([UIColor respondsToSelector:@selector(bpk_panjin)]);
    XCTAssert([UIColor respondsToSelector:@selector(bpk_kolkata)]);
    XCTAssert([UIColor respondsToSelector:@selector(bpk_bunol)]);
    XCTAssert([UIColor respondsToSelector:@selector(bpk_skyGrayTint02)]);
    XCTAssert([UIColor respondsToSelector:@selector(bpk_white)]);
}

- (void)disabled_testColorSubsetHasCorrectValuesOnUIColor {
    // NOTE: These comparison don't take colorspace into consideration and could fail for that reason.
    // This is tradeoff, if we change the colorspace we can change these tests
    XCTAssertEqualObjects([UIColor bpk_skyBlue], [UIColor colorWithRed:0.027 green:0.439 blue:0.89 alpha:1]);
    XCTAssertEqualObjects([UIColor bpk_monteverde], [UIColor colorWithRed:0 green:0.651 blue:0.596 alpha:1]);
    XCTAssertEqualObjects([UIColor bpk_panjin], [UIColor colorWithRed:0.82 green:0.263 blue:0.357 alpha:1]);
    XCTAssertEqualObjects([UIColor bpk_kolkata], [UIColor colorWithRed:1 green:0.58 blue:0 alpha:1]);
    XCTAssertEqualObjects([UIColor bpk_bunol], [UIColor colorWithRed:1 green:0.482 blue:0.349 alpha:1]);
    XCTAssertEqualObjects([UIColor bpk_skyGrayTint02], [UIColor colorWithRed:0.408 green:0.412 blue:0.498 alpha:1]);
    XCTAssertEqualObjects([UIColor bpk_white], [UIColor colorWithRed:1 green:1 blue:1 alpha:1]);
}

@end

NS_ASSUME_NONNULL_END
