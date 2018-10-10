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
#import <Backpack/Card.h>
#import <Backpack/Label.h>

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

- (void)testSetPadded {
    BPKCard *c = [[BPKCard alloc] initWithPadded:YES];
    c.padded = NO;
    XCTAssertFalse(c.padded);
}

- (void)testSetSubview {
    BPKCard *c = [[BPKCard alloc] initWithPadded:YES];
    BPKLabel *testLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    testLabel.text = @"TEST";
    [c setSubview:testLabel];
    
    XCTAssertTrue(c.subview == testLabel);
}

- (void)testDividedInitWithPaddedAndWithSubviews {
    UIView *firstInnerView = [[UIView alloc] initWithFrame:CGRectZero];
    UIView *secondInnerView = [[UIView alloc] initWithFrame:CGRectZero];
    firstInnerView.backgroundColor = [BPKColor red500];
    secondInnerView.backgroundColor = [BPKColor green500];
    
    BPKDividedCard *c = [[BPKDividedCard alloc] initWithPrimarySubview:firstInnerView secondarySubview:secondInnerView padded:YES];
    XCTAssertTrue(c.padded);
    XCTAssertTrue(c.primarySubview == firstInnerView);
    XCTAssertTrue(c.secondarySubview == secondInnerView);
}

- (void)testDividedSetPadded {
    UIView *firstInnerView = [[UIView alloc] initWithFrame:CGRectZero];
    UIView *secondInnerView = [[UIView alloc] initWithFrame:CGRectZero];
    firstInnerView.backgroundColor = [BPKColor red500];
    secondInnerView.backgroundColor = [BPKColor green500];
    
    BPKDividedCard *c = [[BPKDividedCard alloc] initWithPrimarySubview:firstInnerView secondarySubview:secondInnerView padded:YES];
    
    c.padded = false;
    XCTAssertFalse(c.padded);
    XCTAssertTrue(c.primarySubview == firstInnerView);
    XCTAssertTrue(c.secondarySubview == secondInnerView);
}

- (void)testDividedInitWithoutPaddedAndWithSubviews {
    UIView *firstInnerView = [[UIView alloc] initWithFrame:CGRectZero];
    UIView *secondInnerView = [[UIView alloc] initWithFrame:CGRectZero];
    firstInnerView.backgroundColor = [BPKColor red500];
    secondInnerView.backgroundColor = [BPKColor green500];
    
    BPKDividedCard *c = [[BPKDividedCard alloc] initWithPrimarySubview:firstInnerView secondarySubview:secondInnerView padded:NO];
    XCTAssertFalse(c.padded);
    XCTAssertTrue(c.primarySubview == firstInnerView);
    XCTAssertTrue(c.secondarySubview == secondInnerView);
}

- (void)testDividedInitWithPaddedAndWithoutSubviews {
    BPKDividedCard *c = [[BPKDividedCard alloc] initWithPadded:YES];
    XCTAssertTrue(c.padded);
}

- (void)testDividedSetSubviews {
    BPKDividedCard *c = [[BPKDividedCard alloc] initWithPadded:YES];
    
    UIView *firstInnerView = [[UIView alloc] initWithFrame:CGRectZero];
    UIView *secondInnerView = [[UIView alloc] initWithFrame:CGRectZero];
    firstInnerView.backgroundColor = [BPKColor red500];
    secondInnerView.backgroundColor = [BPKColor green500];
    
    [c setPrimarySubview:firstInnerView secondarySubview:secondInnerView];
    
    XCTAssertTrue(c.padded);
    XCTAssertTrue(c.primarySubview == firstInnerView);
    XCTAssertTrue(c.secondarySubview == secondInnerView);
}

@end

NS_ASSUME_NONNULL_END
