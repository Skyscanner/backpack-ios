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
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

#import <Backpack/Backpack-Swift.h>

#import "BPKSnapshotTest.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKBarChartBarSnapshotTest : FBSnapshotTestCase
//- (UIStackView *)createAllVariantsOfSize:(BPKBarChartBarSize)size style:(BPKBarChartBarStyle)style applyTheme:(BOOL)applyTheme;
@end

@implementation BPKBarChartBarSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)createBarDefault {
    BPKBarChartBar *view = [[BPKBarChartBar alloc] initWithFrame:CGRectMake(0, 0, 60, 200)];
    view.title = @"Fri";
    view.subtitle = @"4";

    return view;
}

- (void)testBarDefault {
    UIView *lightView = [self createBarDefault];
    UIView *darkView = [self createBarDefault];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createBarDefaultWithValue {
    BPKBarChartBar *view = [[BPKBarChartBar alloc] initWithFrame:CGRectMake(0, 0, 60, 200)];
    view.title = @"Fri";
    view.subtitle = @"4";
    view.fillValue = 0.7;

    return view;
}

- (void)testBarDefaultWithValue {
    UIView *lightView = [self createBarDefaultWithValue];
    UIView *darkView = [self createBarDefaultWithValue];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createBarDefaultSelected {
    BPKBarChartBar *view = [[BPKBarChartBar alloc] initWithFrame:CGRectMake(0, 0, 60, 200)];
    view.title = @"Fri";
    view.subtitle = @"4";
    view.selected = true;

    return view;
}

- (void)testBarDefaultSelected {
    UIView *lightView = [self createBarDefaultSelected];
    UIView *darkView = [self createBarDefaultSelected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createBarDefaultWithValueSelected {
    BPKBarChartBar *view = [[BPKBarChartBar alloc] initWithFrame:CGRectMake(0, 0, 60, 200)];
    view.title = @"Fri";
    view.subtitle = @"4";
    view.fillValue = 0.7;
    view.selected = true;

    return view;
}

- (void)testBarDefaultWithValueSelected {
    UIView *lightView = [self createBarDefaultWithValueSelected];
    UIView *darkView = [self createBarDefaultWithValueSelected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createBarDefaultWithRealValue {
    BPKBarChartBar *view = [[BPKBarChartBar alloc] initWithFrame:CGRectMake(0, 0, 60, 200)];
    view.title = @"Fri";
    view.subtitle = @"4";
    view.fillValue = 0.7;
    view.realValue = @"£200";

    return view;
}

- (void)testBarDefaultWithRealValue {
    UIView *lightView = [self createBarDefaultWithRealValue];
    UIView *darkView = [self createBarDefaultWithRealValue];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createBarDefaultWithRealValueSelected {
    BPKBarChartBar *view = [[BPKBarChartBar alloc] initWithFrame:CGRectMake(0, 0, 60, 200)];
    view.title = @"Fri";
    view.subtitle = @"4";
    view.fillValue = 0.7;
    view.realValue = @"£200";
    view.selected = true;

    return view;
}

- (void)testBarDefaultWithValueRealSelected {
    UIView *lightView = [self createBarDefaultWithRealValueSelected];
    UIView *darkView = [self createBarDefaultWithRealValueSelected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end
NS_ASSUME_NONNULL_END
