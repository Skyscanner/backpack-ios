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
#import <Backpack/Gradient.h>
#import <Backpack/Color.h>

@interface BPKGradientTest : XCTestCase
@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKGradientTest

- (void)testPrimaryGradientColorsHasCorrectValues {
    // NOTE: These comparison don't take colorspace into consideration and could fail for that reason.
    // This is tradeoff, if we change the colorspace we can change these tests
    BPKGradient *gradient =  [BPKGradient primary];

    NSArray<UIColor *> *expectedColors = @[BPKColor.blue500, BPKColor.primaryGradientLight];
    NSArray<NSValue *> *expectedStops = @[[NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)], [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)]];
    XCTAssertEqualObjects(gradient.colors, expectedColors);
    XCTAssertEqualObjects(gradient.stops, expectedStops);
}

- (void)testGradientColorsHasCorrectValues {
    // NOTE: These comparison don't take colorspace into consideration and could fail for that reason.
    // This is tradeoff, if we change the colorspace we can change these tests
    BPKGradient *gradient =  [BPKGradient primaryWithDirection:BPKGradientDirectionTopRight];
    
    NSArray<UIColor *> *expectedColors = @[BPKColor.blue500, BPKColor.primaryGradientLight];
    NSArray<NSValue *> *expectedStops = @[[NSValue valueWithCGPoint:CGPointMake(0.0, 1.0)], [NSValue valueWithCGPoint:CGPointMake(1.0, 0.0)]];
    
    XCTAssertEqualObjects(gradient.colors, expectedColors);
    XCTAssertEqualObjects(gradient.stops, expectedStops);
}

- (void)testSingleInstancePrimaryGradient {
    BPKGradient *first =  [BPKGradient primary];
    BPKGradient *second =  [BPKGradient primary];
    
    XCTAssertEqual(first,second);
}

- (void)testSingleInstanceGradient {
    BPKGradient *first =  [BPKGradient primaryWithDirection:BPKGradientDirectionTopRight];
    BPKGradient *second =  [BPKGradient primaryWithDirection:BPKGradientDirectionTopRight];
    
    XCTAssertEqual(first,second);
}

@end

NS_ASSUME_NONNULL_END
