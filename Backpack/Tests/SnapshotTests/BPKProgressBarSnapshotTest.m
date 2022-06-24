/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd. All rights reserved.
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

#import <Backpack/Color.h>
#import <Backpack/ProgressBar.h>

#import "BPKSnapshotTest.h"

@interface BPKProgressBarSnapshotTest : FBSnapshotTestCase

@end

@implementation BPKProgressBarSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)createSettingValueView {
    BPKProgressBar *progressBar = [[BPKProgressBar alloc] initWithFrame:CGRectZero];
    progressBar.progress = 0.75;

    CGSize fittingSize = [progressBar systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    progressBar.frame = CGRectMake(0.0, 0.0, 200, fittingSize.height);

    return progressBar;
}

- (void)testSettingValue {
    UIView *lightView = [self createSettingValueView];
    UIView *darkView = [self createSettingValueView];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createOverridingBackgroundColorView {
    BPKProgressBar *progressBar = [[BPKProgressBar alloc] initWithFrame:CGRectZero];
    progressBar.progress = 0.75;

    progressBar.trackTintColor = BPKColor.clear;

    CGSize fittingSize = [progressBar systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    progressBar.frame = CGRectMake(0.0, 0.0, 200, fittingSize.height);

    return progressBar;
}

- (void)testOverridingBackgroundColor {
    UIView *lightView = [self createOverridingBackgroundColorView];
    UIView *darkView = [self createOverridingBackgroundColorView];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createThemeView {
    BPKProgressBar *progressBar = [[BPKProgressBar alloc] initWithFrame:CGRectZero];
    progressBar.progress = 0.75;

    progressBar.fillColor = UIColor.purpleColor;

    CGSize fittingSize = [progressBar systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    progressBar.frame = CGRectMake(0.0, 0.0, 200, fittingSize.height);

    return progressBar;
}

- (void)testTheme {
    UIView *lightView = [self createThemeView];
    UIView *darkView = [self createThemeView];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end
