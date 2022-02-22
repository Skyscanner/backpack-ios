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
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

#import <Backpack/Backpack.h>

#import "BPKSnapshotTest.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKNudgerSnapshotTest : FBSnapshotTestCase
@end

@implementation BPKNudgerSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)createNudgerWithValue:(double)value {
    BPKNudgerConfiguration *nudgerConfiguration = [[BPKNudgerConfiguration alloc]
               initWithLabel:@"Passengers"
               valueFormatter:^(double value) {
            return [NSNumberFormatter localizedStringFromNumber:@(value) numberStyle:NSNumberFormatterDecimalStyle];
        }
    ];

    BPKNudger *view = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];
    view.minimumValue = 1;
    view.maximumValue = 5;
    view.value = value;

    CGSize fittingSize = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);

    return view;
}

- (UIView *)createNudgerWithMinValue {
    return [self createNudgerWithValue:1];
}

- (void)testNudgerWithMinValue {
    UIView *lightView = [self createNudgerWithMinValue];
    UIView *darkView = [self createNudgerWithMinValue];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createNudgerWithMaxValue {
    return [self createNudgerWithValue:5];
}

- (void)testNudgerWithMaxValue {
    UIView *lightView = [self createNudgerWithMaxValue];
    UIView *darkView = [self createNudgerWithMaxValue];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createNudgerWithValueBetweenMinAndMax {
    return [self createNudgerWithValue:2];
}

- (void)testNudgerWithValueBetweenMinAndMax {
    UIView *lightView = [self createNudgerWithValueBetweenMinAndMax];
    UIView *darkView = [self createNudgerWithValueBetweenMinAndMax];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end
NS_ASSUME_NONNULL_END
