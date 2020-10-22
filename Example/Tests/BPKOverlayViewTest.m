/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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
#import <Backpack/OverlayView.h>

@interface BPKOverlayViewTest : XCTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKOverlayViewTest

- (void)testDefaultValues {
    BPKOverlayView *ov1 = [[BPKOverlayView alloc] initWithFrame:CGRectZero];
    XCTAssertEqual(ov1.overlayType, BPKOverlayViewOverlayTypeTint);
    XCTAssertEqual(ov1.cornerStyle, BPKOverlayViewCornerStyleNone);
}

- (void)testLazyViews {
    BPKOverlayView *ov1 = [[BPKOverlayView alloc] initWithFrame:CGRectZero];
    XCTAssertEqual(ov1.subviews.count, 0);
    [ov1.foregroundView addSubview:[UIView new]];
    XCTAssertEqual(ov1.subviews.count, 1);
    [ov1.backgroundView addSubview:[UIView new]];
    XCTAssertEqual(ov1.subviews.count, 2);
    [ov1.foregroundView addSubview:[UIView new]];
    XCTAssertEqual(ov1.subviews.count, 2);
    [ov1.backgroundView addSubview:[UIView new]];
    XCTAssertEqual(ov1.subviews.count, 2);
}

@end

NS_ASSUME_NONNULL_END
